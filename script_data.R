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

class(data.table(read_sav("defuncion1990.sav")))

data.table(read_sav("defuncion1990.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD)]


