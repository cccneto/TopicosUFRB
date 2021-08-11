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
x <- c("maca-20", "figo-30", "caju-40")
x_sub <- str_sub(x, start =1, end = 4)
str_sub(x, start =-2, end = -1)
