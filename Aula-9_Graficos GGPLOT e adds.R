library(tidyverse)
library(ggforce)
library(ggtext)

penguins_flipper <- ggplot(penguins) +
  aes(x = flipper_length_mm, y = body_mass_g, color = species) +
  geom_point(show.legend = T) +
  geom_mark_ellipse(aes(fill = species, label = species)) +
  labs(x = "Flipper length", y = "Body mass",
       title = "Palmer penguins flipper length and body mass") +
  theme_minimal())

iris <- iris

ggplot(iris) +
  aes(x = Sepal.Length, y = Petal.Length, color = Species) +
  geom_point(show.legend = NULL) +
  geom_mark_ellipse(aes(label = Species, fill = Species)) +
  labs(x = "Flipper length", y = "Body mass",
       title = "Bill Dimensions of Brush-Tailed Penguins <i style='color:#28A87D;'>Pygoscelis</i>",
       subtitle = "Novas origens de teste",
       caption = "Fonte nova")  +
  theme_minimal() + 
  theme(plot.title = element_markdown(face = 'bold'),
        plot.caption = element_markdown(margin = margin(t = 8)),
        axis.title.x = element_markdown(),
        axis.title.y = element_markdown())
