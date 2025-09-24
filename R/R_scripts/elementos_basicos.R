#' ---
#' title: "Elementos básicos de R"
#' author: "Yolanda García Ruiz"
#' ---


# Elementos básicos de R
# ------------------------

## Suma de números (Number) 
2 + 5 

## Otras operaciones
6 + 8 - 9


## # la coma decimal se representa como un punto en R
2.3 + 8    

var(c(5, 4, 45, 5, 7))
sd(c(5, 4, 45, 5, 7))

## Números integer
# -----------------
3L


## Consulta de tipos
---------------------

# devuelve la clase a la que pertenece un objeto
typeof(4L)

# preguntamos si un objeto es integer (gama de funciones is.*)
is.integer(25L)    

# Devuelve información del objeto (Tipo y valor)
str(25L)


## Números double
# -----------------

library(dplyr)
## ---------------
d <- 1 / (10^30)
d

# Ojo con la comparación cuando el dato es double 
library(dplyr)
near(d, 0)
d == 0


## Valores especiales (ocurren en divisiones por 0)
c(-1, 0, 1) / 0


## Numeric
# ------------
num_entero <- 5 - 15.7
num_entero

num_integer <- 2L * 14L
str(num_integer)     # str para mostrar el tipo y el valor



## Valores booleanos
# -----------------------------
# falso = 0
a <- FALSE
a
# cierto = 1
b <- T   
b

## ----------------------------
str(a)    


## Valores NULL y NA
# ---------------------
a <- NULL    # ausencia de datos
class(a)


## ----------------------------
b <- NA     #  datos perdidos
b


## Variables y asignación 
# -----------------------------
# perímetro del círculo :2*pi*r esta línea es un comentario que no se ejecuta

r <- 5L     # en la variable r almacenamos el valor del radio
pi <- 3.14     # en la variable pi almacenamos el valor de pi
perimetro <- 2 * pi * r      #perímetro
perimetro



## Nombres de variables 
# ---------------------
precio.pan <- 15.2
costes_enero <- 124514.2
costes01 <- 1541


## Operadores = e <- 
#----------------------
x <- 10
x

# la función mean calcula la media de una colección de datos
mean(x = c(1, 2, 3, 4, 5))  


## Operaciones    
#----------------------
# potencia 
2 ^ 3      # 2 elevado a 3


## ---------------------
# resto de la división entera (operación módulo)
5 %% 2


## ---------------------
# división 
5 / 2


## Operadores Lógicos
# -------------------------
relacion1 <- F | F   #or 
relacion1
relacion2 <- T & F  # and 
relacion2
relacion3 <- !(5 < 1)   # not
relacion3


## Relacionales
# ------------------
3 < 6

4 == 5

4 != 3


## Funciones predefinidas
#-----------------------------
print('Hola Mundo')
area <- 100
print(area)
print(area + 100)


## ---------------------------------------------------------------------------------------------------
#función que calcula el máximo valor de una secuencia de valores
max(1,5,34,35,3,5)   


## ---------------------------------------------------------------------------------------------------
min(1,5,-2,5.8,45)

## varianza y desviación típica  -------------------------------
var(c(5, 4, 45, 5, 7))
sd(c(5, 4, 45, 5, 7))

## ---------------------------------------------------------------------------------------------------
abs(5-50)


## ---------------------------------------------------------------------------------------------------
round(3.1617, 1)


## ---------------------------------------------------------------------------------------------------
sqrt(4)
sin(30)
log(10)


## Coerción de tipos
# -----------------------------------------------------------------------------------------
# El dato 3L se transforma numeric antes de realizarse la suma
g <- 3L + 6.9
str(a)


## ---------------------------------------------------------------------------------------------------
a <- 6.4
m <- as.character(a)
str(m)


## ---------------------------------------------------------------------------------------------------
a <- 3.45
as.integer(a)


## ---------------------------------------------------------------------------------------------------
a <- '6,4'
m <- as.numeric(a)
m

