## ----vetores-----------------------------------------------------------------------------------------------------------------------
populacao <- c(1500, 2000) 
estados <- c("Acre", "Alagoas", "Amapá", "Amazonas", "Tocantins")
class(populacao)
class(estados)


## ----vetores2----------------------------------------------------------------------------------------------------------------------
verdadeiro_falso <- c(FALSE, TRUE)
verdadeiro_falso
class(verdadeiro_falso)
posicao <- c(1L, 2L)
posicao
class(posicao)


## ----str_length--------------------------------------------------------------------------------------------------------------------
str(estados) #estrutura
length(estados)


## ----subsetting, results = "hide"--------------------------------------------------------------------------------------------------
estados <- c("Acre", "Alagoas", "Amapá", "Amazonas", "Tocantins")
estados[1]
estados[c(TRUE, FALSE, TRUE, FALSE)]
estados[1:2]
estados[1:4]
#estados[ 1,3,5] #NAO! a vírgula marca dimensões
estados[c(1,3,5)] #tem que ser um vetor


## ----logical_clauses, results="hide"-----------------------------------------------------------------------------------------------
casos <- c(150, 200, 400, 500, 500, 600)
casos > 150
casos[casos > 150]
casos >= 150 # superior ou igual
casos < 300
casos == 200
casos != 200


## ----------------------------------------------------------------------------------------------------------------------------------
casos[casos > 150]


## ----outras, results="hide"--------------------------------------------------------------------------------------------------------
1:10
seq(1, 10, 2)
rep(1:4, 2)
rep(1:4, each = 2)
unique(casos)

sum(count)# Total 
mean(count) # Média
median(count) # Mediana
var(count) # Variância
sd(count) # desvio padrão
summary(count)# Apresenta mínimo, máximo, média mediana e 1º e 3º  quartil


## ----pacotes, eval = F-------------------------------------------------------------------------------------------------------------
## # Para instalar pacotes desde CRAN
## install.packages("remotes")
## 
## # Para instalar coronabr desde GitHub
## remotes::install_github("liibre/coronabr")
## 
## # Para carregar pacotes
## library(coronabr)
## 
## # Para buscar ajuda
## ?coronabr


## ----coronabr, echo = TRUE---------------------------------------------------------------------------------------------------------
library(coronabr)

## ----read_to_tranform_to_df--------------------------------------------------------------------------------------------------------
amapa <- read.csv("dados/brutos/01-amapa.csv", stringsAsFactors = FALSE)
class(amapa)


## ----try, echo = TRUE, eval = FALSE------------------------------------------------------------------------------------------------
## names(amapa)
## dim(amapa)
## nrow(amapa)
## ncol(amapa)
## head(amapa) # 6 linhas por padrão
## tail(amapa)
## rownames(amapa)
## length(amapa) # numero de colunas
## summary(amapa) # quantis e a média


## ----------------------------------------------------------------------------------------------------------------------------------
amapa[, 1:3] #três primeiras colunas
amapa[4, 13] #quarto elemento da coluna 13



## ----echo = FALSE------------------------------------------------------------------------------------------------------------------
plot(knitr::include_graphics("https://www.measureevaluation.org/resources/newsroom/news-images/tidy-data/image"))
knitr::include_graphics()

## ---- echo = FALSE, out.width=300--------------------------------------------------------------------------------------------------
include_graphics("figs/data_feminism.png")


## ----------------------------------------------------------------------------------------------------------------------------------
amapa <- read.csv("dados/brutos/01-amapa.csv", 
                  encoding = "UTF-8")

str(amapa)
head(amapa[c(3, 4, 9:18)])


## ----------------------------------------------------------------------------------------------------------------------------------
unique(amapa$city)

## ----------------------------------------------------------------------------------------------------------------------------------
table(amapa$place_type)

## ----------------------------------------------------------------------------------------------------------------------------------
class(amapa$date)
class(amapa$last_available_date)


## ----------------------------------------------------------------------------------------------------------------------------------
# Conversão para data
data1 <- as.Date(amapa$date[1])
data1
# Mudando o formato com a função format()
format(data1, "%d/%m/%y")
format(data1, "%d/%m/%Y")

# Mudando a data das colunas de data
amapa$date <- as.Date(amapa$date)
amapa$last_available_date <- as.Date(amapa$last_available_date)

class(amapa$date)

range(amapa$date)


## ----------------------------------------------------------------------------------------------------------------------------------
acu <- aggregate(last_available_confirmed ~ city, FUN = max, data = amapa)
acu



## ----fig.align='center'------------------------------------------------------------------------------------------------------------
barplot(acu[, 2], names.arg = acu[, 1])


## ----------------------------------------------------------------------------------------------------------------------------------
acu_or <- acu[order(acu$last_available_confirmed), ]
acu_or


## ----fig.align='center', out.width=400---------------------------------------------------------------------------------------------
barplot(acu_or[, 2], names.arg = acu_or[, 1], las = 2)


## ----fig.align='center', out.width=400---------------------------------------------------------------------------------------------
# Lendo os dados
muni_apagao <- read.csv("dados/brutos/municipios_apagao_11-2020.csv", 
                        stringsAsFactors = FALSE,
                        encoding = "UTF-8")

# Quantos municipios
table(muni_apagao$apagao)

library(tidyverse)
muni_apagao %>% 
  group_by(apagao) %>% 
  count()

# Juntando duas tabelas a partir de uma coluna comum
acu_or_apagao <- merge(acu_or, muni_apagao, 
                       by = "city", sort = FALSE)


## ----fig.align='center', out.width=400---------------------------------------------------------------------------------------------
head(acu_or)


## ----fig.align='center', out.width=400---------------------------------------------------------------------------------------------
head(acu_or_apagao)


## ----fig.align='center', out.width=400---------------------------------------------------------------------------------------------
barplot(acu_or_apagao[, 2], names.arg = acu_or_apagao[, 1], 
        col = ifelse(acu_or_apagao$apagao == "sim", "grey", "orange"), las = 2)


## ----------------------------------------------------------------------------------------------------------------------------------
estado <- amapa[amapa$place_type == "state", c(-15)]
dim(estado)


## ----------------------------------------------------------------------------------------------------------------------------------
# outra forma: onde a coluna city é NA
estado2 <- amapa[is.na(amapa$city), c(-15)]
## as duas formas tem o mesmo resultado:
all.equal(estado2, estado)


## ----------------------------------------------------------------------------------------------------------------------------------
# dados apenas de Macapa por meio do geocode do IBGE
macapa <- amapa[amapa$city_ibge_code == "1600303", c(-15)]
dim(macapa)


## ----------------------------------------------------------------------------------------------------------------------------------
if (!dir.exists("dados/processados/")) {
  dir.create("dados/processados/")
}

# Escrevendo os dados
write.csv(estado, 
          "dados/processados/02-estado_AP.csv",
          row.names = FALSE)

write.csv(macapa, 
          "dados/processados/02-municipio_Macapa.csv", 
          row.names = FALSE)


## ---- echo = FALSE, fig.align='center'---------------------------------------------------------------------------------------------
plot(last_available_confirmed ~ date, data = macapa)
lines(last_available_confirmed ~ date, data = macapa)


## ---- fig.align='center', out.width=400, echo = FALSE------------------------------------------------------------------------------
include_graphics("./figs/AP_design_ativista.png")


## ----eval = FALSE------------------------------------------------------------------------------------------------------------------
## # para o estado todo
## plot(last_available_confirmed ~ date, data = estado,
##      xlab = "Data de notificação", ylab = "Casos acumulados")
## lines(last_available_confirmed ~ date, data = estado)



## ----gif, echo = FALSE, out.width=500, fig.align='center'--------------------------------------------------------------------------
include_graphics("https://raw.githubusercontent.com/covid19br/covid19br.github.io/master/fig/gif_BE_05_junho.gif")


## ---- echo = FALSE, fig.align='center'---------------------------------------------------------------------------------------------
include_graphics("./figs/observatorio.png")


## ----obs-diarios,echo = FALSE, fig.align='center', out.width=700-------------------------------------------------------------------
include_graphics("./figs/diarios_AP.png")

