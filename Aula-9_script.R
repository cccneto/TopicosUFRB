library(tidyverse)

# Aula de Graficos


# Importando dados --------------------------------------------------------
chic <- readr::read_csv("https://raw.githubusercontent.com/Z3tt/R-Tutorials/master/ggplot2/chicago-nmmaps.csv")

# passo1
g <- ggplot(chic, aes(x = date, y = temp))

theme_set(theme_bw())

# Passo2
g + geom_point(color = "firebrick",
               shape = "square", 
               size = 1) 

# Passo2
g + 
geom_point(color = "firebrick", 
           shape = "square", size = 1) +
  labs(x = NULL, 
       y = "Temperatura (°F)",
       title = "Grafico Lindo",
       caption = "Fonte: Ecos do Além")  

# passo4
ggplot(chic) + aes(x = date, y = temp) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") + 
  theme(axis.title.x = element_text(vjust = 0, size = 15),
        axis.title.y = element_text(vjust = 2, size = 15))

#passo5
ggplot(chic) + aes(x = date, y = temp) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  theme(axis.title.x = element_text(margin = margin(t = 10), size = 15),
        axis.title.y = element_text(margin = margin(r = 10), size = 15))

# passo6

ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  theme(axis.title = element_text(size = 15, color = "blue",
                                  face = "italic"))

#passo7
ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  theme(axis.title.x = element_text(color = "sienna", size = 7),
        axis.title.y = element_text(color = "orangered", size = 15))

#passo8
ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  theme(axis.text = element_text(color = "dodgerblue", size = 18),
        axis.text.x = element_text(face = "italic"))


#passo9
ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 1,hjust = 1, size = 12))

#passo10
ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  theme(axis.ticks.y = element_blank(),
        axis.text.y = element_blank())

#passo11
ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  ylim(c(0, 50)) # limitando de 0 a 50
  

ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  # ylim(c(0, 50)) # limitando de 0 a 50
  # scale_y_continuous(limits = c(0, 75))
  coord_cartesian(ylim = c(0, 50))

# passo 12 - forçando a plotar na origem do grafico

chic_high <- dplyr::filter(chic, temp > 25, o3 > 20)

ggplot(chic_high, aes(x = temp, y = o3)) +
  geom_point(color = "darkcyan") +
  labs(x = "Temperature higher than 25°F",
       y = "Ozone higher than 20 ppb") +
  expand_limits(x = 0, y = 0)

# passo 13 - trabalhando com eixos de mesma escala

ggplot(chic, aes(x = temp, y = temp + rnorm(nrow(chic), sd = 20))) +
  geom_point(color = "sienna") +
  labs(x = "Temperatura (°F)", y = "Temperatura (°F) + random noise") +
  xlim(c(0, 100)) + ylim(c(0, 150)) +
  coord_fixed(1/5)

# passo 14 - alterando rótulos

ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = NULL) +
  scale_y_continuous(
    label = function(x) {return(
      paste(x, "Graus Fahrenheit"))})

# Passo 15 - "Usando o ggtitle" - configurar titulo

ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)") +
  ggtitle("Temperaturas em Chicago")

# passo 16 - plotando com todas informações

ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)",
       title = "Temperaturas em Chicago",
       subtitle = "Padrão sazonal de temperaturas diárias de 1997 a 2001",
       caption = "Dados: NMMAPS")

# passo 17 
ggplot(chic, aes(x = date, y = temp)) +
  geom_point(color = "firebrick") +
  labs(x = "Ano", y = "Temperatura (°F)",
       title = "Temperaturas em Chicago") +
  theme(plot.title = 
          element_text(face = "bold",
                                  margin = margin(10, 0, 10, 0), # top, right, bottom, left
                                  size = 14))

