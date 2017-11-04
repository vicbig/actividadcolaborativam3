#Crear la carpetas con el "messy dataset" y el "tidy dataset" sino existen
if(!file.exists(".//messydataset")){dir.create(".//messydataset")}
if(!file.exists(".//tidydataset")){dir.create(".//tidydataset")}

#descargar el fichero a limpiar en la carpeta messydataset
fileurl <-"http://stat405.had.co.nz/data/billboard.csv"
download.file(fileurl,destfile=".//messydataset//billboard.csv")

#Descargar paquetes y cargar librerias necesarias
install.packages ("statsDK")
library(tidyr)
library(dplyr)

#Lectura del fichero de entrada billboard.csv
datasetmessy <- tbl_df(read.csv(".//messydataset//billboard.csv", stringsAsFactors = FALSE))

#Visualización contenido del fichero a limpiar
kable(head(datasetmessy[,1:11]))
 
#Se introducen las columnas week y rank y se eliminan todas las columnas entre los rangos x1st.week - x76th.week
#Se eliminan todas las combinacion con NA (Not Avalaible)
#Copiamos el resultado en un nuevo objeto datasettidy
datasettidy <- datasetmessy %>% gather(week, rank, x1st.week:x76th.week, na.rm=TRUE)

#Listado del objeto tidy
kable(head(datasettidy[,1:9]))

#Cambiamos el nombre de las columnas por simplicidad y claridad
colnames(datasettidy) <- c("year","artist","track","time","style","date.entered","date.peaked","week","rank")

#Limpiamos la columna week
datasettidy$week <-gsub("st.week","",datasettidy$week)
datasettidy$week <-gsub("x","",datasettidy$week)
kable(head(datasettidy[,1:9]))

#Por último realizamos una ordenación de las nuevas columnas artista, track, year
datasettidy %>% arrange(artist, track,week)
kable(head(datasettidy[,1:9]))

#Finalmente lo copiamos en el directorio de destino
write.csv(datasettidy,"c://ActividadModulo3//tidydataset//billboardtidy.csv")
