# PIVOT LONGER e PIVOR WIDER 

# pode pegar um quadro de dados que especifica precisamente 
# como os metadados armazenados nos nomes das colunas se 
# tornam variáveis de dados (e vice-versa).

library(tidyr)
library(dplyr)
library(readr)

# LONGER

# caso 1: Dados String nos nomes da colunas 

relig_income %>% View() # Usaremos essa base
# View(relig_income)


# Este conjunto de dados contém três variáveis:
  
# religião, armazenada nas linhas,
# receita espalhada pelos nomes das colunas, e
# contagem armazenada nos valores das células.

# Para arrumá-lo, usamos "pivot_longer()"

?pivot_longer   # pedindo ajuda
  
# a boa codificação
# tidyr::pivot_longer()

# Argumentos

# pivot_longer(
#   data,                xxxxxxxxxx
#   cols,               xxxxxxxxx
#   names_to = "name",    xxxxxxxxxxxx
#   names_prefix = NULL,
#   names_sep = NULL,
#   names_pattern = NULL,
#   names_ptypes = list(),
#   names_transform = list(),
#   names_repair = "check_unique",
#   values_to = "value",                xxxxx
#   values_drop_na = FALSE,             xxxxxxxxx   
#   values_ptypes = list(),
#   values_transform = list(),
#   ...
# )

# pivot_longer(data = relig_income)
# = 
# relig_income %>% pivot_longer()

relig_income %>% 
  pivot_longer(cols = !religion, # pegando tudo, menos religion
               names_to = "Renda",    # a renda 
               values_to = "Contagem") %>%   # gera a contagem de observações
    View()

relig_income2 <- relig_income %>% 
          pivot_longer(cols = 2:11,
                       names_to = "Renda",
                       values_to = "Resultado") 

relig_income %>% 
          pivot_longer(cols = 2:11, # quais colunas devo trabalhar?
              names_to = "Renda"  ,   # qual o nome da nova coluna?
              values_to = "Contagem") %>% 
              View()

            
relig_income %>% View() 


# Dados Numéricos nos nomes das colunas

# O conjunto de billboard registra a 
# classificação das músicas no quadro de avisos no ano 2000. 
# Ele tem uma forma semelhante aos dados relig_income, 
# mas os dados codificados nos nomes das colunas são, 
# na verdade, um número, não uma string.

billboard 

# vamos organizar melhor essa base 

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"),  # 
    names_to = "week", 
    values_to = "rank",
    values_drop_na = TRUE  # exclui as linhas com NA
  ) %>% View()


# Seria bom determinar facilmente quanto tempo cada música 
# permaneceu nas paradas, mas para fazer isso, 
# precisaremos converter a variável "week" em um 
# número inteiro. Podemos fazer isso usando dois 
# argumentos adicionais: "names_prefix" remove o prefixo "wk" 
# e "names_transform" converte "week" em um inteiro - integer:

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    names_prefix = "wk",
    names_transform = list(week = as.integer),
    values_to = "rank",
    values_drop_na = TRUE,
  )

# Como alternativa, você pode fazer isso com um único argumento 
# usando readr::parse_number() que 
# remove automaticamente os componentes não numéricos:

billboard %>% 
  pivot_longer(
    cols = starts_with("wk"), 
    names_to = "week", 
    names_transform = list(week = readr::parse_number), # chamar help
    values_to = "rank",
    values_drop_na = TRUE,
  )

# Nomes de colunas duplicados

df <- tibble(id = 1:3, 
             y = 4:6, 
             y = 5:7, 
             y = 7:9, 
             .name_repair = "minimal") # permite editar a coluna 'y'
df


df %>% 
  pivot_longer(cols = !id, # 
               names_to = "name", 
               values_to = "value")

# Um processo semelhante é aplicado quando várias 
# colunas de entrada são mapeadas para a mesma 
# coluna de saída, como no exemplo a seguir, em que 
# ignoramos o sufixo numérico em cada nome de coluna:
df <- tibble(id = 1:3, 
             x1 = 4:6, 
             x2 = 5:7, 
             y1 = 7:9, 
             y2 = 10:12)

df %>% pivot_longer(!id, 
                    names_to = ".value", 
                    names_pattern = "(.).")


# PIVOT WIDER

# pivot_wider() é o oposto de pivot_longer(): torna um conjunto 
# de dados mais amplo aumentando o número de colunas e 
# diminuindo o número de linhas. É relativamente raro 
# precisar de pivot_wider() para organizar os dados, 
# mas geralmente é útil para criar tabelas de resumo 
# para apresentação ou dados em um formato necessário para outras ferramentas

fish_encounters  # base de dados

# Muitas ferramentas usadas para analisar esses 
# dados precisam deles em uma forma em que cada 
# estação seja uma coluna:

fish_encounters %>% 
  pivot_wider(names_from = station,   # origem dos nomes
              values_from = seen)     # origem dos valores

# Este conjunto de dados registra apenas quando 
# um peixe foi detectado pela estação - ele não 
# registra quando não foi detectado (isso é comum 
# com este tipo de dados). Isso significa que os 
# dados de saída são preenchidos com NAs. 
# No entanto, neste caso sabemos que a ausência 
# de um registro significa que o peixe não foi 
# visto, então podemos pedir a pivot_wider()
# para preencher esses valores ausentes com zeros:

fish_encounters %>% pivot_wider(
  names_from = station, 
  values_from = seen,
  values_fill = 0   # adicionando zero onde tinha NA's
)


warpbreaks %>% 
  as_tibble() %>% 
  count(wool, tension)

# O que acontecerá se tentarmos girar os níveis de "wool" (lã) nas colunas?
warpbreaks

warpbreaks %>% 
      pivot_wider(names_from = wool,  values_from = breaks)

# Recebemos um aviso de que cada célula na saída corresponde a várias
# células na entrada. O comportamento padrão produz colunas de lista, 
# que contêm todos os valores individuais. Uma saída mais útil 
# seria estatísticas resumidas, por exemplo, 
# média de quebras para cada combinação de "wool" e "tension":

warpbreaks %>% 
  pivot_wider(
    names_from = wool, 
    values_from = breaks,
    values_fn = list(breaks = mean)   # tente com median depois
  )

# criando dados 
production <- expand_grid(
  product = c("Cana", "Leite"), 
  country = c("Bra", "Arg"), 
  year = 2000:2014
) %>%
  filter((product == "Cana" & country == "Bra") | product == "Leite") %>% 
  mutate(production = rnorm(nrow(.)))

# gerando colunas de mais de uma variavel 

# opcao 1

production %>% pivot_wider(
  names_from = c(product, country), 
  values_from = production
)

# opcao 2
production %>% pivot_wider(
  names_from = c(product, country), 
  values_from = production,
  names_sep = ".",
  names_prefix = "prod."
)

# opcao 3
production %>% pivot_wider(
  names_from = c(product, country), # o nome virá de duas colunas
  values_from = production,
  names_glue = "prod_{product}_{country}"  # ele será colado no prefixo "prod_"
)

contacts <- tribble(
  ~field, ~value,
  "name", "Jiena McLellan",
  "company", "Toyota", 
  "name", "John Smith", 
  "company", "google", 
  "email", "john@google.com",
  "name", "Huxley Ratcliffe"
)


#########################################