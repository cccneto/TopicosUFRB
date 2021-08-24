
# "Exercícios Dplyr- adaptado das notas de aula do prof. Matheus Donato"


# Começando

# Antes de começar um trabalho no R, você deve carregar o pacote **tidyverse**. Caso não tenha instalado rode o comando `install.packages("tidyverse")` no seu console. Lembra como se carrega o pacote?
# O maior objetivo aqui é mostar os verbos que estudamos na ultima aula através de exemplos que darão uma noção do que cada verbo faz e exercícios que irão complementar o ensinamento que o exemplo trouxe.
# 
# 1.  **Select:** seleciona variáveis baseado no nome delas (ou índice)
# 2.  **Arrange:** muda a ordem das linhas
# 3.  **Filter:** filtra linhas baseado em condições dadas

# Você notará que também será citada uma função chamada `group_by` que pode ser combinada com esses verbos e é utilizada geralmente quando estamos interessados em investigar variáveis que *representam agrupamentos* como sexo de indivíduos, escolaridade, tipo de empresa (pública ou privada), etc.


library(tidyverse)
library(dplyr)


# No quadro abaixo está o um conjunto de informações que iremos iremos analizar nesse exercício. Observe que há um termo diferente do que você viu até aqui, *tibble*. Ele é uma função que nos fornece um formato de dados. Te explicarei melhor na proxima aula, mas por hora você precisa apenas rodar todo o comando para que tenhamos


# Rode os comandos abaixo para criamos as variaveis que irão compor o seu banco de dados.

nome <- c("mike", "carol", "greg", "marcia", "peter", "jan", "bobby", "cindy", "alice")
escola <- c("south", "south", "south", "south", "north", "north", "north", "south", "south")
prof <- c("johnson", "johnson", "johnson", "johnson",  "smith", "smith", "smith", "perry", "perry")
genero <- c("male", "female", "male", "female", "male", "female", "male", "female", "female")
mat_nota <- c(4, 3, 2, 4, 3, 4, 5, 4, 5)
reading_nota <- c(1, 5, 2, 4, 5, 4, 1, 5, 4)



# Você lembra qual função usamos para combinar as variaveis dentro de um 
# mesmo banco de dados? Isso mesmo, `cbind()` e `rbind()`. Então por favor, 
# junte as variaveis acima a partir de suas *colunas* atribuindo ao objeto "*notas*". 
# Qual das duas funções você usará?
  
  
# Junte as variaveis nome, escola, prof, genero, mat_nota, reading_nota atribuindo a um obheto chamado "notas"
notas <- cbind(nome, escola, prof, genero, mat_nota, reading_nota)

# vendo o objeto notas
notas 


# Antes de começar, eu quero ter certeza que vocês sabem a diferença 
# entre *fazer algo e declarar isso a um objeto* e apenas *fazer algo sem declarar a um objeto*. 
# Por exemplo, verifique se você entende o que está sendo feito a seguir:
  
  
# Pegar as primeiras 3 linhas - apenas fazendo sem atribuir
notas %>% 
  head(3)



#Pegar as 3 primeiras linhas e declarar o que está sendo feito a um objeto
notas_reduzidas <- 
  notas %>% head(3)

#Vamos ver o que é "notas_reduzidas"
notas_reduzidas


# Nesse exercício nós normalmente apenas mostramos os resultados e não os salvamos, 
# mas fique à vontade para salva-los se você quiser. Agora podemos ir para os exercícios. 
# A maioria das sessões virão com um exemplo para você olhar e ter uma ideia do que pode ser feito
# e em cada sessão terão exercícios para o melhor entendimento de cada verbo.


# CLASSES

## **Questão:** Quais são as classes das variaveis nome, escola, prof, genero, mat_nota? Responda 
# individualmente cada uma delas. Dica: lembre-se da funcao class()



# ARRANGE

## Exemplo

## **Questão:** Ordene os dados por *mat_nota* do maior para o menor. 
# Quem teve a maior nota de matemática? dica: lembre-se da função arrange() e desc() e do operador %>% 
  
  
notas %>% class()
notas <- notas %>% tibble::as_tibble(notas)
neto <- c(1,2,3)
joao <- c(1,2,3)
maria <- c(1,2,4)
class(neto)
df <- cbind(neto, joao, maria)
df <- as_tibble(df)
df %>% arrange(neto)

## Exercícios

# 1.  Ordene os dados pelo nome da primeira até a última letra do alfabeto.
# 2.  Ordene os dados pelo gênero e em seguida faça females aparecer primeiro. 
# Qual gênero aparentemente tem a melhor reading_nota?
# 3.  Ordene os dados por escola, depois por professor, depois por gênero, 
# depois nota de matemática e por último nota de reading.

# Usando a funcao Select

# **Questão:** Selecione apenas as colunas nome, mat_nota e reading_nota do objeto "notas" utilizando o operador
# pipe %>% .



## Exercícios

# 1.  Selecione todas as colunas exceto a coluna gênero.
# 2.  Selecione todas as colunas exceto as colunas mat_nota e reading_nota.
# 3.  Mantenha todas as colunas mas reordene e coloque a coluna gênero como a primeira.

# FILTER

## Exemplo

# **Questão:** Filtre os dados para estudantes que são homens (male) e são do sul (south). Lembre-se da função filter() 
# e de usar o caractere & para dizer "e". 


## Exercícios

# 1.  Filtre para estudantes que forma bem em matemática, você decide o que seria ir bem (nota que tirou).
# 2.  Use o filtro para mostrar quantos estudantes tiveram uma nota em matemática de 4 ou mais e nota de reading de 3 ou mais.
# 3.  Explique os erros em cada um dos blocos a seguir, então depois os conserte.



# 4.  Imagine que você está criando um programa de recuperação. Filtre os estudantes que foram 3 ou pior em matemática ou reading.
# 5.  Filtre estudantes que tiveram uma nota em reading de 2,3 ou 4.

## Desafio

# Filtre estudantes que tem um nome que começa com um "m". Dica: coloque "?str_sub" 
# no console e veja o help dessa função.

# Filtre com grupos

## Exemplo

# **Questão:** Filtre os professores cujo o melhor aluno de math tem nota 5.
# 
# 
# notas %>% group_by(prof) %>% filter(max(mat_nota) == 5)


## Exercícios

# 1.  Filtre para o gênero com uma nota média de matemática igual a 4.
# 2.  Explique porque o código remove estudantes que tem a Perry como professora deles.




