---
  title: "Exercícios Dplyr"
author: "Claudiano Neto"
date: "7 de Maio de 2021"
output:  
  prettydoc::html_pretty:
  theme: hpstr
highlight: github

---
  
  ```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Começando

Antes de começar um trabalho no R, você deve crregador o pacote **tidyverse**. Caso não tenha instalado rode o comando `install.packages("tidyverse")` no seu console. 


O maior objetivo aqui é mostar os principais verbos através de exemplos que darão uma noção do que cada verbo faz e exercícios que irão complementar o ensinamento que o exemplo trouxe. Os principais verbos do pacote Dplyr são:
  
  
  1. **Select:** seleciona variáveis baseado no nome delas (ou índice)
2. **Mutate:** adiciona novas variáveis que são funções de variáveis existentes
3. **Arrange:** muda a ordem das linhas
4. **Filter:** filtra linhas baseado em condições dadas
5. **Summarize:** reduz diversos valores para um únicos resumo


Você notará que também será citada uma função chamada `group_by` que pode ser combinada com esses verbos e é utilizada geralmente quando estamos interessados em investigar variáveis que representam agrupamentos como sexo de indivíduos, escolaridade, tipo de empresa (pública ou privada), etc.


```{r,message=FALSE}
library(tidyverse)
```


No quadro abaixo está o tibble que iremos analizar nesse exercício.


```{r}
notas <- 
  tibble(
    nome = c("mike", "carol", "greg", "marcia", "peter", "jan", "bobby", "cindy", "alice"),
    escola = c("south", "south", "south", "south", "north", "north", "north", "south", "south"),
    prof = c("johnson", "johnson", "johnson", "johnson",  "smith", "smith", "smith", "perry", "perry"),
    genero = c("male", "female", "male", "female", "male", "female", "male", "female", "female"),
    mat_nota = c(4, 3, 2, 4, 3, 4, 5, 4, 5),
    reading_nota = c(1, 5, 2, 4, 5, 4, 1, 5, 4)
  )
```


Primeiro vamos olhar como ficou nosso tibble.


```{r}
notas
```


Antes de começar, eu quero ter certeza que vocês sabem a diferença entre fazer algo e declarar isso a um objeto e apenas fazer algo sem declarar a um objeto. Por exemplo, verifique se você entende o que está sendo feito a seguir:
  
  
  ```{r}
#Pegar as primeiras 3 linhas
notas %>% slice(1:3)
```


```{r}
#Pegar as 3 primeiras linhas e declarar o que está sendo feito a um objeto
notas_reduzidas <- notas %>% slice(1:3)
#Vamos ver o que é "notas_reduzidas"
notas_reduzidas
```


Nesse exercício nós normalmente apenas mostramos os resultados e não os salvamos, mas fique à vontade para salva-los se você quiser.
Agora podemos ir para os exercícios. A maioria das sessões virão com um exemplo para você olhar e ter uma ideia do que pode ser feito e em cada sessão terão exercícios para o melhor entendimento de cada verbo.


# Arrange
## Exemplo
**Questão:** Ordene os dados por mat_nota do maior para o menor. Quem teve a maior nota de matemática?
  
  
  ```{r}
notas %>% arrange(desc(mat_nota))
```


**Resposta:** Bobby e Alice. Ambos empataram na maior nota de matemática.

## Exercícios


1. Ordene os dados pelo nome da primeira até a última letra do alfabeto.
2. Ordene os dados pelo gênero e em seguida faça females aparecer primeiro. Qual gênero aparentemente tem a melhor reading_nota?
  3. Ordene os dados por escola, depois por professor, depois por gênero, depois nota de matemática e por último nota de reading.


# Select
**Questão:** Selecione apenas as colunas nome, mat_nota e reading_nota.


```{r}
notas %>% select(nome,mat_nota,reading_nota)
```


## Exercícios


1. Selecione todas as colunas exceto a coluna gênero.
2. Selecione todas as colunas exceto as colunas mat_nota e reading_nota.
3. Mantenha todas as colunas mas reordene e coloque a coluna gênero como a primeira.


# Filter
## Exemplo
**Questão:** Filtre os dados para estudantes que são homens (male) e são do sul (south).


```{r}
notas %>% filter(genero == "male" & escola == "south")
```


## Exercícios


1. Filtre para estudantes que forma bem em matemática, você decide o que seria ir bem (nota que tirou).
2. Use o filtro para mostrar quantos estudantes tiveram uma nota em matemática de 4 ou mais e nota de reading de 3 ou mais.
3. Explique os erros em cada um dos blocos a seguir, então depois os conserte.


```{r,eval=F}
notas %>% filter(escola == south)
```

```{r,eval=F}
notas %>% filter(escola = "south")
```

4. Imagine que você está criando um programa de recuperação. Filtre os estudantes que foram 3 ou pior em matemática ou reading.
5. Filtre estudantes que tiveram uma nota em reading de 2,3 ou 4.


## Desafio


Filtre estudantes que tem um nome que começa com um "m". Dica: coloque "?str_sub" no console e veja o help dessa função.


# Filtre com grupos
## Exemplo
**Questão:** Filtre os professores cujo o melhor aluno de math tem nota 5.


```{r}
notas %>% group_by(prof) %>% filter(max(mat_nota) == 5)
```


## Exercícios


1. Filtre para o gênero com uma nota média de matemática igual a 4. 
2. Explique porque o código remove estudantes que tem a Perry como professora deles.

```{r}
notas %>% 
  group_by(prof) %>% 
  filter(mat_nota <= 3)
```


# Mutate
## Exemplo
**Questão:** Tanto as notas de matemática quanto as de reading foram na verdade de 50, substitua as duas variáveis por 10 vezes seus valores originais.


```{r}
notas %>% mutate(mat_nota = mat_nota*10,
                 reading_nota = reading_nota*10)
```


## Exercícios


1. Crie uma nova coluna chamada "mat_reading_new" na qual é a média das notas de um estudante de matemática e reading.
2. Crie uma nova coluna "high_mat_achiever" que é um indicador de se o estudante ganhou um 4 ou mais na sua nota em matemática.
3. Cria uma nova coluna "reading_score_centered" que é a nota de reading de um estudante subtraída pela média da nota de reading de todos os estudantes.
4. Crie uma nova coluna "science_score". Você é livre para escolher essas notas.


# Mutate com grupos
## Exemplo 
**Questão:** Tanto Mike quanto Cindy tem um 4 para a nota de matemática deles. Mostre porque Mike tinha uma maior nota "mat_score_centered_by_gender".


```{r}
notas %>% group_by(genero) %>% mutate(mat_score_centered_by_gender = mat_nota - mean(mat_nota))
```


## Exercícios


1. Crie uma coluna "reading_score_centered_by_teacher". O que você pode aprender com isso?
  2. Faça uma coluna "number_of_students_in_class" que é o número de estudantes da classe de estudantes.


# Summarize
## Exemplo
**Questão:** Use o comando summarize para encontrar a média da nota de matemática para todos os alunos.


```{r}
notas %>% summarise(mat_score_mean = mean(mat_nota))
```


## Exercícios


1. Use o comando summarize para encontrar a nota média de reading para todos os estudantes.
2. Use o comando summarize para encontrar a mediana para as notas de matemática e reading.


# Summarize com grupos
## Exemplo
**Questão:** Encontre a nota mínima de matemática para cada escola.


```{r}
notas %>% group_by(escola) %>% summarise(min_mat_score = min(mat_nota))
```


## Exercícios


1. Encontre a nota máxima de math para cada professor.
2. Se agruparmos por gênero, e então sumarizarmos com a nota mínima de reading, quantas linhas o tibble resultante teria?
  3. Lembre que `mutate` sempre mantém o mesmo número de linhas mas `summarize` normalmente reduz o número de linhas. Por qual motivo você acha que isso acontece? 
  4. crie um tibble com a média e mediana da nota de reading por gênero, bem como o número de estudantes do gênero.


# Combinando os verbos
## Exemplo
**Questão:** Selecione apenas as colunas nome e mat_nota. Então crie uma nova coluna "mat_nota_ec" que é a nota de math dos estudantes mais 5 pontos extras. Finalmente, ordene o tibble por mat_nota_ec do menor para o maior.


```{r}
notas %>% 
  select(nome,mat_nota) %>% 
  mutate(mat_nota_ec = mat_nota + 5) %>% 
  arrange(mat_nota_ec)
```


## Exercícios


1. Selecione toda coluna exceto a coluna prof. Crie uma nova variável chamada "mean_score" que é a média das notas de matemática e reading dos estudantes. Por último, ordene o tibble por mat_nota do menor para o maior.
2. Remova qualquer estudante que tenha smith como professor, então encontre a média de mat_nota por gênero.
3. Encontre o min, max e mediana de reading_nota para estudantes femininas da escola do sul.
4. Observe cada um dos blocos de códigos a seguir. Ambos fazem a mesma coisa. Qual deles você acha que é preferível do ponto de vista da eficiência do computador?
  
  
  ```{r}
#Código 1
notas %>% 
  group_by(escola, prof) %>% 
  summarize(max_mat_nota = max(mat_nota)) %>% 
  filter(escola == "south")
```

```{r}
#Código 2
notas %>% 
  filter(escola == "south") %>% 
  group_by(prof) %>% 
  summarize(max_mat_nota = max(mat_nota))
```
