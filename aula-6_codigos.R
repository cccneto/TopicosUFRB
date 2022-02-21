# Relembrando como importar dados do excel e csv
library(tidyverse)
# Opção 1
library(readxl)
teste4 <- read_excel("C:/Users/User/Downloads/Planilha para áreas (1).xlsx", sheet = 12, skip = 3)

# Opção 1
library(readr)
planilhacsv <- read.csv("C:/Users/User/Downloads/planilhacsv.csv", sep=";")
url <- "https://github.com/cccneto/valuation_urbanParks/blob/master/base_unificada.xlsx?raw=true"
destfile <- "base_dados.xlsx"
curl::curl_download(url, destfile)
nome_dados <- read_excel(destfile)

string2 <- 'Se voce quiser incluir uma "citação" dentro de uma string, use aspas simples'

string1 <- "Isso é uma string"
string3 <- c("Isso", "é", "uma string")
strin2 <- 'Isso é uma string diferente'

string3 <- "\\"

dados <- c("um", "dois", "tres")



# uso padrão para duplicar uma string
str_dup(string = "Neto", times = 3)
str_dup("Olá", 4)

nome_dados %>%
  select(cidade, bairro) %>% 
  mutate(nome_dup = str_dup(cidade, 3))

str_dup(string1, 2)

# uso com diferentes 'vezes'
str_dup("Olá", 1:4)

# uso com vetor de strings
words <- c("1", "1", "1", "1", "1")
str_dup(words, 1:5)

# texto com espaços em branco
bad_text <- c("    Este", " exemplo ", " tem vários ",
              "espaços em branco   ")


# remove os espaços em branco do lado esquerdo
str_trim(string = bad_text, side = "left")
str_trim(bad_text, side = "left")


# remove os espaços em branco do lado direito
str_trim(bad_text, side = "right")


# remove os espaços em branco ambos os lados
str_trim(bad_text, side = "both")


# Extração de palavras


# Uma frase qualquer
teste <- c("Universidade Federal do Reconcavo da Bahia", "Bora Bahia minha porreta")

# extrair a primeira palavra de cada elemento
word(string = teste, start = 4)

word(change, 1)

# Medindo o comprimento da String

teste
str_length(string = teste) 

str_length(c("a", "R para ciência de dados", "teste", NA))


nome_dados %>%
  select(parque, cidade) %>% 
  mutate(num_letras = str_length(parque)) %>% 
  arrange(parque)


# Combinando strings
letras <- c("x", "y")

str_c("x", "y")

str_c("x", "y", "z")

str_c("x", "y", "z", sep = ",") # separando com virgula
str_c("x", "y", "z", sep = " , ") # separando com virgula e espaço 


nome_dados %>%
  select(cidade, bairro) %>% 
  mutate(name_comb = str_c(bairro, cidade, sep = " "))

# separando com "-"

nome_dados %>%
  select(cidade, bairro) %>% 
  mutate(combinado = str_c(bairro, cidade, sep = ","))

#colpsando 
nomes <- c("Claudiano", "Joao", "Maria")

str_c(nomes, collapse = "-")

marca <- c("Ford", "fiat", "wolks")
modelo <- c("FordKA", "Uno", "Gol")
cor <- c("Preto", "Amarelo", "azul")

carros <- cbind(marca, modelo, cor) %>% as.data.frame()

carros %>% 
  mutate(nome_combinado = 
           str_c(marca, modelo, cor, sep = "- "))






library(tidyverse)
# Como atribuir um caractere - string
neto <- "É o meu 'nome'"
claudiano <- 'É o meu "nome" '

joao <- "Joao tem \\ barras em casa"

resumo <- "Nessa parte, você tem que apresentar ao leitor do que se trata o seu trabalho, isto é, contextualizá-lo. Uma forma simples de fazer isso é responder, em poucas frases, as seguintes perguntas: Qual o problema que você está investigando? Onde esse problema se apresenta? Por que esse problema é importante? Lembre que são nessas primeiras linhas que você vai despertar o interesse do leitor."
resumo1 <- c("Nessa parte, você tem", "n'e'to", "beatriz")

x <- c("a", "R for data science", "teste", NA)
x <- c("a", "R for data science", "teste", "NA")


x %>% str_length()

str_length(x)
str_length(c("a", "R for data science", "teste", NA))

# medir o comprimento de uma string - quantas letras
str_length(resumo1)

# combinando strings
nomes <- c("Augusto", "Jesus")

str_c("Augusto","Sergio", "Jesus")

str_c("Augusto","Sergio", "Jesus", sep = ", ")

x <- c("abc", "NA", "efg")

str_c("(", x, ")")


x <- c("abc", NA, "efg") # exemplo com dado faltante 'NA'
str_c("(", str_replace_na(x), ")")

# E quando aparece NA's? e voce quer, substituir:
x <- c(2, 1, NA)
str_replace(x, pattern = 0)  # verificar tipo de erro

# Vetores de comprimentos diferentes
str_c(
      c("Joao", "Maria", "Joana"), 
      c(" a", " b", " c"), 
      c(" inicio", " meio"," final"))

# colapsar - collapse
x <- c("Joao", "de Souza", "Silva")
length(x)

x1 <- str_c("Joao", "de Souza", "Silva")
length(x1)

nomes <- c("Joao", "Souza", "Silva")
str_c(nomes, collapse = "/ ") # como objeto
str_c(c("Joao", "Souza", "Silva"), collapse = ", ") # vetores

letters

alfabeto <- c("a", "b", "c", "d")
alfabeto <- c("A", "B", "C", "d")


str_c("Letras: ", letters)
str_c("Letras", letters, sep = ", ")
str_c("Letras", letters, collapse = ", ")

# criando subconjuntos em Strings
frutas <- c("maçã", "banana", "pera")
str_sub(frutas, 3, 4)

frutas2 <- c("maca-20", "figo-30", "caju-40")

str_sub(frutas2, start =1, end = 4)

x_sub <- str_sub(frutas2, start =1, end = 4)
str_sub(frutas2, start =-3, end = -1)

# você também pode usar a forma de atribuição de str_sub() 
# para modificar strings:
  
FRUTAS <- c("PERA", "MAÇA", "BANANA")
frutas <- c("maçã", "banana", "pera")


str_sub(FRUTAS, 1, 3) %>% 
  str_to_lower() # formato tidyverse

str_to_lower(str_sub(FRUTAS, 1, 3)) # formato mais simples

str_sub(frutas, 1, 3) %>% str_to_upper()
