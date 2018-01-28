# Actualización tablas de mortalidad dinámicas
# Información: 1990 - 2016
# Metodología: Lee - Carter
# Autor: Diego Paul Huaraca S.

libs <- c('readxl', 'sme', 'tidyverse', 'forecast', 'foreign', 'MASS', 
          'tseries','pspline','psych','xtable')
lapply(libs, require, character.only = T)

# setwd("/Volumes/TOSHIBA EXT/Diego/Proyectos/Proyecto_Semilla")

# la data tiene el último registro repetido para mejorar la estimación de la edad 100 por splines
pob_h <- read_excel("datos_estimados.xlsx", sheet = 2)[1:98,]
pob_m <- read_excel("datos_estimados.xlsx", sheet = 3)[1:98,]
defun_h <- read_excel("datos_estimados.xlsx", sheet = 4)[1:98,]
defun_m <- read_excel("datos_estimados.xlsx", sheet = 5)[1:98,]

suavizar <- function(data){
   n_dim <- dim(data)
   data_s <- mat.or.vec(n_dim[1],(n_dim[2]-1))
   for(j in 2:n_dim[2]){
      sp.spline <- smooth.Pspline(x = data[[1]], y = data[[j]], method = 3, norder = 5)
      ajuste <- predict(sp.spline, x = data[[1]])
      data_s[,j-1] <- abs(round(ajuste[1:98],0))
   }
   return(data_s)
}

pob_h <- suavizar(pob_h)[1:98,][1:91,]
pob_m <- suavizar(pob_m)[1:98,][1:91,]

plot(pob_h[,1], col=2, ylim=c(0,160000))
par(new=TRUE)
plot(pob_h[,12], col=3, ylim=c(0,160000))
par(new=TRUE)
plot(pob_h[,21], col=4, ylim=c(0,160000))

defun_h <- suavizar(defun_h)[1:96,][1:91,]
defun_m <- suavizar(defun_m)[1:96,][1:91,]

plot(defun_h[,1], col=2, ylim=c(0,4000))
par(new=TRUE)
plot(defun_h[,12], col=3, ylim=c(0,4000))
par(new=TRUE)
plot(defun_h[,21], col=4, ylim=c(0,4000))

qxt <- function(pob, defun){
   res <- mat.or.vec(91,25) # 91 edades - 26 años (-1 por cálculo)
   for(j in 1:25){
      res[1,j]<-(0.75*defun[1,j]+0.25*defun[1,j+1])/(pob[1,j]+0.75*defun[1,j+1])
      for(i in 2:91){
         res[i,j]<-(0.5*(defun[i,j]+defun[i,j+1]))/(pob[i,j]+0.5*defun[i,j+1])
      }
   }
   return(res)
}

qxt(pob_h, defun_h)
qxt(pob_m, defun_m)

plot(qxt(pob_h, defun_h)[,1], col=2, ylim=c(0,1))
par(new=TRUE)
plot(qxt(pob_h, defun_h)[,12], col=3, ylim=c(0,1))
par(new=TRUE)
plot(qxt(pob_h, defun_h)[,21], col=4, ylim=c(0,1))

mxt <- function(data){
   n_dim <- dim(data)
   res <- mat.or.vec(n_dim[1],n_dim[2])
   for(i in 1:n_dim[1]){
      for(j in 1:n_dim[2]){
         res[i,j]<-(2*data[i,j]/(2-data[i,j]))
      }
   }
   return(res)
}

mxt(qxt(pob_h, defun_h))
mxt(qxt(pob_m, defun_m))

plot(log(mxt(qxt(pob_h, defun_h)))[,1], col=2, ylim=c(-8,0.35))
par(new=TRUE)
plot(log(mxt(qxt(pob_h, defun_h)))[,12], col=3, ylim=c(-8,0.35))
par(new=TRUE)
plot(log(mxt(qxt(pob_h, defun_h)))[,21], col=4, ylim=c(-8,0.35))


# Gráfico 3 dimensiones - Mortalidad
edad <- seq(1,91,by=1)
tiempo <- seq(1,25,by=1)
persp(edad, tiempo, log(mxt(qxt(pob_h, defun_h))), theta=-35, phi=20, expand=0.75, xlab='Edad',
      ylab='Periodo', zlab='ln(qxt)', ticktype="detailed", main='Hombres', zlim=c(-8,0))

persp(edad, tiempo, log(mxt(qxt(pob_m, defun_m))), theta=-35, phi=20, expand=0.75, xlab='Edad',
      ylab='Periodo', zlab='ln(qxt)', ticktype="detailed", main='Mujeres', zlim=c(-8,0))


denuit_r2 <- function(data,x0){
      data.old <- data[(x0+1):91,] # +1 pues empezamos de edad 0
      n_dim <- dim(data.old)
      matrix.old <- mat.or.vec(n_dim[1],n_dim[2])
      coef.adj <- vector(length=n_dim[2])
      vec.rsquared <- vector(length=n_dim[2])
      for(j in 1:ncol(data.old)){
            edad.old <- (90-seq(x0,90,by=1))^2
            lm.old <- lm(log(data.old[,j]) ~ -1+edad.old)
            matrix.old[,j] <- exp(coef(lm.old)*edad.old)
            coef.adj[j] <- coef(lm.old)
            vec.rsquared[j] <- summary.lm(lm.old)$r.squared
      }
      # cat("Coeficientes ajustados :\n", coef.adj, "\n")
      # cat("R Cuadrado ajustados :\n", vec.rsquared, "\n")
      ## ahora unimos las bases y suavizamos por media geom?trica
      return(mean(vec.rsquared))
}

for(i in 65:75){
      res <- denuit_r2(mxt(qxt(pob_h, defun_h)), i)
      cat("R2 Ponderado: ", res, " para ", i, " años\n")
}




denuit <- function(data,x0){
   data.old <- data[(x0+1):91,] # +1 pues empezamos de edad 0
   n_dim <- dim(data.old)
   matrix.old <- mat.or.vec(n_dim[1],n_dim[2])
   coef.adj <- vector(length=n_dim[2])
   vec.rsquared <- vector(length=n_dim[2])
   for(j in 1:ncol(data.old)){
      edad.old <- (90-seq(x0,90,by=1))^2
      lm.old <- lm(log(data.old[,j]) ~ -1+edad.old)
      matrix.old[,j] <- exp(coef(lm.old)*edad.old)
      coef.adj[j] <- coef(lm.old)
      vec.rsquared[j] <- summary.lm(lm.old)$r.squared
   }
   # cat("Coeficientes ajustados :\n", coef.adj, "\n")
   # cat("R Cuadrado ajustados :\n", vec.rsquared, "\n")
   ## ahora unimos las bases y suavizamos por media geom?trica
   new.data <- rbind(data[1:x0,], matrix.old)
   for(j in 1:ncol(new.data)){
      for(i in (x0-4):(x0+4)){
          new.data[i+1,j] <- geometric.mean(c(new.data[(i-4):(i+2),j], 0.8*new.data[(i+5):(i+9),j]))
      }
      for(i in c((x0-6):(x0-2), (x0+2):(x0+6))){
         new.data[i+1,j] <- geometric.mean(c(new.data[c((i-2):(i-1),(i+3):(i+4)),j]))
      }
      for(i in (x0-7):(x0+7)){
         new.data[i+1,j] <- geometric.mean(c(new.data[(i-4):(i+5),j]))
      }
       #new.data[(x0-6):(x0+6),j]<- sort(new.data[(x0-6):(x0+6),j])
   }
   return(new.data)
}


denuit(qxt(pob_h, defun_h), 65)

# Gráfico 3 dimensiones - Mortalidad suavizada
edad <- seq(1,91,by=1)
tiempo <- seq(1,25,by=1)

persp(edad, tiempo, log(denuit(mxt(qxt(pob_h, defun_h)), 70)), theta=-35, phi=20, expand=0.75, xlab='Edad',
      ylab='Periodo', zlab='ln(qxt)', ticktype="detailed", main='Hombres', zlim=c(-7.5,0.1))

persp(edad, tiempo, log(denuit(mxt(qxt(pob_m, defun_m)), 70)), theta=-35, phi=20, expand=0.75, xlab='Edad',
      ylab='Periodo', zlab='ln(qxt)', ticktype="detailed", main='Mujeres', zlim=c(-7.5,0.1))


ax <- function(data){
   n_dim <- dim(data)
   ax.matrix <- matrix(mat.or.vec(n_dim[1],1),nrow=n_dim[1])
   for(i in 1:n_dim[1]){
      ax.matrix[i,1] <- sum(log(data[i,]))/n_dim[2]
   }
   return(ax.matrix)
}

plot(ax(denuit(mxt(qxt(pob_h, defun_h)),70)), type='l', col='2')
par(new=TRUE)
plot(ax(denuit(mxt(qxt(pob_m, defun_m)),70)), type='l', col='3')


svd_est <-function(mxt_data, ax_data){
   n_dim <- dim(mxt_data)
   svd.matrix <- matrix(mat.or.vec(n_dim[1],n_dim[2]),nrow=n_dim[1])
   for(j in 1:n_dim[2]){
      svd.matrix[,j] <- log(mxt_data)[,j]-ax_data[,1]
   }
   est.svd <- svd(svd.matrix)
   svd.list<-list()
   
   est.svd$u <- -1*est.svd$u
   est.svd$v <- -1*est.svd$v
   
   svd.list$s <- est.svd$d/sum(est.svd$d)
   sum.c <- sum(est.svd$u[,1])
   svd.list$k <- sum.c*(est.svd$d[1]*est.svd$v[,1])
   svd.list$b <- est.svd$u[,1]/sum.c
   return(svd.list)
}

plot(svd_est(mxt(qxt(pob_h, defun_h)), ax(denuit(mxt(qxt(pob_h, defun_h)),70)))$b)
plot(svd_est(mxt(qxt(pob_m, defun_m)), ax(denuit(mxt(qxt(pob_m, defun_m)),70)))$b, type='l')
