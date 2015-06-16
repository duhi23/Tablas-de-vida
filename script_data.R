############################
### Tablas de mortalidad ###
###      Script Data     ###
############################

dir.pro <- "/Users/Diego/Desktop/Paper/Tablas Mortalidad"
dir.data <- "/Users/Diego/Desktop/Paper/Datos"

setwd(dir.data)
list.files()

library(haven)
library(data.table)
library(dplyr)

data <- list()

data$def90 <- data.table(read_sav("defuncion1990.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1990)]
data$def91 <- data.table(read_sav("defuncion1991.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1991)]
data$def92 <- data.table(read_sav("defuncion1992.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1992)]
data$def93 <- data.table(read_sav("defuncion1993.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1993)]
data$def94 <- data.table(read_sav("defuncion1994.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1994)]
data$def95 <- data.table(read_sav("defuncion1995.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1995)]
data$def96 <- data.table(read_sav("defuncion1996.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1996)]
data$def97 <- data.table(read_sav("defuncion1997.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1997)]
data$def98 <- data.table(read_sav("defuncion1998.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1998)]
data$def99 <- data.table(read_sav("defuncion1999.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=1999)]
data$def00 <- data.table(read_sav("defuncion2000.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2000)]
data$def01 <- data.table(read_sav("defuncion2001.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2001)]
data$def02 <- data.table(read_sav("defuncion2002.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2002)]
data$def03 <- data.table(read_sav("defuncion2003.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2003)]
data$def04 <- data.table(read_sav("defuncion2004.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2004)]
data$def05 <- data.table(read_sav("defuncion2005.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2005)]
data$def06 <- data.table(read_sav("defuncion2006.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2006)]
data$def07 <- data.table(read_sav("defuncion2007.sav"))[,.(PROV, SEXO, ANON, MESN, ANOF, MESF, EDAD, ANIO=2007)]
data$def08 <- data.table(read_sav("defuncion2008.sav"))[,.(PROV, SEXO, ANION, MESN, ANIOF, MESF, EDAD, ANIO=2008)]
data$def09 <- data.table(read_sav("defuncion2009.sav"))[,.(PROV, SEXO, ANION, MESN, ANIOF, MESF, EDAD, ANIO=2009)]
data$def10 <- data.table(read_sav("defuncion2010.sav"))[,.(prov, sexo, anion, mesn, aniof, mesf, edad, ANIO=2010)]
data$def11 <- data.table(read_sav("defuncion2011.sav"))[,.(prov_insc, sexo, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2011)]
data$def12 <- data.table(read_sav("defuncion2012.sav"))[,.(prov_insc, sexo, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2012)]
data$def13 <- data.table(read_sav("defuncion2013.sav"))[,.(prov_insc, sexo, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2013)]

# Eliminar edades de 999 de la base del 2013

## Lista de defunciones
defun <- lapply(seq_along(data), function(i){table(data[[i]][[7]], data[[i]][[2]])})

lapply(seq_along(data), function(i){max(data[[i]][[7]])})

table(data.table(read_sav("nacimiento1992.sav"))[ANIO_NAC %in% c(1992, 1991),])
table(data.table(read_sav("nacimiento2010.sav"))[,ANIO_NAC])

data.table(read_sav("nacimiento1992.sav"))[ANIO_NAC %in% c(1991, 1992),]


### Datos Censo 2010 ###
library(readxl)
library(data.table)
ls("package:readxl")

setwd(dir.pro)

censo <- data.table(read_excel("censo2010.xlsx"))
censo$Hombre <- as.numeric(censo$Hombre)
censo$Mujer <- as.numeric(censo$Mujer)
censo$Total <- as.numeric(censo$Total)
censo$Edad <- as.numeric(censo$Edad)
# Eliminamos la columna del total
DT[, V1 := NULL]
censo[,Total:=NULL]

summary(censo[,.(Hombre, Mujer)])

## Diferencias de poblacion
plot(censo$Mujer, main='Población 2010', type='l', col="red", xlim=c(0,125), ylim=c(0,200000), 
     xlab='Años', ylab='Casos')
par(new=TRUE)
plot(censo$Hombre, main='Población 2010', type='l', col="green", xlim=c(0,125), ylim=c(0,200000), 
     xlab='Años', ylab='Casos')

### Calculo probabilidad de muerte ###
## Ratios 2010
qxh10 <- c(as.vector(defun[[1]][,1]), numeric(22))/censo$Hombre # Hombres

## Ratios 2011
lxh11 <- censo$Hombre - c(as.vector(defun[[1]][,1]), numeric(22))
qxh11 <- c(as.vector(defun[[2]][,1]), numeric(22))/lxh11

## Ratios 2012
lxh12 <- lxh11 - c(as.vector(defun[[2]][,1]), numeric(22))
qxh12 <- c(as.vector(defun[[3]][,1]), numeric(22))/lxh12


dx10 <- defun[[1]][,1]
colnames(dx10) <- c("H", "M")



setnames(DT,c("V1","V2"), c("V2.rating","V3.DataCamp"))
         



