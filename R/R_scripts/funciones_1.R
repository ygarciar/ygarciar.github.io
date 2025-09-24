#' ---
#' title: "Elementos básicos de R"
#' author: "Yolanda García Ruiz"
#' ---


# Funciones de usuario
# --------------------
# Ejemplos de función que suma dos números
suma_elementos <- function(x, y){
    s <- x + y
    return(s)
}

# usamos la función definida anteriormente
a <- 5
resultado <- suma_elementos(a, 8)
resultado



# función que suma 3 números y devuelve el resultado
suma_elementos <- function(x, y, z){               
    m1 <- x + y
    m2 <- m1 + z
    return(m2)
}


# usamos la función definida anteriormente
suma_elementos(1,2,8)


## ------------------------------------------------------
a <- 1
b <- 8
# los valores de a y b se sustituyen por 1 y 8 respectivamente en la llamada
resultado <- suma_elementos(a,2,b)  
resultado



# Más ejemplos

## Funciones con parámetros posicionales
# --------------------------------------
# distancia entre los puntos (x1, y1) y (x2, y2)
distancia_eu <- function(x1, y1, x2, y2) {
  r <- sqrt((x1 - x2)^2 + (y1 - y2)^2)
  return(r)
}


# distancia entre (1, 1) y (2, 2)
distancia_eu(1, 1, 2, 2)


## Funciones con parámetros con valor por defecto
# -----------------------------------------------
# distancia entre los puntos (x1, y1) y (x2, y2)
distancia_eu2 <- function(x1, y1, x2 = 0, y2 = 0) {
  r <- sqrt((x1 - x2)^2 + (y1 - y2)^2)
  return(r)
}


## ---------------------------------------------------------------------------------------------------
# distancia entre (1, 1) y (2, 2)
distancia_eu2(1, 1, 2, 2) 
# distancia entre (4, 4) y (0, 0). No damos valor a los dos últimos parámetros
distancia_eu2(4, 4)       
# igual efecto que la llamada anterior


## ---------------------------------------------------------------------------------------------------
# distancia entre (4, 4) y (0, 8)
distancia_eu2(1, 1, y2=8)  



## Devolviendo más de un valor 
# -----------------------------
seno_coseno <- function(angulo){
  seno <- sin(angulo)
  coseno <- cos(angulo)
  return (c(seno, coseno))
}

## ---------------------------------------------------------------------------------------------------
seno_coseno(pi)


## ---------------------------------------------------------------------------------------------------
#' @title Grados Farenheit a Celsius (centígrados)
#' @description
#' \code{farenheit_a_celsius} calcula los respectivos grados Celsius de Farenheit indicados. 
#' @param f Vector numérico de longitud uno y valor superior a -460.
#' @return Muestra calculada en grados Celsius (Vector numérico de longitud uno).
#'
#' @author Pepe
#'
#' @examples
#' farenheit_a_celsius(0)
#' @export

farenheit_a_celsius <- function(f) {
  if(!is.numeric(f)) {
    stop("f no es un vector numeric.")
  }
  stopifnot(f > -460)             #0 absoluto
  centigrados <- ((f-32) * (5/9))
  return(centigrados)
}


## Midiendo tiempos 
------------------------------------------
# Código a medir
system.time({
  result <- sum(1:1000000)
})


## -------------------------------------------

library(microbenchmark)
## --------------------------------------------
# Código a medir usando microbenchmark
microbenchmark(
  sum = sum(1:1000000),
  times = 100
)

