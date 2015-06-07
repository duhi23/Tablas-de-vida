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

data$def90 <- data.table(read_sav("defuncion1990.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1990)]
data$def91 <- data.table(read_sav("defuncion1991.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1991)]
data$def92 <- data.table(read_sav("defuncion1992.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1992)]
data$def93 <- data.table(read_sav("defuncion1993.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1993)]
data$def94 <- data.table(read_sav("defuncion1994.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1994)]
data$def95 <- data.table(read_sav("defuncion1995.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1995)]
data$def96 <- data.table(read_sav("defuncion1996.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1996)]
data$def97 <- data.table(read_sav("defuncion1997.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1997)]
data$def98 <- data.table(read_sav("defuncion1998.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1998)]
data$def99 <- data.table(read_sav("defuncion1999.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1999)]
data$def00 <- data.table(read_sav("defuncion2000.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2000)]
data$def01 <- data.table(read_sav("defuncion2001.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2001)]
data$def02 <- data.table(read_sav("defuncion2002.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2002)]
data$def03 <- data.table(read_sav("defuncion2003.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2003)]
data$def04 <- data.table(read_sav("defuncion2004.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2004)]
data$def05 <- data.table(read_sav("defuncion2005.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2005)]
data$def06 <- data.table(read_sav("defuncion2006.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2006)]
data$def07 <- data.table(read_sav("defuncion2007.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2007)]
data$def08 <- data.table(read_sav("defuncion2008.sav"))[,.(PROV, ANION, MESN, ANIOF, MESF, EDAD, ANIO=2008)]
data$def09 <- data.table(read_sav("defuncion2009.sav"))[,.(PROV, ANION, MESN, ANIOF, MESF, EDAD, ANIO=2009)]
data$def10 <- data.table(read_sav("defuncion2010.sav"))[,.(prov, anion, mesn, aniof, mesf, edad, ANIO=2010)]
data$def11 <- data.table(read_sav("defuncion2011.sav"))[,.(prov_insc, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2011)]
data$def12 <- data.table(read_sav("defuncion2012.sav"))[,.(prov_insc, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2012)]
data$def13 <- data.table(read_sav("defuncion2013.sav"))[,.(prov_insc, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2013)]

str(data)

defun <- lapply(seq_along(data), function(i){table(data[[i]][[6]])})


