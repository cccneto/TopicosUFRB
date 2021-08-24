#install.packages("gapminder")
#install.packages("tidyverse") # instala 1 vez

library(gapminder)
library(dplyr)
library(tidyverse)


tb <- tibble(x = 1:4,    # aqui estamos criando um objeto tibble
             y = c(4, 7, 1, 3), 
             z = c(10, 10, 22, 22),
             k = c(TRUE, FALSE, FALSE, TRUE),
             u = c("A", "B", "A", "B"),
             vazio = c("NA", 1 , 1, "NA")) # not available = dado faltante
library(gapminder)

#filtrar (FILTER)
gapminder %>% 
  filter(year < 2006, 
         continent == "Americas", 
         lifeExp > 75)

# filtrando com "!=" diferente de .... 
gapminder %>% filter(continent != "Americas", continent != "Asia")

# organizar (ARRANGE)
gapminder %>% arrange(continent) # organizar por padrao "crescente"
gapminder %>% arrange(desc(continent)) # desc() ordenar decrescentemente
gapminder %>% arrange(desc(continent))

# fatiando os dados (SLICE)

gapminder %>% slice(1) # 1a linha
gapminder %>% slice(1:5) # intervalo
gapminder %>% slice(1, 60, 1000, 1050) # linhas selecionadas

# Fatiando por exclusão
gap_minder_maior100 <- gapminder %>% slice(-(1:100)) # quero tudo menos a linha 1
gapminder %>% slice(-c(1, 90, 100, 100:120, 200)) # quero tudo menos a linhas 1,2,5,10

# Selecionar colunas 
gapminder %>% select(continent, country, lifeExp) # selecion p nome
gapminder %>% select(1, 2, 4)  # selecionar p posição 
gapminder %>% select(-4) # todos menos 4a coluna
gapminder %>% select(-lifeExp) # todos menos lifeExp
gapminder %>% select(1:4) # intervalo
gapminder %>% select(lifeExp:pop) # intervalo

# tudo que for factor ou characteric ou numeric
gapminder %>% select(where(is.numeric))
gapminder %>% select(where(is.character))

# variação da funcao select -- > select_if()
gapminder %>% select_if(is.numeric)



gapminder %>% slice(10) %>% str() 

# filtra = linhas
# seleciona = colunas