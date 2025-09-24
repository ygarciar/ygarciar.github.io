#' ---
#' title: "Estructuras de datos en R"
#' author: "Yolanda García Ruiz"
#' ---


# ------------------------------------------------------------------------------
# VECTORES
# ------------------------------------------------------------------------------
# construir un vector con la función c() de combinar
# Todos los elementos son del mismo tipo 
v <- c(4L, 4, 'C')
str(v)


## ---------------------------------------
# preguntar por el tipo
typeof(v)


## --------------------------------------
# preguntamos por la longitud del vector
length(v)


## ---------------------------------------
# secuencia desde:hasta
v2 <- 1:8
# con la función seq(desde, hasta, salto)
v3 <- seq(2, 3, by=.1)
# con la función seq(desde, hasta, tamaño final)
v4 <- seq(from = 2, to = 4, length.out=4)


## ---------------------------------------
v2
v3
v4


## Operaciones vectorizadas
# --------------------------------------
# Vector por escalar
v1 <- c(7, 2, 6, 8, 1)
v1 * 3


## ------------------------------------------
v1 <- c(2, 3, 0, 5)
v2 <- c(2, 3, 4, 3)
#  potencia vectorizada (elemento a elemento)
v1 ^ v2


## Del -------------------------------------------
v3 <- c(7, 2)
v2 <- c(2, 3, 0, 5)
# resta vectorizada con extensión previa de dimensión de v3
v3 - v2


## Otras operaciones
# ---------------------
# devuelve el vector ordenado (no modifica el vector)
sort(v1)


## --------------------
# inverso de un vector
rev(v1)


## --------------------
# frecuencias
v6 <- c(3, 5, 6, 1, 2, 3, 3, 1, 3)
table(v6)


## ---------------------------------------------
# valores únicos
v6 <- c(3, 5, 6, 1, 2, 3, 3, 1, 3)
unique(v6)


## Indexación y Slicing
# ----------------------------------------------
# Acceso a una posición 
v7 <- c(6, 7, 9, 1)
r <- v7[1]
r


## -------------------------------------------------
# Actualización de una posición
v7[1] <- 10
v7


## -------------------------------------------------
# muestra todos los elementos excepto el primero (extrae el primer elemento)
v7[-1]


## ------------------------------------------------
# muestra todos los elementos excepto el segundo
v7[-2]



## -------------------------------------------------
# muestra todos los elementos excepto el segundo y el cuarto
v7[-c(2, 4)]


## --------------------------------------------------
v7[c(1, 3, 9)]


## -------------------------------------------
# del extraer un rango de posiciones
v7 <- c(6, 7, 9, 1)
v7[2:4]


## Selección por filtro 
# -------------------------------------------
# Seleccionar los valores menores que 5
v <- c(6, 2, 9, 1)
filtro <- v < 5
v[filtro]


## -----------------------------------------
# Seleccionar los valores múltiplos de 2
v <- c(6, 2, 9, 1, 8)
filtro <- v %% 2 == 0
v[filtro]


## Otras operaciones
#---------------------------------------------
log(7)


## -----------------------------------------
v <- c(6, 2, 9, 1, 8)
log(v)


## -----------------------------------------
exp(8)


## -----------------------------------------
v <- c(6, 2, 9, 1, 8)
exp(v)


## -----------------------------------------
round(4.64521452, 2)


## Operaciones estadísticas 
# ------------------------------------------
v <- c(6, 2, 9, 1, 8)
sum(v)
mean(v)
var(v)
sd(v)
median(v)
quantile(v)


## -----------------------------------------
r <- 9 
r



# ------------------------------------------
# Otros tipos de datos
# ------------------------------------------



# ------------------------------------------
# LISTAS 
# ------------------------------------------

my_list <- list(
  num_vector = c(1, 2, 3),
  char_vector = c("a", "b", "c"),
  log_vector = c(TRUE, FALSE),
  string = 'Hola',
  valor = 9
)
my_list


## ---------------------------------------------------------------------------------------------------
# Tamaño de la lista
length(my_list)


## ---------------------------------------------------------------------------------------------------
my_list[4]
my_list[1]
my_list['num_vector']


## ---------------------------------------------------------------------------------------------------
str(my_list[2])


## ---------------------------------------------------------------------------------------------------
my_list[c('num_vector', 'char_vector')]


## ---------------------------------------------------------------------------------------------------
my_list$char_vector
my_list[[2]]


## ---------------------------------------------------------------------------------------------------
my_list[[2]]
str(my_list[[2]])


## ----eval=FALSE, message=TRUE-----------------------------------------------------------------------
## lista2 <- list(
##   num_vector = c(1, 2, 3),
##   log_vector = c(1,5)
## )
## # La ejeción de la siguiente instrucción dará error
## lista2 * 2



























## MATRICES
# ---------------------------------------------------------------------------------------------------

# llenado por columnas
x <- c(1, 2, 3, 4)
m <- matrix(x, nrow = 2, ncol = 2)
m


## ---------------------------------------------------------------------------------------------------
# acceder a la primera fila
m[1,]


## ---------------------------------------------------------------------------------------------------

# llenado por filas
x <- c(1, 2, 3, 4)
m <- matrix(x, nrow = 2, ncol = 2, byrow = TRUE)
m


## ---------------------------------------------------------------------------------------------------
# Tres filas y cuatro columnas
matrix(1:12, nrow = 3, ncol = 4)


## ---------------------------------------------------------------------------------------------------
matriz2 <- rbind(c(-2.5,0,2.5), c(-1,0,1))
rownames(matriz2) <- c("fila1", "fila2")
colnames(matriz2) <- c("columna1", "columna2", "columna3")
matriz2[2,"columna1"] <- matriz2[2,"columna1"]*2
matriz2


## ---------------------------------------------------------------------------------------------------
dim(matriz2)


## ---------------------------------------------------------------------------------------------------
mi_matriz <- matrix(1:9, nrow = 3, ncol = 3)
mi_matriz + 1


## ---------------------------------------------------------------------------------------------------
t(mi_matriz)


## ---------------------------------------------------------------------------------------------------
gender_vector <- c("male", "female", "female", "male", "male")


## ---------------------------------------------------------------------------------------------------
# Crear un factor a partir de un vector de caracteres
gender_factor <- factor(gender_vector)
gender_factor


## ---------------------------------------------------------------------------------------------------
# Crear un factor especificando niveles
status_vector <- c("single", NA,  "married", "married", "single", "divorced", NA)
status_factor <- factor(status_vector, levels = c("single", "married", "divorced"))
print(status_factor)



## ---------------------------------------------------------------------------------------------------
gender_factor[1]
gender_factor[3]


## ---------------------------------------------------------------------------------------------------
# Acceso a los niveles
levels(gender_factor)


## ---------------------------------------------------------------------------------------------------
# Número de niveles
nlevels(gender_factor)


## ---------------------------------------------------------------------------------------------------
# Frecuencia
table(gender_factor)


## ---------------------------------------------------------------------------------------------------
table(status_factor, useNA = "ifany")


## ---------------------------------------------------------------------------------------------------
gender_vector <- c("male", "female", "female", "male", "male")
gender_factor <- factor(gender_vector)
# Convertir un factor a un vector numérico (basado en los niveles)
gender_num <- as.numeric(gender_factor)
print(gender_num)


## ---------------------------------------------------------------------------------------------------
gender_factor[1] == 'male'


## ---------------------------------------------------------------------------------------------------
filtro <- gender_factor == 'male' 
gender_factor[filtro]


## ---------------------------------------------------------------------------------------------------
edades <- c(18, 19, 30, 18, NA, 12, 23, 23, 14, 23, 45)
rangos <- cut(edades, 3)
rangos


## ---------------------------------------------------------------------------------------------------
str(rangos)


## ---------------------------------------------------------------------------------------------------
# Creación de tablas de frecuencias a partir de factors
edades <- c(18, 19, 30, 18, NA, 12, 23, 23, 14, 23, 45)
estudios <- c('Superior', 'Superior', 'Medio', 'Superior', 'Basico', 'Basico', 'Medio', 'Superior', 'Basico', 'Basico', 'Basico')

# factorizamos 
rangos <- cut(edades, 3)
f_estudios <- factor(estudios)
table(rangos,f_estudios)   # tabla de frecuencias (Es una especie de pivot_table)

