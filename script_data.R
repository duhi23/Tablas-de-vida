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

colnames(data.table(read_sav("defuncion1990.sav")))

data.table(read_sav("defuncion1990.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1990)]
data.table(read_sav("defuncion1991.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1991)]
data.table(read_sav("defuncion1992.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1992)]
data.table(read_sav("defuncion1993.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1993)]
data.table(read_sav("defuncion1994.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1994)]
data.table(read_sav("defuncion1995.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1995)]
data.table(read_sav("defuncion1996.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1996)]
data.table(read_sav("defuncion1997.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1997)]
data.table(read_sav("defuncion1998.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1998)]
data.table(read_sav("defuncion1999.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=1999)]
data.table(read_sav("defuncion2000.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2000)]
data.table(read_sav("defuncion2001.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2001)]
data.table(read_sav("defuncion2002.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2002)]
data.table(read_sav("defuncion2003.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2003)]
data.table(read_sav("defuncion2004.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2004)]
data.table(read_sav("defuncion2005.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2005)]
data.table(read_sav("defuncion2006.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2006)]
data.table(read_sav("defuncion2007.sav"))[,.(PROV, ANON, MESN, ANOF, MESF, EDAD, ANIO=2007)]
data.table(read_sav("defuncion2008.sav"))[,.(PROV, ANION, MESN, ANIOF, MESF, EDAD, ANIO=2008)]
data.table(read_sav("defuncion2009.sav"))[,.(PROV, ANION, MESN, ANIOF, MESF, EDAD, ANIO=2009)]
data.table(read_sav("defuncion2010.sav"))[,.(prov, anion, mesn, aniof, mesf, edad, ANIO=2010)]
data.table(read_sav("defuncion2011.sav"))[,.(prov_insc, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2011)]
data.table(read_sav("defuncion2012.sav"))[,.(prov_insc, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2012)]
data.table(read_sav("defuncion2013.sav"))[,.(prov_insc, anio_nac, mes_nac, anio_fall, mes_fall, edad, ANIO=2013)]
