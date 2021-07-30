  # EXERCICIO 1 - Referente a Aula 1


# Trabalhando com Atribuição ----------------------------------

# Crie um vetor de 6 elementos characteres, o vetor deve se chamar "nome", lembre-se de usar "c()"
nome <- c("Neto", "joao", "Maria", "Ana", "Pablo", "Meire")
# Crie um vetor de 6 elementos numéricos de 20 a 25 chamado "idade", lembre-se de usa o sinal ":"
idade <- 20:25
idade <- c(20, 21, 22, 23, 24, 25)
# Crie um vetor de 6 elementos em fomrato character, chame-o de "sexo", use "masculino", "feminino" e "outros"
sexo <- c("Feminino", "Masculino", "Feminino", "Masculino", "Feminino", "outros")

# Crie um vetor de 6 elementos chamado "estudante", atribuindo TRUE ou FALSE 
estudante <- c(TRUE, FALSE, TRUE, FALSE, TRUE, TRUE)
# Crie um vetor de 6 elementos chamado "dieta", atribuindo "vegano" ou "carnivoro" 
dieta <- c("carnivo", "carnivo", "carnivo", "vegano", "vegano", "vegano")
# Tente criar uma lista: use a função list() pegando os 5 vetores que você criou acima, 
   # e dê um nome para sua lista. 
censo_estudantil <- list(nome = nome, 
                         idade = idade, 
                         sexo = sexo, 
                         estudante = estudante, 
                         dieta = dieta)
str(estudantil)
# Trabalhando com verificação de classe ----------------------------------

# verifique a classe de cada vetor que você criou - lembre-se de usar a função "class()"
str(censo_estudantil)
# use a função "str()" e veja o que irá acontecer - por exemplo str(nomes). O que ocorreu? que resultado?
# Use a função help() para ver a ajuda na função str() - help(str). O que você percebeu?
# Use a função help() para ver a ajuda na função length() - help(length). Para que serve a função "length"?

# Indo mais além - estudantes mais avançados(as) ----------------------------------

# Crie um data.frame usando os 5 vetores criados acima - use a 
   # função que cria o dataframe orientado por colunas. 

df_censo <- data.frame(censo_estudantil) # criando um dataframe
is.data.frame(censo_estudantil) é?

df_censo_estudantil <-  as.data.frame(censo_estudantil) 
is.data.frame(df_censo_estudantil)

# Aplique a função str() e verifique seu resultado.

# Use a função nrow() e informe quantas linhas tem o dataframe
nrow(df_censo_estudantil) 
# Use a função ncol() e informe quantas colunas tem o dataframe
ncol(df_censo_estudantil) 
# verique se você realmente criou um dataframe usando a função "is.data.frame()"

