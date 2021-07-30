library(gapminder) 
library(dplyr) 

gapminder

# *FILTER*

# O verbo FILTER permite selecionar uma parte especifica dos dados para realizar sua analise. Deve ser precedido do *%>%* que significa (pegue o que estiver a frente e alimente-o na proxima etapa).

gapminder %>%
  filter (year == 2007)


# Você poderia mudar o filtro para outra coisa

gapminder %>%
  filter(country == "United States")

# Podemos ter multiplas condições para o filtro, basta separá-las por "," virgula.

gapminder %>%
  filter(year == 2007, country == "United States")

# *ARRANGE*


# O verbo "arrange" classifica uma tabela baseado em uma variavel (crescente ou decrescente). É muito util quando voce deseja conhecer os valores mais extremos do conjunto do banco de dados.

gapminder %>%
  arrange(gdpPercap)

# Dentro do verbo arrange voce coloca a variavel que orientará a classificacao  

# Podemos organizar por ordem decrescente via arrange(desc())
gapminder %>%
  arrange(desc(gdpPercap))


# Suponha que voce deseja encontrar (paises com maior gdp em apenas um ano)
gapminder %>%
  filter(year==2007) %>%
  arrange(desc(gdpPercap))


# **MUTATE** verbo

# Serve para mudanças nas variaveis ou adicionar variaveis

gapminder %>%
  mutate(pop = pop / 1000000)

# Suponha que eu deseje **CRIAR** uma nova variavel, por exemplo, o PIB total dos paises.


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


# Criando o grafico usando o log scale

ggplot(gapminder_2007, aes(x = gdpPercap, y = lifeExp)) +
  geom_point() + 
  scale_x_log10()
 


# Esses sao os mesmo dados, mas agora cada unidade no eixo x 
# representa uma mudança de 10 vezes o PIB.
 
# Nesse novo grafico podemos ver os dados de uma maneira mais linear, 
# e podemos distinguir mais facilmente os paises na extremidade inferior do espectro.

# **Algumas vezes ambos os eixos devem ser convertidos para a escala de log.


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

## PLOTANDO seus dados sumarizados

by_year <-  gapminder %>%
  group_by(year) %>%
  summarize( medianLifExp = median(lifeExp), 
             totalPop = sum(as.numeric(pop)))

by_year 

# Visualização da população no tempo

ggplot(by_year, 
       aes(x = year, 
           y = totalPop)) +
  geom_point()


# *Começando o eixo y do zero*

ggplot(by_year, aes(x = year, y = totalPop)) +
  geom_point() +
  expand_limits(y=0)

ggplot(by_year, aes(x = year, y = medianLifExp)) +
  geom_point() +
  expand_limits(y=0)

# *Sumarizando por ano e continente*
by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(totalPop = sum(as.numeric(pop)), 
            meanLifeExp = mean(lifeExp))

by_year_continent

# Vamos agora visualizar "by_year_continent" pela estetica de cores

ggplot(by_year_continent, 
       aes(x = year, 
           y = totalPop, 
           color = continent)) +
  geom_point() +
  expand_limits(y=0)

# Exercicio

# Resuma medianGdpPercap dentro de cada continente dentro
# cada ano: by_year_continent

by_year_continent <- gapminder %>%
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Plot a mudança em medianGdpPercap em cada continente ao longo do tempo
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, color = continent)) +
  geom_point() +
  expand_limits(y=0)


# Exercicio 


# Resuma (summarize()) o PIB mediano e a expectativa de vida mediana por continente em 2007
by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap), 
            medianLifeExp = median(lifeExp))

# Use o scatter plot para comparar o "median GDP" e a expectativa de vida mediana
ggplot(by_continent_2007, aes(x = medianGdpPercap, 
                              y = medianLifeExp, 
                              color = continent)) + 
  geom_point() +
  expand_limits(y=0)


# SCATER VS LINE PLOT

# Um gráfico de linha é útil para visualizar tendências ao longo do tempo.
# Neste exercício, você examinará como o PIB per capita mediano
# mudou com o tempo.
# Para criar o grafico de linhas, basta usar o comando *geom_line()*.

by_year_continent <- gapminder %>%
                  group_by(year, continent) %>%
                  summarize(totalPop = sum(as.numeric(pop)), 
                  meanLifeExp = mean(lifeExp))

ggplot(by_year_continent, 
       aes(x = year, 
           y = meanLifeExp, 
           color = continent)) + 
  geom_line() +
  expand_limits(y = 0)



# Exercicio 

# Use group_by () e sumarize () para encontrar o PIB mediano
# per capita em cada ano, chamando a coluna de saída medianGdpPercap.
# Use o operador de atribuição <- para salvá-lo em um conjunto de dados chamado by_year.
# Use o conjunto de dados by_year para criar um gráfico de linha mostrando a mudança em
# PIB médio per capita ao longo do tempo. Certifique-se de usar expand_limits (y = 0)
# para incluir 0 no eixo y.

# Resuma o gdpPercap mediano por ano e salve-o como por_ano

by_year <- gapminder %>%
                group_by(year) %>%
                summarize(medianGdpPercap = median(gdpPercap))

# Crie um gráfico de linha mostrando a mudança em medianGdpPercap ao longo do tempo
ggplot(by_year, aes(x = year, y = medianGdpPercap)) +
          geom_line() +
          expand_limits(y=0)



# Exercicio 

# Agora você examinará a mudança dentro de cada continente.

# Use group_by () e sumarize () para encontrar a mediana do PIB por
# capita em cada ano e continente, chamando a coluna de saída medianGdpPercap.
# Use o operador de atribuição <- para salvá-lo em um conjunto de dados chamado 
# by_year_continent. Use o conjunto de dados by_year_continent para criar 
# um gráfico de linha mostrando a mudança em
# PIB médio per capita ao longo do tempo, com a cor representando o continente.
# Certifique-se de usar expand_limits (y = 0) para incluir 0 no eixo y.


# Resuma o gdpPercap mediano por ano e continente, salve como por_ano_continente
by_year_continent <- gapminder %>% 
  group_by(year, continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Crie um gráfico de linha mostrando a mudança em medianGdpPercap 
# por continente ao longo do tempo
ggplot(by_year_continent, aes(x = year, y = medianGdpPercap, 
                              color = continent)) + 
  geom_line() +
  expand_limits(y = 0)

#  BAR PLOTS - Grafico de barras

# O graficos de barra sao uteis para voce comparar valores entre 
# categorias distintas, como continentes.Por exemplo, vimos que 
# para encontrar a expectativa de vida média em cada continente em 2007, 
# precisamos do seguinte código. Ele criará uma tabela com uma observação 
# para cada continente. 


by_continent_2007 <- gapminder %>%
  filter(year == 2007) %>%
  group_by(continent) %>%
  summarize(meanLifeExp = mean(lifeExp))

by_continent_2007

# Use group_by () e sumarize () para encontrar a mediana
# PIB per capita dentro de cada continente no ano de 1952,
# chamando a coluna de saída medianGdpPercap. Use o
# operador de atribuição <- para salvá-lo em um conjunto de dados 
# chamado by_continent.

# Use o conjunto de dados by_continent para criar um gráfico de barra 
# mostrando o PIB médio per capita em cada continente.
# Em vez de imprimir a tabela, podemos este resumo visualmente.


# Exercicio 

# Resuma (summarize) o gdpPercap mediano por continente em 1952
by_continent <- gapminder %>%
  filter(year == 1952) %>%
  group_by(continent) %>%
  summarize(medianGdpPercap = median(gdpPercap))

# Crie um bar plot mostrando medianGdp por continent
ggplot(by_continent, aes(x = continent, y = medianGdpPercap)) +
  geom_col()


# Exercicio

# Visualização do PIB per capita por país na Oceania
# Você criou um gráfico onde cada barra representa um continente,
# mostrando a mediana do PIB per capita para cada um. Mas o eixo x de
# o gráfico da barra não precisa ser o continente: em vez disso, você pode
# cria um gráfico de barra onde cada barra representa um país.
#
# Neste exercício, você criará um gráfico de barras comparando o PIB por
# capita entre os dois países do continente Oceania
# (Austrália e Nova Zelândia).


# INSTRUÇÕES

# Filtro para observações no continente da Oceania no ano de 1952.
# Salve como oceania_1952.

# Use o conjunto de dados oceania_1952 para criar um gráfico de barra,
# com o país no eixo xe gdpPercap no eixo y.

# Filtro para observações no continente da Oceania em 1952
oceania_1952 <- gapminder %>%
                filter(year == 1952, continent == "Oceania") %>%
                group_by(country, continent)

# Crie um bar plot de gdpPercap por country
ggplot(oceania_1952, 
       aes(x = country, 
           y = gdpPercap)) +
        geom_col()


# HISTOGRAMAS

# Ate agora haviamos investigados a relacao entre 
# duas variaveis ao mesmo tempo. Aqui veremos como investigar 
# uma dimensao dos dados por vez, usando um histograma.


ggplot(gapminder_2007, aes(x = lifeExp)) + 
  geom_histogram()


# No grafico acima, temos no eixo x a expectativa de vida em anos, 
# enquanto que no eixo y (vertical), temos o numero de paises que 
# apresentam essa expectativa. O que podemos ver com esses dados?

# A largura de cada histograma é escolhida automaticamente, 
# e isso tem um grande efeito sobre como o histograma comunica 
# a distribuicao. Podemos alterar essa largura via opção _ binwidth_ que 
# colocamos dentro da camada geom_histogram()

ggplot(gapminder_2007, aes(x = lifeExp)) + 
  geom_histogram(binwidth = 5)

# ao definirmos binwidth = 5 significa que cada uma das barras 
# nos histogramas representa uma largura de 5 anos. 

# Ao fazermos isso convertemos o visual da distribuicao mais 
# em bloco, e isso significa que estamos mais interessados na 
# forma mais geral do que nos pequenos detalhes. 


# Exercicio *Visualizing population* 

# Um histograma é útil para examinar a distribuição
# de uma variável numérica. Neste exercício, você criará um
# histograma mostrando a distribuição das populações do país (em milhões)
# no ano de 1952.
#
# O código para gerar este conjunto de dados, gapminder_1952, é fornecido.


# Use o conjunto de dados gapminder_1952 para criar um histograma do país
# população (pop_by_mil) no ano de 1952. Dentro do geom do histograma,
# defina o número de compartimentos para 50.

gapminder_1952 <- gapminder %>%
  filter(year == 1952) %>%
  mutate(pop_by_mil = pop / 1000000)

# Crie um histograma da população(pop_by_mil)
ggplot(gapminder_1952, aes(x = pop_by_mil)) + 
  geom_histogram(bins = 50)


# Exercicio 

# * Visualização da população com o eixo x em uma escala logarítmica *

# No último exercício, você criou um histograma de grupos
# entre países. Você deve ter notado que havia vários
# países com uma população muito maior do que outros, o que causa
# a distribuição deve ser muito distorcida, com a maior parte da distribuição
# espremido em uma pequena parte do gráfico. (Considere que é difícil
# dizer a mediana ou a população mínima desse histograma).
#
# Para tornar o histograma mais informativo, você pode tentar colocar
# eixo x em uma escala logarítmica.

# Use o conjunto de dados gapminder_1952 (o código é fornecido) para
# criar um histograma da população do país (pop) no ano de 1952,
# colocando o eixo x em uma escala logarítmica com scale_x_log10 ().

gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a histogram of population (pop), with x on a log scale
ggplot(gapminder_1952, aes(x = pop)) + 
      geom_histogram(bins = 50) +
      scale_x_log10()


# BOX PLOTS 

# Antes lembre-se que usamos o histograma quando queríamos 
# examinar a distribuicao de *uma variavel*, da expectativa de vida, 
# em todos os paises. O histograma combina todas as expectativas de vida 
# em todos os continentes, sem distingui-las.

ggplot(gapminder_2007, aes(x = lifeExp)) + 
  geom_histogram(binwidth = 5)

# Mas e se desejarmos comparar a distribuicao das expectativas 
# de vida entre os *continentes*?


ggplot(gapminder_2007, aes(x = continent, y = lifeExp)) + 
  geom_boxplot()

# este é um gráfico que mostra a distribuicao das expectativas 
# de vida dentro de cada continent, para que voce possa compara-la.

# observe: x = continentes (categoria)
#          y = os valores de expectativa de vida

# Um grafico de caixa requer um pouco de pratica para interpretar. 
# No exemplo acima temos: 

# - A *linha preta* no meio de cada caixa é a *mediana* da distribuicao de 
# *cada continente*.
# - As partes superior e inferior de cada caixa representam o 75º percentil 
# e o 25º percentil desse grupo, ou seja, metade da distribuicao está dentro 
#  dessa caixa. 
# _ As *linhas* subindo e descendo das caixas sao chamados de *bigodes* 
#   (whiskers) cobrem paises adicionais. 
# _ Os *pontos* abaixo ou acima dos bigodes representam valores 
# extremos. Ou seja, paises com expectativa de vida exponencialmente 
# baixa em relacao ao restante da distribuicao.

# Portanto, ha muita coisa que esse enredo nos fala sobre diferencas 
# na expectativa de vida nos continentes. Podemos ver que a expectativa 
# média de vida da Europa é uma das mais altas e que os paises da Oceania 
# tem valores muito altos. E tambem podemos ver que a distribuicao para a 
# Africa e extraordinariamente baixa, com cerca da metade de seus paises 
# tendo uma expectativa media de vida entre 50 e 60 anos.

# Exercicio *Comparing GDP per capita across continents*

# Um boxplot é útil para comparar uma distribuição de valores
# em vários grupos. Neste exercício, você examinará o
# distribuição do PIB per capita por continente. Já que o PIB per capita
# varia em várias ordens de magnitude, você precisará colocar
# o eixo y em uma escala logarítmica.
# 
# Use o conjunto de dados gapminder_1952 (o código é fornecido) para criar
# um boxplot comparando o PIB per capita (gdpPercap) entre os continentes.
# Coloque o eixo y em uma escala logarítmica com scale_y_log10().


gapminder_1952 <- gapminder %>%
  filter(year == 1952)

# Create a boxplot comparing gdpPercap among continents
ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
      geom_boxplot() +
      scale_y_log10()


# Exercicio *Adding a title to your graph*

# Existem muitas outras opções para personalizar um ggplot2
# gráfico, que você pode aprender sobre em outros cursos do DataCamp.
# Você também pode aprender sobre eles em recursos online, que é um
# habilidade importante para desenvolver.
# 
# Como exercício final neste curso, você praticará
# procurando instruções do ggplot2 completando uma tarefa que não mostramos
# você como fazer.
# 
# Adicione um título ao gráfico: Comparação do PIB per capita entre os continentes.
# Use um mecanismo de busca, como Google ou Bing, para aprender como fazer isso.

# Add a title to this graph: "Comparing GDP per capita across continents"
p <- ggplot(gapminder_1952, aes(x = continent, y = gdpPercap)) +
  geom_boxplot() +
  scale_y_log10()
  
# Add titles
g <- p + labs(title = "Comparing GDP per capita across continents")
g  

# Observe que precisamos da camada labs()

