# Aula 3 22 novembro de 2021

# para carregar pacotes, eles tem que estar instalados
# na sua maquina (no R Studio)

# Opcao 1
install.packages("tidyverse")
install.packages("gapminder")

# opção 2
# instalar via menu -> Tools > install packages

gapminder

# depois de instalado vamos CARREGAR os 
# pacotes

library(tidyverse)
library(gapminder)
library(magrittr)

# como podemos ver dentro do pacote? 
# digitando o nome do pacote + ::
tidyverse::
gapminder::

  # vendo o objeto
gapminder
print(gapminder)
View(gapminder) # ver o objeto que estou interessado

# MAGRITTR - Serve para oferecer o operador pipe
# %>% 
CTRL + SHIFT + M = %>% 
  
  
gapminder %>% # operador pipe
  select(year) %>%
  arrange(year)

gapminder %>% 
  select(year) %>% 
  arrange(year) %>% 
  View()

select(.data = gapminder, country)
select(.data = gapminder, continent)
select(.data = gapminder, year)

###########################################
# criando um objeto tibble
tb <- tibble(x = 1:4,    # aqui estamos criando um objeto tibble
             y = c(4, 7, 1, 3), 
             z = c(10, 10, 22, 22),
             k = c(TRUE, FALSE, FALSE, TRUE),
             u = c("A", "B", "A", "B"),
             vazio = c("NA", 1 , 1, "NA")) 

# auxilio pra tirar duvidas
# vamos usar para recriar (de uma forma diferente) o 
dput(tb) 


# uma vez de posse dos dados do dput basta atribuir a um 
# novo objeto

df <- structure(list(x = 1:4, y = c(4, 7, 1, 3), 
                     z = c(10, 10, 22, 22), 
                     k = c(TRUE, FALSE, FALSE, TRUE), 
                     u = c("A", "B", "A", "B"), 
                     vazio = c("NA", "1", "1", "NA")), 
                row.names = c(NA, -4L), 
                class = c("tbl_df", "tbl", "data.frame"))

############################################################

camilla %>% 
  slice(1:80) %>% 
  dput()


camilla_80l <- camilla %>% slice(1:30)

# verbo ARRANGE
tb %>% arrange(z, y) 
camilla %>% arrange(country) # crescente
camilla %>% arrange(desc(lifeExp)) # decrescente
gapminder %>% arrange(desc(lifeExp)) # decrescente

# verbo FILTER - Serve para filtrar   
filter()

gapminder %>% filter(lifeExp < 80)
gapminder %>% filter(lifeExp > 80)
gapminder %>% filter(lifeExp == 80)
gapminder %>% filter(lifeExp <= 80)
gapminder %>% filter(lifeExp >= 80)

gapminder %>% filter(continent == "Asia") # somente asia 
gapminder %>% filter(continent != "Asia") # todos menos asia

# filtrar todos menos asia + somente ano 2007
gapminder %>% filter(continent != "Asia" & year == 2007) # 


# filtrar todos menos asia + e todos menos 2007
gapminder %>% filter(continent != "Asia" & year != 2007 & lifeExp > 80)

# filtrar usando | significa OU
gapminder %>% filter(continent == "Asia" | lifeExp > 80) 

# VERBO SLICE - recorta as linhas desejadas
gapminder %>% slice(1:6) # cortar o intervalor de 1 a 6
gapminder %>% slice(1, 4, 6) # cortar as linhas listadas no vetor
gapminder %>% slice(c(1, 4, 6)) # cortar as linhas listasdas no vetor

# slice(c(1, 4, 6)) = slice(1, 4, 6)

novo_gapminder <- gapminder %>% slice(1, 4, 6)


library(gapminder)
gapminder <- gapminder

gapminder %>% filter(continent == "Americas")

# jeito certo
gapminder_americas <- gapminder %>% 
                        filter(continent == "Americas")

# jeito errado
gapminder <- gapminder %>% filter(continent == "Americas")

# selecione as colunas relativas a pais, continent e ano
gapminder %>% select(year, continent)

# selecionar por exclusão
gapminder %>% select(-year)
gapminder %>% select(-c(continent, year))

# selecionar por intervalo
gapminder %>% select(1, 2, 3)
gapminder %>% select(1:3) # de 1 a 3
gapminder %>% select(1, 2, 5:6) # mesclando posicao e intervalo

gapminder %>% select(-(1:3))

# salvando o resultado em um novo objeto
gapminder_reduzido <- gapminder %>% select(country, continent, year) 

# funcao glimpse
glimpse(gapminder)

# selecionando por condição (classe)
select_if() # selecione se .... + a condição lógica

# is.numeric?
# is.factor?
# is.double?

# selecionar colunas fatores (factor) e double
gapminder %>% select_if(is.factor)
gapminder %>% select_if(is.double)

# selecionar usando "negate()" - excluindo
gapminder %>% select_if(negate(is.double)) 


# EXEMPLO PARA RETIRAR "NAS" PARA MICHELLE
gap_na <-
gapminder %>% 
  slice(1:10) %>% 
  mutate(dados_faltantes = c(NA, NA, NA, NA, NA, 1:5))

gap_na %>% filter(dados_faltantes != "NA")

# CRIANDO VARIAVEIS OU COLUNAS -  mutate()
starwars %>%  mutate(peso_alt = height*mass)
starwars %>%  mutate(peso_alt = as.numeric(height*mass)) %>%  View()

# declarando condiçao - "as" - significa "como"
dados_stw <- starwars %>%  mutate(peso_alt = as.numeric(height*mass))
# as.numeric = como numero

class(dados_stw$peso_alt)
 # podemos usar o mutate combinando ele com funçoes
starwars %>%  mutate(height_med = min(height)) %>% View() ### o que ta errado?

# rename() = mudar o nome da coluna
# padrao - (nome novo = nome velho)
starwars %>% rename(novo_nome = name,
                    altura = height,
                    peso = mass,
                    cor_cabelo = hair_color,
                    cor_pele = skin_color)

