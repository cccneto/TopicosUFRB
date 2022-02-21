# Conteudo da Aula 2

# Comentando as linhas de codigo do R
# Use o simbolo "#"
# CTRL + shift + C para comentar todas as linhas

# OBJETO E FUNÇÕES 

# salvando "1" em  "a"
# <-  Sinal de atribuição

a <- 1
b <- 2
a + b 

# Avalia o objeto "a"
a

# o nome deve sempre começar com uma letra
# permitido
x <- 1
x1 <-2
objeto <- 3
neto <- "sobrenome"
meu.objeto <- 1:10
meu_objeto <- "UFRB"

# nao é permitido
1x <- 2
_objeto <- 2
meu-objeto <- 3

# o R é sensivel a letras maiusculas e minusculas
d <- 10
D <- 11

# atribuir é diferente (!=) de simplesmente 
# rodar comando
1 + 1
soma <- 1 + 1 
soma

# a gente usa o R para executar FUNCOES
# sintaxe de funcoes

nome_da_funcao(arg1, arg2, ..., argn)

# exemplo de função:
sum(1, 2, 3, 4) # Somar os 4 numeros
sum(1:4)   # 1 + 2 + 3 + 4

calculo <- sum(1, 2, 3, 4)
calculo
calculo_ao_quadrado <- calculo ^ 2

# Exemplo calcular IMC
# IMC = peso / alt^2

# IMC Joao vitor
peso <- 95
alt <- 1.87
imc_jv <- peso/(alt^2)
imc_jv

peso_n <- 79
alt_n <- 1.74
imc_cn <- peso_n/(alt_n^2)
imc_cn

# criando uma função no R


imc_teste <- function(p, a){
    imc_pessoal = p/a^2 
    return(imc_pessoal)
}

# calcule o imc
neto <- imc_teste(p = 80, a = 1.90)


# Exercicio

# Qual a diferença entre os codigos abaixo?

# codigo 1
33 / 11

# codigo 2
divisao <- 33 / 11

# exercicio 2
# Multiplique sua idade por meses e salve o resultado
# em um objeto chamado "idade_em_meses".

idade_em_meses <- 12*21

# em seguida multiplique esse objeto por 30 e salve
# o resultado em um objeto chamado "idade_em_dias"
idade_em_dias <- idade_em_meses * 30

# calculando coisas no R - CALCULADORA
# Somando ---> +
# subtraindo ---> -
# multiplicando ---> *
# dividindo ----> /
# potencia ---> ^

# classes dos objetos
class(divisao)
class(meu_objeto)

caracter <- 1
caracter_2 <- 2

caracter + meu_objeto

# Tipos de Dados no R

# Dados Numericos
populacao <- c(1500, 2000)
class(populacao)

# Dados Textuais - caractere
estados_norte <- c("Acre", "Amazonia", "Rondonia", "Amapa")
class(estados_norte)

# Dados Logicos
logicos <- c(TRUE, FALSE, TRUE, TRUE, FALSE)
class(logicos)

# TRUE = 1
# FALSE = 0 

