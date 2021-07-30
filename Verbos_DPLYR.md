---
title: "Introdução ao Tidyverse"
runningheader: "" # only for pdf output
subtitle: "Tópicos Especiais em Meio Ambiente I" # only for html output
author: "Prof. Claudiano Neto"
date: "2021-06-28"
output:
  tufte::tufte_html: default
  tufte::tufte_handout:
    latex_engine: xelatex
  tufte::tufte_book:
    citation_package: natbib
    latex_engine: xelatex
---




```r
library(gapminder) 
library(dplyr)
library(tidyverse)
```


```r
gapminder # puxando a base de dados
```

```
## # A tibble: 1,704 x 6
##    country     continent  year lifeExp      pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>    <int>     <dbl>
##  1 Afghanistan Asia       1952    28.8  8425333      779.
##  2 Afghanistan Asia       1957    30.3  9240934      821.
##  3 Afghanistan Asia       1962    32.0 10267083      853.
##  4 Afghanistan Asia       1967    34.0 11537966      836.
##  5 Afghanistan Asia       1972    36.1 13079460      740.
##  6 Afghanistan Asia       1977    38.4 14880372      786.
##  7 Afghanistan Asia       1982    39.9 12881816      978.
##  8 Afghanistan Asia       1987    40.8 13867957      852.
##  9 Afghanistan Asia       1992    41.7 16317921      649.
## 10 Afghanistan Asia       1997    41.8 22227415      635.
## # ... with 1,694 more rows
```

# **Conhecendo os verbos do Dplyr?**

* Linhas: filter(), slice(), arrange()
* colunas: select(), rename(), mutate(), relocate()
* grupos de linhas: summarise(), group_by()

<img src="https://miro.medium.com/max/3680/1*NXRsFH_12sfj79W-P4qI0Q.png" title="plot of chunk unnamed-chunk-24" alt="plot of chunk unnamed-chunk-24" width="850" />

# **Como realizar a ordenação dos dados?**


```r
tb <- tibble(x = 1:4,    # aqui estamos criando um objeto tibble
y = c(4, 7, 1, 3), 
z = c(10, 10, 22, 22),
k = c(TRUE, FALSE, FALSE, TRUE),
u = c("A", "B", "A", "B"),
vazio = c("NA", 1 , 1, "NA")) 
```

## Pausa para uma dica - **`dput()`**

```r
dput(tb) # vamos usar para recriar (de uma forma diferente) o objeto que estamos trabalhando 
```

```
## structure(list(x = 1:4, y = c(4, 7, 1, 3), z = c(10, 10, 22, 
## 22), k = c(TRUE, FALSE, FALSE, TRUE), u = c("A", "B", "A", "B"
## ), vazio = c("NA", "1", "1", "NA")), row.names = c(NA, -4L), class = c("tbl_df", 
## "tbl", "data.frame"))
```


## Ordenação crescente

```r
tb %>% arrange(z, y) # observe que se trata de ordenação crescente
```

```
## # A tibble: 4 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     1     4    10 TRUE  A     NA   
## 2     2     7    10 FALSE B     1    
## 3     3     1    22 FALSE A     1    
## 4     4     3    22 TRUE  B     NA
```

## Ordenação descendente

```r
tb %>% arrange(desc(z), y)
```

```
## # A tibble: 4 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     3     1    22 FALSE A     1    
## 2     4     3    22 TRUE  B     NA   
## 3     1     4    10 TRUE  A     NA   
## 4     2     7    10 FALSE B     1
```

# **Como filtrar os dados?** - FILTER


```r
tb %>% filter(x > 2 | u == "A")  # lembre-se q barra vertical "|" significa OU
```

```
## # A tibble: 3 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     1     4    10 TRUE  A     NA   
## 2     3     1    22 FALSE A     1    
## 3     4     3    22 TRUE  B     NA
```


```r
tb %>% filter(x > 2 & u == "A")  # lembre-se "&" significa OU
```

```
## # A tibble: 1 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     3     1    22 FALSE A     1
```

# **Como fatiar as linhas**? - SLICE

```r
tb %>% slice(1:3) # Somente as 3 primeiras linhas
```

```
## # A tibble: 3 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     1     4    10 TRUE  A     NA   
## 2     2     7    10 FALSE B     1    
## 3     3     1    22 FALSE A     1
```


```r
tb %>% slice(-(3:5)) # somente as 2 primeiras linhas
```

```
## # A tibble: 2 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     1     4    10 TRUE  A     NA   
## 2     2     7    10 FALSE B     1
```

# **Como selecionar variáveis/colunas?**

## Como selecionar as variáveis por listagem?


```r
tb %>% select(x, y) # Inclusão.
```

```
## # A tibble: 4 x 2
##       x     y
##   <int> <dbl>
## 1     1     4
## 2     2     7
## 3     3     1
## 4     4     3
```


```r
tb %>% select(-z) # Exclusão.
```

```
## # A tibble: 4 x 5
##       x     y k     u     vazio
##   <int> <dbl> <lgl> <chr> <chr>
## 1     1     4 TRUE  A     NA   
## 2     2     7 FALSE B     1    
## 3     3     1 FALSE A     1    
## 4     4     3 TRUE  B     NA
```


```r
tb %>% select(y:k) # Intervalo
```

```
## # A tibble: 4 x 3
##       y     z k    
##   <dbl> <dbl> <lgl>
## 1     4    10 TRUE 
## 2     7    10 FALSE
## 3     1    22 FALSE
## 4     3    22 TRUE
```

## Como selecionar as variáveis por posição?

```r
tb %>% select(3, 2, 1)
```

```
## # A tibble: 4 x 3
##       z     y     x
##   <dbl> <dbl> <int>
## 1    10     4     1
## 2    10     7     2
## 3    22     1     3
## 4    22     3     4
```


```r
tb %>% select(-(1:2))
```

```
## # A tibble: 4 x 4
##       z k     u     vazio
##   <dbl> <lgl> <chr> <chr>
## 1    10 TRUE  A     NA   
## 2    10 FALSE B     1    
## 3    22 FALSE A     1    
## 4    22 TRUE  B     NA
```

## Como selecionar as variáveis por condição?

```r
tb %>% select_if(is.numeric) # o que É numérico
```

```
## # A tibble: 4 x 3
##       x     y     z
##   <int> <dbl> <dbl>
## 1     1     4    10
## 2     2     7    10
## 3     3     1    22
## 4     4     3    22
```


```r
tb %>% select_if(negate(is.numeric)) # o que NÃO é numérico
```

```
## # A tibble: 4 x 3
##   k     u     vazio
##   <lgl> <chr> <chr>
## 1 TRUE  A     NA   
## 2 FALSE B     1    
## 3 FALSE A     1    
## 4 TRUE  B     NA
```

# COMO *sortear* AS LINHAS?

```r
tb %>% sample_n(size = 3) # por tamanho discreto
```

```
## # A tibble: 3 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     4     3    22 TRUE  B     NA   
## 2     1     4    10 TRUE  A     NA   
## 3     2     7    10 FALSE B     1
```


```r
tb %>% sample_frac(size = 0.5) # por tamanho fracionado
```

```
## # A tibble: 2 x 6
##       x     y     z k     u     vazio
##   <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1     3     1    22 FALSE A     1    
## 2     1     4    10 TRUE  A     NA
```


# **Como realizar transformações - alterar e criar?**

## Para *modificar* uma variável


```r
tb %>% mutate(x = x * 2, 
              u = as_factor(u),
              j = median(x))
```

```
## # A tibble: 4 x 7
##       x     y     z k     u     vazio     j
##   <dbl> <dbl> <dbl> <lgl> <fct> <chr> <dbl>
## 1     2     4    10 TRUE  A     NA        5
## 2     4     7    10 FALSE B     1         5
## 3     6     1    22 FALSE A     1         5
## 4     8     3    22 TRUE  B     NA        5
```

## *Criando* uma variável a partir de outra


```r
tb %>% mutate(v = y * z^(x/4))
```

```
## # A tibble: 4 x 7
##       x     y     z k     u     vazio     v
##   <int> <dbl> <dbl> <lgl> <chr> <chr> <dbl>
## 1     1     4    10 TRUE  A     NA     7.11
## 2     2     7    10 FALSE B     1     22.1 
## 3     3     1    22 FALSE A     1     10.2 
## 4     4     3    22 TRUE  B     NA    66
```

## Renomeando uma variável/coluna

```r
# tb %>% rename(nomeNovo = NomeVelho) 
tb %>% rename(nomeNovo = x) 
```

```
## # A tibble: 4 x 6
##   nomeNovo     y     z k     u     vazio
##      <int> <dbl> <dbl> <lgl> <chr> <chr>
## 1        1     4    10 TRUE  A     NA   
## 2        2     7    10 FALSE B     1    
## 3        3     1    22 FALSE A     1    
## 4        4     3    22 TRUE  B     NA
```

# **Como realizar medidas resumos?**

## Como agrupar por variáveis estratificadoras

```r
tb %>% count(u) # lembre como era a variável "u"
```

```
## # A tibble: 2 x 2
##   u         n
##   <chr> <int>
## 1 A         2
## 2 B         2
```

## Usando o "group_by" para agrupar variáveis

<img src="https://blog.dominodatalab.com/wp-content/uploads/2019/03/Freeman_Chp11_Fig08.png" title="plot of chunk unnamed-chunk-46" alt="plot of chunk unnamed-chunk-46" width="850" />



```r
tb %>% 
      group_by(u) %>%  # agrupando por u
      summarise(x_mean = mean(x), # summarizando 
          y_range = max(y) - min(y), 
          z_desv = sd(z))
```

```
## # A tibble: 2 x 4
##   u     x_mean y_range z_desv
##   <chr>  <dbl>   <dbl>  <dbl>
## 1 A          2       3   8.49
## 2 B          3       4   8.49
```



```r
tb %>%
    group_by(u) %>% 
    summarise_if(is.numeric, mean) # Se var for numérica, calcule média.
```

```
## # A tibble: 2 x 4
##   u         x     y     z
##   <chr> <dbl> <dbl> <dbl>
## 1 A         2   2.5    16
## 2 B         3   5      16
```

## Como agrupar usando funções resumo vetoriais

```r
tb %>% 
    group_by(u) %>% 
    summarise_if(is.numeric, funs(min, median, max))
```

```
## Warning: `funs()` was deprecated in dplyr 0.8.0.
## Please use a list of either functions or lambdas: 
## 
##   # Simple named list: 
##   list(mean = mean, median = median)
## 
##   # Auto named with `tibble::lst()`: 
##   tibble::lst(mean, median)
## 
##   # Using lambdas
##   list(~ mean(., trim = .2), ~ median(., na.rm = TRUE))
```

```
## # A tibble: 2 x 10
##   u     x_min y_min z_min x_median y_median z_median x_max
##   <chr> <int> <dbl> <dbl>    <dbl>    <dbl>    <dbl> <int>
## 1 A         1     1    10        2      2.5       16     3
## 2 B         2     3    10        3      5         16     4
## # ... with 2 more variables: y_max <dbl>, z_max <dbl>
```



```r
# O verbo FILTER permite selecionar uma parte especifica dos dados para realizar sua analise. Deve ser precedido do *%>%* que significa (pegue o que estiver a frente e alimente-o na proxima etapa).

gapminder %>%
  filter (year == 2007)
```

```
## # A tibble: 142 x 6
##    country     continent  year lifeExp       pop gdpPercap
##    <fct>       <fct>     <int>   <dbl>     <int>     <dbl>
##  1 Afghanistan Asia       2007    43.8  31889923      975.
##  2 Albania     Europe     2007    76.4   3600523     5937.
##  3 Algeria     Africa     2007    72.3  33333216     6223.
##  4 Angola      Africa     2007    42.7  12420476     4797.
##  5 Argentina   Americas   2007    75.3  40301927    12779.
##  6 Australia   Oceania    2007    81.2  20434176    34435.
##  7 Austria     Europe     2007    79.8   8199783    36126.
##  8 Bahrain     Asia       2007    75.6    708573    29796.
##  9 Bangladesh  Asia       2007    64.1 150448339     1391.
## 10 Belgium     Europe     2007    79.4  10392226    33693.
## # ... with 132 more rows
```

Você poderia mudar o filtro para outra coisa


```r
gapminder %>%
  filter(country == "United States")
```

```
## # A tibble: 12 x 6
##    country      continent  year lifeExp      pop gdpPercap
##    <fct>        <fct>     <int>   <dbl>    <int>     <dbl>
##  1 United Stat~ Americas   1952    68.4   1.58e8    13990.
##  2 United Stat~ Americas   1957    69.5   1.72e8    14847.
##  3 United Stat~ Americas   1962    70.2   1.87e8    16173.
##  4 United Stat~ Americas   1967    70.8   1.99e8    19530.
##  5 United Stat~ Americas   1972    71.3   2.10e8    21806.
##  6 United Stat~ Americas   1977    73.4   2.20e8    24073.
##  7 United Stat~ Americas   1982    74.6   2.32e8    25010.
##  8 United Stat~ Americas   1987    75.0   2.43e8    29884.
##  9 United Stat~ Americas   1992    76.1   2.57e8    32004.
## 10 United Stat~ Americas   1997    76.8   2.73e8    35767.
## 11 United Stat~ Americas   2002    77.3   2.88e8    39097.
## 12 United Stat~ Americas   2007    78.2   3.01e8    42952.
```

Podemos ter multiplas condições para o filtro, basta separa-las por "," virgula.


```r
gapminder %>%
  filter(year == 2007, country == "United States")
```

```
## # A tibble: 1 x 6
##   country       continent  year lifeExp      pop gdpPercap
##   <fct>         <fct>     <int>   <dbl>    <int>     <dbl>
## 1 United States Americas   2007    78.2   3.01e8    42952.
```

# ARRANGE verbo


```r
# O verbo "arrange" classifica uma tabela baseado em uma variavel (crescente ou decrescente). É muito util quando voce deseja conhecer os valores mais extremos do conjunto do banco de dados.

gapminder %>%
  arrange(gdpPercap)
```

```
## # A tibble: 1,704 x 6
##    country       continent  year lifeExp     pop gdpPercap
##    <fct>         <fct>     <int>   <dbl>   <int>     <dbl>
##  1 Congo, Dem. ~ Africa     2002    45.0  5.54e7      241.
##  2 Congo, Dem. ~ Africa     2007    46.5  6.46e7      278.
##  3 Lesotho       Africa     1952    42.1  7.49e5      299.
##  4 Guinea-Bissau Africa     1952    32.5  5.81e5      300.
##  5 Congo, Dem. ~ Africa     1997    42.6  4.78e7      312.
##  6 Eritrea       Africa     1952    35.9  1.44e6      329.
##  7 Myanmar       Asia       1952    36.3  2.01e7      331 
##  8 Lesotho       Africa     1957    45.0  8.13e5      336.
##  9 Burundi       Africa     1952    39.0  2.45e6      339.
## 10 Eritrea       Africa     1957    38.0  1.54e6      344.
## # ... with 1,694 more rows
```

```r
# Dentro do verbo arrange voce coloca a variavel que orientará a classificacao  
```

Podemos organizar por ordem decrescente via arrange(desc())


```r
gapminder %>%
  arrange(desc(gdpPercap))
```

```
## # A tibble: 1,704 x 6
##    country   continent  year lifeExp     pop gdpPercap
##    <fct>     <fct>     <int>   <dbl>   <int>     <dbl>
##  1 Kuwait    Asia       1957    58.0  212846   113523.
##  2 Kuwait    Asia       1972    67.7  841934   109348.
##  3 Kuwait    Asia       1952    55.6  160000   108382.
##  4 Kuwait    Asia       1962    60.5  358266    95458.
##  5 Kuwait    Asia       1967    64.6  575003    80895.
##  6 Kuwait    Asia       1977    69.3 1140357    59265.
##  7 Norway    Europe     2007    80.2 4627926    49357.
##  8 Kuwait    Asia       2007    77.6 2505559    47307.
##  9 Singapore Asia       2007    80.0 4553009    47143.
## 10 Norway    Europe     2002    79.0 4535591    44684.
## # ... with 1,694 more rows
```

