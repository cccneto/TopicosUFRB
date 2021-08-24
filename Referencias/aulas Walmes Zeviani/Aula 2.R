##### Roteiro

# 1 - Terminar os verbos do dplyr

 Usar dados "starwars"

 dim(starwars)
 starwars
 
 # Linhas: filter(), slice(), arrange()
 # colunas: select(), rename(), mutate(), relocate()
 # grupos de linhas: summarise(), group_by()
 
 veremos slice(), rename(), relocate()
 
 
 
# install.packages("datos")
# remotes::install_github("cienciadedatos/dados")

library(datos)
library(dados)
library(tidyverse)

 starwars <- starwars
 starwars %>% View()
 starwars %>% slice(5:8) %>% View() # selecionando a partir da linha 5 ate a 8
 starwars %>% slice_head(n = 2) # seleciona os dois primeiros
 starwars %>% slice_tail(n= 2 ) # seleciona os dois ultimos
 starwars %>% slice_sample(n = 5) # escolha randomizada
 starwars %>% slice_sample(prop = 0.2) # retorna a proporçao de 20% das observações
 starwars %>% slice_max(height)
 
 is.na() # pergunta se a observação é NA ou "not available"
 ! explicar esse operador oposto a ==
  
 starwars %>% select(ends_with("color")) # seleciona colunas com nome terminado em color
 starwars %>% select(starts_with("h"))  # seleciona colunas com nome começando com h
 
 starwars %>% rename(nome_novo = nome_velho) 
 
 starwars %>%
   transmute(   # transmutate serve para você permanecer apenas com as novas variaveis
     height_m = height / 100,
     BMI = mass / (height_m^2)
   )
 
 starwars %>% 
   mutate(height_m = height / 100, # diferente do mutate que você fica com todas as variaveis
          BMI = mass / (height_m^2))
 
 starwars %>% is.na() %>% sum()
 