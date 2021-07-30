# Aula 4 JOIN
library(dplyr)
library(nycflights13)
library(tidyverse)

# Referencia para estudar
#      https://rpubs.com/CristianaFreitas/311735

flights %>% head(300)

a <- as_tibble(list(x1 = c("Alves", "Bessa", "Cruz"), x2 = 1:3))
b <- as_tibble(list(x1 = c("Alves", "Bessa", "Dias"), x2 = c(T, F, T)))

# MUTATING JOINS - CRIA UM DATAFRAME
    left_join(x = a, y = b, by = "x1")

# LEFT_JOIN -  junçao a esquerda
# pega o DF que ta na direita, junta com o que ta 
# na esquerda, desde que haja matching

c <- dplyr::left_join(x = a, y = b, by = "x1")

# RIGHT_JOIN - junçao a direita
dplyr::right_join(x = a, y = b, by = "x1")

# INNER_JOIN - Retem apenas as linhas "em ambos" os conjuntos
dplyr::inner_join(a, b, by = "x1")

# FULL_JOIN - Retem todas as linhas de ambos objetos/tabela  
dplyr::full_join(a, b)


# FILTERING JOINS

# SEMI_JOIN - Filtrar os elementos de "a" que combina "b" (match)
dplyr::semi_join(a, b, by = "x1")

# ANTI_JOIN - filtra os elementos de "a" que NAO combina com "b"
dplyr::anti_join(a, b, by = "x1")
