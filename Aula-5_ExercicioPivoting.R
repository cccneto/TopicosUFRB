# preparando os dados

relig_income2 <- relig_income %>% 
  pivot_longer(cols = 2:11,
               names_to = "Renda",
               values_to = "Resultado") 

# Quantos grupos religiosos temos nesse dataset?
relig_income2 %>% 
  distinct(religion)  # funcao serve para retornar valores distintos

# Quantos são os extratos de renda nesse dataset?
relig_income2 %>% 
  distinct(Renda)

# Quais os 3 primeiros grupos religiosos com maior número de respostas "Don't know/refused"?

relig_income2 %>% 
  group_by(Renda) %>% 
  filter(Renda == "Don't know/refused") %>% 
  arrange(desc(Resultado)) %>%  # ordenando
  slice(1:3) # pedindo apenas as 3 primeiras

# Quais os 3 primeiros grupos religiosos com menor número de respostas "Don't know/refused"?

relig_income2 %>% 
  group_by(Renda) %>% 
  filter(Renda == "Don't know/refused") %>% 
  arrange(Resultado) %>%  # ordenando
  slice(1:3) # pedindo apenas as 3 primeiras

