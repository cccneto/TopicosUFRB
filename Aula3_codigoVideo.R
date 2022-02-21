# Curso de Introdução ao R 

# Aula 3 - Trabalhando com os verbos do Dplyr

library(gapminder)
library(dplyr)

# FILTER que serve selecionar uma parte especifica dos dados (LINHAS)

gapminder %>% 
  filter(year > 2007 | continent == "Asia")  # "|" ou

gapminder %>% 
  filter(year > 1999 & continent == "Asia")

gapminder %>% 
  filter(year > 2000, continent == "Americas", gdpPercap > 9000)

# ARRANGE - serve para ordenar linhas em ordem crescente ou descrescente

gapminder %>% 
 arrange(lifeExp) %>% 
  head(20)

gapminder %>% 
  arrange(desc(lifeExp)) %>% 
  head(20)

# organizar por ano

gapminder %>% 
  filter(year == 1997:1999) %>% 
  arrange(desc(lifeExp))

# MUTATE - serve para criar uma variavel no banco de dados
 # "cria uma nova coluna mantendo as demais do DATAFRAME

gapminder2 <- gapminder %>% 
  mutate(pop_mi = pop / 1000000)

# Combinando FILTER, ARRANGE e MUTATE

gapminder %>% 
  mutate(gdp = pop * gdpPercap) %>% # Gross domestic product
  filter(year == 2007) %>% 
  arrange(desc(gdp))

# plotando um grafico

library(ggplot2)
gapminder %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# SUMMARIZE - serve sumarizar as informações em uma linha
# resumir muitas observacoes em um unico ponto de dados . 
gapminder %>% 
     summarise(gdpPercap_median = median(gdpPercap))

gapminder %>% 
  filter(year == 2007) %>% 
  summarise(lifeExp_media = mean(lifeExp), 
            pop_tot = sum(pop))


gapminder %>% 
  filter(year == 2007) %>% 
  summarise(lifeExp_max = min(lifeExp))

# GROUP_BY - serve para agrupar em grupos os dados

gapminder %>% 
  group_by(year) %>% 
  summarize(lifeExp_mean = mean(lifeExp))

gapminder %>% 
  group_by(year) %>% 
  summarize(lifeExp_mean = mean(lifeExp),
            pop_tot = sum(pop)/1000000) # contando em milhões

gapminder %>% 
  filter(year == 1977) %>% 
  group_by(continent) %>% 
  summarise(lifeExp_mean = mean(lifeExp),
            pop_tot = sum(as.numeric(pop))/1000000, ) %>%  # contando em milhões
  arrange(lifeExp_mean)

# TRANSMUTE - cria uma coluna mas nao vai manter as colunas que ja existiam

gapminder %>% 
  mutate(lifeExp_1000 = lifeExp*1000)

dput(tb)
