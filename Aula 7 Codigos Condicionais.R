
library(tidyverse)     # for data cleaning and plotting
library(lubridate)     # for date manipulation
library(palmerpenguins)# for Palmer penguin data

install.packages("babynames")
library(babynames)

# `if` e `else` 

# considerando a nota que a pessoa tirou
nota <- 4.5

# E sabendo que a nota minima para aprovação deve ser 5, temos:
if(nota >= 5) {
  print("Aprovação")
} else {
  print("Reprovação")
} # se caso anterior nao for verdadeiro, a pessoa será reprovada


# `if` e `else` e `else if`
# Vamos adicionar mais complexidade. Agora teremos a possibilidade de exame de recuperação. 

# considerando a nota que a pessoa tirou
nota <- 4.5

if(nota >= 5) {
  print("Aprovação")
} else if (nota >= 3 & nota < 5) { 
  # se a nota for maior ou igual a 5, mas menor que 5,
  # ela deverá fazer a prova de recuperação
  print("Recuperação")
} else {
  print("Reprovação")
} 

# Função `range()`
# Função de range é uma funcao de intervalo no R. 
# Ela retorna um vetor contendo o `mínimo` e o `máximo` de todos os argumentos fornecidos.

#  Forma de uso: seq(inicio, fim, passo)

seq(4, 10, 2)

# Algo que devemos tomar cuidado é que podemos usar apenas um argumento, 
# que será usado para definir o tamanho da sequência de números. 
# Neste caso, a função usará como valores padrões para os argumentos de passo (sendo 1). 
# Veja o exemplo:

seq(4)

# Função `case_when()` 

tabela_notas <- babynames::babynames %>% 
  dplyr::filter(year == 2017) %>% 
  dplyr::arrange(desc(n)) %>% 
  dplyr::slice(1:10) %>% 
  dplyr::select(name, sex) %>% 
  dplyr::mutate(nota = seq(0, 9, 1))

tabela_notas %>% 
  dplyr::mutate(
    resultado = dplyr::case_when(nota >= 5 ~ "Aprovação",
                                 nota >= 3 & nota < 5 ~ "Recuperação",
                                 TRUE ~ "Reprovação" ))


# Botando a mão na massa
# Usando os dados da `tabela_notas_sexo` crie uma coluna chamada "genero" que receba, 
# "masculino" e "feminino".

tabela_notas_sexo <- babynames::babynames %>% 
  dplyr::filter(year == 2017) %>% 
  dplyr::arrange(desc(n)) %>% 
  dplyr::slice(1:10) %>% 
  dplyr::select(name, sex)

# Resposta:
  
tabela_notas_sexo %>% 
  dplyr::mutate(genero = dplyr::case_when(sex == "F" ~ "feminino", TRUE ~ "masculino"))

# Outro exemplo
dados <- Ibamam::ibge_code
# https://www.todamateria.com.br/siglas-estados-brasileiros/
# Crie uma nova variavel chamada `regiao`, e que conste o nome das regiões brasileiras 
# para os estados do Norte.

# classificando estados do "Norte"  

dados %>% 
  mutate(regiao = case_when(abrev_state  %in% c("AC", "AP", "AM", "PA", "RO", "RR", "TO") ~ "Norte", 
                            TRUE ~ "Outros"))


# classificando todos os estados
dados %>% 
  mutate(
    regiao = case_when(abrev_state %in% c("AC", "AP", "AM", "PA", "RO", "RR", "TO") ~ "Norte",
                            abrev_state %in% c("AL", "BA", "CE", "MA", "PB", "PE", "PI", "RN", "SE") ~ "Nordeste",
                            abrev_state %in% c("DF", "GO", "MT", "MS", "PB") ~ "Centro-Oeste",
                            abrev_state %in% c("SP", "RJ", "MG", "ES", "PB") ~ "Sudeste", 
                            TRUE ~ "Sul"))



