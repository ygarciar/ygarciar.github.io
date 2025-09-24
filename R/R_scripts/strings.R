#' ---
#' title: "La librería stringr de R"
#' author: "Yolanda García Ruiz"
#' ---



# --------------------------------------------------------
## Objetos de tipo cadena
#---------------------------------------------------------
c <- 'a'
c
cadena <- "Hola mundo!!"
cadena


## -----------------------
cadena <- "Hola mundo!!"
str(cadena)


# --------------------------------------------------------
## Se pueden comparar (orden lexicográfico)
#---------------------------------------------------------
a <- 'Ana'
b <- "Miguel"
a < b



# --------------------------------------------------------
## Ecosistema tidyverse -  Paquete stringr 
#---------------------------------------------------------
# stringr proporciona funciones para 
#  el tratamiento de cadenas más intuitivas que las existentes en R base

# cargamos la librería
library(stringr)


## ---------------------------------------------------------------------------------------------------
# Creamos dos cadenas
nombre <- 'Ana'
apellido <- 'Higuera'


## ---------------------------------------------------------------------------------------------------
# Concatenación de cadenas con espacio
str_c(nombre, apellido, sep = ' ')


## ---------------------------------------------------------------------------------------------------
#Concatenación de cadenas con barra
str_c(c(1, 2, 3, 4, 5), collapse = '|')


## ---------------------------------------------------------------------------------------------------
# búsqueda de un sub string
# busca si 'ana' está en el primer parámetro
a <- str_locate_all( 'Hola ana. Adiós ana', "ana")
a
# busca si 'pedro' está en el primer parámetro. Devuelve la cadena vacía
b <-str_locate( 'Hola ana, ana', "pedro")
b


## ---------------------------------------------------------------------------------------------------
# Convertir a mayúsculas
nombre2 <-str_to_upper('Pepito')
nombre2 


## ---------------------------------------------------------------------------------------------------
# las funciones en stringr son operaciones vectorizadas
clientes <- c('Ana', 'Juan', 'Miguel')
clientes_may <- str_to_lower(clientes)
clientes_may


## ---------------------------------------------------------------------------------------------------
# extraer la subcadena 
str_sub('Barcelona', 1, 4)


## ---------------------------------------------------------------------------------------------------
# Para acceder a un solo carácter
str_sub('Barcelona', 3, 3)


## ---------------------------------------------------------------------------------------------------
# Sustitución de caracteres - sustituye cada "a" por "4"
str_replace_all("Tarragona", "a", "4" )


## ---------------------------------------------------------------------------------------------------
# Eliminación de caracteres en blanco y saltos de línea
str_trim("   Tarragona ")


## ---------------------------------------------------------------------------------------------------
# Ordenar
m <- str_sort(c("Tarragona", 'Ávila', 'Burgos'))
str(m)


## ---------------------------------------------------------------------------------------------------
# Caracteres especiales
especial <- 'Las \"comillas\" son caracteres epeciales'
writeLines(especial)


## ---------------------------------------------------------------------------------------------------
# Caracteres especiales. Salto de línea
especial = "Hay otros caracteres especiales como el salto de línea.\nSirve para representar el fín de línea en ficheros."
writeLines(especial)


## --------------------------------------------------------
# Formatear números enteros
## --------------------------------------------------------
sprintf("El número es: %d", 42)


# Formatear números de punto flotante con dos decimales
sprintf("El número es: %.2f", 3.14159)


# Insertar una cadena de texto
nombre <- "Carlos"
sprintf("Hola, %s!", nombre)

# Formatear números y cadenas juntos
edad <- 30
nombre <- "Ana"
sprintf("%s tiene %d años.", nombre, edad)

# Ajustar el ancho mínimo del campo
sprintf("El número es: %10d", 42)

