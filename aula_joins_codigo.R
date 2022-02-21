# Aula Joins

library(tidyverse)

# criando variaveis
id.empregado <- 1:11
nome.empregado <- c('Renato', 'Miguel', 'Paulo', 
                    'Patrícia', 'Inês', 'Saulo', 'Diego', 
                    'Maria', 'Jose', 'Julia', 'Tiago')
idade <- c(30, 31, 29, 30, 25, 30, 30, 35, 24, 31, 29)
uf <- c('MG', 'DF', 'CE', 'DF', 'DF', 'DF', 'RJ', 'SP', 
        'RS', 'SC', 'BA')
id.cargo <- c(4, 4, 4, 4, 5, 4, 6, 3, 1, 2, 8)

# criando base de dados 
empregados <- data.frame(id.empregado, nome.empregado, idade, uf, id.cargo)


# Gerando tabela `cargos`

id.cargo <- 1:7
nome.cargo <- c('Técnico', 'Assistente', 'Consultor', 'Analista', 'Auditor', 'Gerente', 'Gestor')
salario <- c(7000, 4000, 15000, 11000, 10000, 13000, 20000)
cargos <- data.frame(id.cargo, nome.cargo, salario)

# R base - merde()
merge.r.base <- merge(empregados, cargos)

# dplyr 
join.dplyr <- inner_join(empregados, cargos)

# mudando os nomes para testar chave de busca
names(cargos) <- c("cargo", "nome.cargo", "salario")

merge.r.base <- merge(empregados, 
                      cargos, 
                      by.x = "id.cargo", 
                      by.y = "cargo") 

# "id.cargo" = "cargo"

merge.r.base # inner join com R Base,  com nomes de chaves diferentes

# dplyr 
  join.dplyr <- inner_join(empregados, 
                          cargos, 
                          by = c("id.cargo" = "cargo"))
  
  # LEFT JOIN
  
  id.paciente <- 1:9
  nome.abreviado <- c("A.A.M", "S.S.G.F", "T.I.A", "L.O.S.M", "Y.Q.W", "F.A", "T.B.N", "J.J.L", "M.S.S")
  exame.a <- c(3.8, 3.8, 3.9, 4.0, 4.4, 3.8, 3.7, 3.6, 4.0)
  exame.b <- c(109.98, 109.90, 109.89, 109.99, 110.01, 109.95, 109.98, 109.93, 110.00)
  exame.c <- c(0, 1, 1, 0, 1, 1, 0, 0, 1)
  pacientes <- data.frame(id.paciente, nome.abreviado, exame.a, exame.b, exame.c)
  pacientes
  # tabela CONTROLE
  id.paciente <- c(1, 4, 5, 7, 8, 11, 15, 25)
  tipo.remedio <- c("A", "B", "A", "B", "A", "A", "B", "B")
  controle <- data.frame(id.paciente, tipo.remedio)
  controle
  
  
  # join a esquerda 
  (left.join.r.base <- merge(x = pacientes, 
                             y = controle, 
                             all.x = TRUE)) # left join com R base
  
  # left join dplyr
  
  (left.join.dplyr <- left_join(pacientes, controle))
  
  # Right join
  
  (right.join.r.base <- merge(controle, 
                              pacientes, 
                              all.y = TRUE)) 
  # right join com dplyr 
  
  (right.join.dplyr <- right_join(controle, 
                                 pacientes)) 
# left join com dplyr
  
  
  ## FULL JOIN
  
produto <- c("A", "C", "D", "H", "I", "J", "K", "O", "Y")
valor <- c(993801, 1829300, 833952, 775831, 59143, 
           1192920, 6938018, 2927318, 393178)

(exportacoes <- data.frame(produto, valor))

produto <- c("B", "C", "D", "E", "F", "H", 
             "I", "J", "M", "N", "O", "Z")
valor <- c(983125, 71983, 61328, 51939, 10928810,
           979192, 6019278, 352918, 178263, 64129229,
           447009, 1620129)
(importacoes <- data.frame(produto, valor))

# full join VIA R base 
(full.join.r.base <- merge(exportacoes, 
                           importacoes, 
                           by.x = "produto", 
                           by.y = "produto", 
                           all.x = TRUE, 
                           all.y = TRUE)) # left join com R base

# full join via dplyr 
(full.join.dplyr <- full_join(exportacoes, 
                              importacoes, 
                              by = c("produto" = "produto")))