#' ---
#' title: "IMPORT / EXPORT"
#' author: "Yolanda García Ruiz"
#' ---



# IMPORTACIÓN Y EXPORTACIÓN DE DATASETS
# --------------------------------------
# carga de la librería PARA LECTURA DE FICHEROS DE TEXTO
library(readr)


## ---------------------------------------------------------------------------------------------------
# lectura de datos en un fichero csv
accidentes <- read_csv("./data/accidentes_bicicletas.csv", 
        col_types = cols(fecha = col_date(format = "%d/%m/%Y"), 
                         hora  = col_time(format = "%H:%M:%S")))
accidentes


## ---------------------------------------------------------------------------------------------------
# lectura de datos en un fichero csv sin cabeceras
## ------------------------------------------------------
animals2 <- read_csv("./data/animals2.csv", 
                      col_names = FALSE)
animals2


## ---------------------------------------------------------------------------------------------------
# lectura de datos en un fichero csv sin cabeceras
# incluimos los nombres de las columnas a mano
## ------------------------------------------------------
animals2 <- read_csv("./data/animals2.csv", 
                      col_names = c('Nombre', 'Peso Cerebro', 'Peso cuerpo'))
animals2


## ---------------------------------------------------------------------------------------------------
# podemos actualizar los nombres de columnas
# una vez cargado el fichero con la función names() o colnames()
## --------------------------------------------------------------
names(animals2) <- c('Nombre', 'Peso_Cerebro', 'Peso_Cuerpo')
animals2


## ---------------------------------------------------------------------------------------------------
# saltando filas al comienzo
## ------------------------------------------------------
peliculas <- read_csv("./data/peliculas.csv", 
                   col_types = cols(Estreno = col_integer()), 
                   skip = 6)
peliculas


## ---------------------------------------------------------------------------------------------------
# Lectura de un fragmento del fichero
## ------------------------------------------------------
peliculas <- read_csv("./data/peliculas.csv", 
                  col_types = cols(Estreno = col_integer()), 
                  n_max = 2,
                  skip = 6)
peliculas


## ---------------------------------------------------------------------------------------------------
# Lectura de un subconjunto de columnas
accidentes <- read_csv("./data/accidentes_bicicletas.csv", 
               col_select = c('distrito', 'numero'),
               n_max = 5)
accidentes








## ---------------------------------------------------------------------------------------------------
# Lectura de fichero a través de una URL
# ----------------------------------------
t <- read_delim("https://datos.madrid.es/egob/catalogo/300110-24-accidentes-bicicleta.csv", 
          delim = ";")
slice_head(t)







# ----------------------------------------------------
# Archivos Microsoft Excel ( .xls, .xlsx)
# ----------------------------------------------------
# Carga de la librería
library(readxl)


## ---------------------------------------------------------------------------------------------------
# permite lista el nombre de las horas que hay
# en un libro Excel
excel_sheets("./data/clientes.xlsx")   # 2 hojas dentro del libro


## ---------------------------------------------------------------------------------------------------
# lectura de hoja excel y un rango de filas y columnas
df_excel <- read_excel(path="./data/clientes.xlsx", 
                       sheet="Hoja2", 
                       range="A1:C6")
df_excel







## -------------------------------------------------
# Exportar datos con write
## -------------------------------------------------
# tibble
t


## ---- csv ----------------------------------------
# Escribimos los datos en el fichero volcado_1.csv
write_csv(x = t, file = 'procesado_1.csv')


## ---- Excel --------------------------------------
# carga de librería
library(writexl)


## ------------------------------------------------
# Escribimos los datos en el fichero t.xlsx
write_xlsx(x = t, path = 'procesado_2.xlsx')

