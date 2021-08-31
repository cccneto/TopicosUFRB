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
  
