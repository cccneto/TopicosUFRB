# Manipulando e Analisando um bando de dados


# Configurando ------------------------------------------------------------
library(tidyverse)
library(gapminder)

gapminder %>%  # vendo a base (6 primeiras linhas) 
  head() 


# Selecionando colunas ----------------------------------------------------

gapminder %>% 
  select(continent, year, pop) %>% 
  head(rows)


# Renomeando colunas ------------------------------------------------------

gapminder <- gapminder %>% 
    rename(Ano = year, 
         ExpecVida = lifeExp,
         Pais = country,
         Continente = continent,
         Populacao = pop, 
         pib_cap = gdpPercap) 


# Criando duas novas variáveis -----------------------------

gapminder %>% 
  arrange(Ano, Populacao) %>% 
  mutate(
    cont_pais = paste(Continente, "-", Pais),
    ExpecVida_int = round(ExpecVida)) 


# Criando variaveis sumarizando os valores --------------------------------

gapminder %>% 
  summarize(
    pop_media = mean(Populacao),
    pop_dp = sd(Populacao),
    ExpecVida_media = mean(ExpecVida),
    ExpecVida_dp = sd(ExpecVida))


# Agrupando o dataset e sumarizando ---------------------------------------


gapminder %>% 
  group_by(Continente) %>% 
  summarize(
    pop_media = mean(Populacao),
    pop_dp = sd(Populacao),
    ExpecVida_media = mean(ExpecVida),
    ExpecVida_dp = sd(ExpecVida)
    )


gapminder %>% 
  filter(Ano > 1989) %>% 
       group_by(Continente, Ano, .add = TRUE) %>% 
       summarize(
           pop_media = mean(Populacao),
           pop_dp = sd(Populacao),
           ExpecVida_media = mean(ExpecVida),
           ExpecVida_dp = sd(ExpecVida)
         )

