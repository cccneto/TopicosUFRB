mean(1:10)
median(1:18)
sqrt(49)

library(Ibamam)
library(tidyverse)
Ibamam::

# Exemplo com uma variavel
  x^2 + 2x + 4x^2 + 2x + 4

# codigo
calc <- function(x){
     resultado <- x^2 + 2*x + 4*x^2 + 2*x + 4
}

print <- calc(x = 0)
print

# usando funcao return 
calc <- function(x){
  resultado <- x^2 + 2*x + 4*x^2 + 2*x + 4
  return(resultado)
}

calc(x = 1)

# até estamos usando 1 elemento, x = 1 numero

# USANDO MAIS DE UMA VARIAVEL

calc_three_var <- function(x, y, z){
  resultado <- x^2 + 2*y + 4*z^2 + 2*x + 4
  return(resultado)
}

calc_three_var(x = 1, y = 0, z = 20)

# USANDO MAIS DE UMA VARIAVEL + argumento default


calc_three_var <- function(x, y, z = -1){
  resultado <- x^2 + 2*y + 4*z^2 + 2*x + 4
  return(resultado)
}


calc_three_var(x = 10:100, y = 10:100)


# Exemplo com CBIND

amostrador <- function(n, media_x = 0,media_y = 0,variancia_x = 1,variancia_y = 1){
  sd_x <- sqrt(variancia_x) # calcula desv padrao de x
  
  sd_y <- sqrt(variancia_y) # calcula desv padrao de y
  
  amostra.x <- rnorm(n, media_x, sd_x) # gera amostra dist normal x
  amostra.y <- rnorm(n, media_y, sd_y) ## gera amostra dist normal y
  
  return(cbind(amostra.x,amostra.y)) # retorna os valores na tela
}
 

amostrador(n = 150)

# Calculo de Sobra DE sALARIO

salario_liquido <- function(dados, na.rm = TRUE){
             imposto = (renda / (rent + saude + food))^2 - 1
          return(sobra_de_salario)
}

# calcular o saldo que fica na conta das pessoas depois de pagar tudo

# salario_liquido(renda = 2000, rent = 1000, saude = 0, food = 500)

renda <- c(10000:10100)
rent <- (400:500)
saude <- (200:300)
food <- (100:200)
dados <- cbind(renda, rent, saude, food)

salario_liquido(dados = dados)
neto <- c(1:10, NA, NA, NA)


mean(x = neto, na.rm = TRUE)
