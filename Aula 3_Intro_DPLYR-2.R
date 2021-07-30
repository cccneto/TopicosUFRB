library(gapminder) 
library(dplyr) 

gapminder

# *FILTER*

# O verbo FILTER permite selecionar uma parte especifica dos 
# dados para realizar sua analise. Deve ser precedido do *%>%* 
# que significa (pegue o que estiver a frente e alimente-o na proxima etapa).

gapminder %>%
  filter (year == 2007)


# Você poderia mudar o filtro para outra coisa

gapminder %>%
  filter(country == "United States")

# Podemos ter multiplas condições para o filtro, basta 
# separá-las por "," virgula.

gapminder %>%
  filter(year == 2007, country == "United States")

# *ARRANGE*


# O verbo "arrange" classifica uma tabela baseado em uma 
# variavel (crescente ou decrescente). É muito util quando 
# voce deseja conhecer os valores mais extremos do conjunto 
# do banco de dados.

gapminder %>%
  arrange(gdpPercap)

# Dentro do verbo arrange voce coloca a variavel que orientará 
# a classificacao  

# Podemos organizar por ordem decrescente via arrange(desc())
gapminder %>%
  arrange(desc(gdpPercap))


# Suponha que voce deseja encontrar (paises com maior gdp 
# em apenas um ano)
gapminder %>%
  filter(year==2007) %>%
  arrange(desc(gdpPercap))


# **MUTATE** verbo

# Serve para mudanças nas variaveis ou adicionar variaveis

gapminder %>%
  mutate(pop = pop / 1000000)

# Suponha que eu deseje **CRIAR** uma nova variavel, por exemplo, 
# o PIB total dos paises.


# aqui devemos usar "=" 

gapminder %>%
  mutate(gdp = gdpPercap * pop)


# Combinando os verbos (filter, arrange, mutate) 
# para descobrir: quais os paises com maior PIB no ano de 2007.


# Precisamos: 1) criar a nova variavel, 2) filtrar pelo ano, 
# 3) organizar por valores decrescentes

gapminder %>%
  mutate(gdp = gdpPercap * pop) %>%
  filter(year == 2007) %>%
  arrange(desc(gdp)) 


## PLOTANDO seus dados I
library(ggplot2)
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()


# Aquivamos vamos usar o pacote ggplot2.
# Uma explicação importante adicional: algumas vezes 
# quando voce trabalha continuamente com os dados filtrados 
# por uma variavel (subjconjunto), algumas vezes é útil salvar os 
# dados filtrados, como um novo conjunto de dados.


gapminder_2007 <- gapminder %>%
  filter(year == 2007)

gapminder_2007

# Suponha que voce queira examinar a relação entre a 
# riqueza de um pais e sua expectativa de vida.


ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()


# *AES*, aesthetic é uma dimensao visual de um grafico que pode 
# ser usada para comunicar informacoes.
# *GEOM_POINT*, voce está adicionando um objeto geometrico ao 
# grafico, trata-se de especificar o tipo de grafico que voce está criando.

# LOG SCALES 

# Fizemos o grafico acima, e percebemos que paises de renda mais alta, 
# tem maior expectativa de vida. Um problema com esse grafico, no entanto, 
# é que muitos paises ficam amontoados na parte mais à esquerda do eixo x.
# Isso ocorreu porque a distribuicao do pib per capita abrange varias ordens 
# de magnitude, com alguns paises na casa das dezenas de milhares de dolares e 
# outros na casa das centenas.
# Quando um de nossos eixos apresenta essa distribuição, é util trabalhar 
# com uma escala logaritimica, ou seja, uma escala em que cada distância 
# fixa representa uma multiplicacao do valor.


# VAMOS FAZER ALGO NOVO E DIFERENTE

# Vamos fazer o nosso primeiro grafico, para isso basta você rodar 
# os comandos abaixo.

# para criar o grafico voce precisa chamar o pacote GGPLOT2
library(ggplot2)

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()  # veja o que vai aparecer ao lado no "Plots"

# Esses sao os mesmo dados, mas agora cada unidade no 
# eixo x representa uma mudança de 10 vezes o PIB.

# Nesse novo grafico podemos ver os dados de uma maneira 
# mais linear, e podemos distinguir mais facilmente os paises 
# na extremidade inferior do espectro.

# **Algumas vezes ambos os eixos devem ser convertidos para a 
# escala de log.


# Criando o gapminder filtrado para o ano 1952 
gapminder_1952 <- gapminder %>% 
  filter(year == 1952)

# Plotando com ambos os eixos com escala de log

ggplot (gapminder_1952, aes(x = pop, y = gdpPercap)) +
  scale_x_log10() + 
  scale_y_log10() +
  geom_point()


# ESTÉTICA ADICIONAL - additional aesthetics

# Nós aprendemos como criar uma plotagem de duas variaveis e assim 
# enxergar sua relacao. O nosso banco de dados "gapminder" possui outras 
# variaveis que podem também ser utilizadas, de maneira a entendermos outros 
# relacionamentos entre elas.
# Ate aqui usamos populacao como eixo X, e pib per capita como eixo y. 
# Agora vamos aprender a usar mais duas esteticas adicionais, COLOR and SIZE 
# e para isso vamos utilizar as variaveis continente e pais.

# Observe que continente é uma variavel categórica, e por isso 
# apresenta valores bem especificos. Uma *boa maneira de apresentar 
# variaveis categorias em um gráfico* é através da dimensao COLOR.

ggplot (gapminder_2007, aes(x = gdpPercap, y =lifeExp, color = continent)) +
  scale_x_log10() + 
  geom_point()


# Observe que populacao (pop) é uma variavel numérica, 
# uma *boa maneira de apresentar variaveis numericas um gráfico* é
# através da dimensao SIZE, que significa "tamanho".

ggplot (gapminder_2007, 
        aes(x = gdpPercap, 
            y =lifeExp, 
            color = continent, 
            size = pop)) +
  scale_x_log10() + 
  geom_point()


# FACETING 

# Esse verbo serve para dividir nossa plotagem em subtramas para 
# uma obter uma melhor visualizacao em um grafico menor para cada 
# continente (por exemplo).

ggplot (gapminder_2007, 
        aes(x = gdpPercap, 
            y =lifeExp, 
            color = continent)) +
  geom_point() + 
  scale_x_log10() + 
  facet_wrap(~ continent) # "~" signica "por"


### CALCULO
gapminder %>%
  summarize(sumPop = sum(as.numeric(pop)))

gapminder_1952_2007 <- gapminder %>%
  filter(year == 1952|2007)

# aqui eu estou pedindo os anos entre 1952 a 2007
ggplot(gapminder_1952_2007, 
       aes(x = gdpPercap, 
           y = lifeExp, 
           color = continent, 
           size = pop)) + 
  geom_point()+
  scale_x_log10()+
  facet_wrap(~year)


# SUMMARIZE verbo

# Agora voce aprendera a resumir muitas observacoes 
# em um unico ponto de dados . 

gapminder %>%
  summarize(meanLifeExp = mean(lifeExp))

# Faz mais sentido analisar a media da expectativa de 
# vida para um ano em especifico, por exemplo.
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp))


# Podemos acrescentar mais detalhes a nossa funcao summarize
gapminder %>%
  filter(year == 2007) %>%
  summarize(meanLifeExp = mean(lifeExp), 
            totalPop = sum(as.numeric(pop)))

# Podemos ainda summarizar via "mediana - median", "minimo - min" 
# e "maximo - max"

gapminder %>%
  filter(year == 2007) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap)) 

# Verbo *GROUP_by*

# Em um dos exemplos acima, nós encontramos a media da expectativa de 
# vida e o total da populacao para o ano de 2007. Mas e se nao quisemos apenas 
# para 2007? Mas em cada ano do conjunto.

# **group_by()** antes do **summarize()** transforma em grupos dentro de uma 
gapminder %>%
  group_by(year) %>%
  summarize(meanLifeExp = mean(lifeExp), sumPop = sum(as.numeric(pop)))

# Sumarizando pelo continente
gapminder %>%
  filter(year == 2002) %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp), 
            sum(as.numeric(pop))
  )

# observe que temos um problema no continente ASIA. Há dados missing NA 

# Agora que calculamos essas estatisticas para 2002, 
# voce pode estar interessado em como elas mudaram para 
# cada continente ao longo do tempo.  

gapminder %>%
  group_by(year, continent) %>%
  summarize(meanLifeExp = mean(lifeExp), sum(as.numeric(pop)))

# devo lembrar porque estou usando as.numeric()
# observe que temos um problema no continente ASIA. 
# Há dados missing NA 


# EXERCICIO I

# Encontre a esperança média de vida e o PIB per capita máximo
# em cada continente em 1957

# Resposta

gapminder %>%
  filter(year == 1957) %>%
  group_by(continent) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))

# EXERCICIO II

# Encontre a esperança média de vida e o PIB per capita máximo
# em cada combinação continente / ano

# Resposta

gapminder %>%
  group_by(continent, year) %>%
  summarize(medianLifeExp = median(lifeExp), 
            maxGdpPercap = max(gdpPercap))
