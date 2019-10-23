"
  Distancia euclidiana:
  
  
  Distancia manhatan:

  
  Distancia (equivalente a escalar os dados):

  Distancia de correlação:
  Busca o mesmo comportamento, não a mesma escala.
  

  TAREFA:
  Implementar a distancia de manhatan e a de correlação.
  Pegar algoritmo de agrupamento KNN e substituir as distancias

"
# ----------------------------------------------------
# FUNCOES DAS DISTANCIAS
# ----------------------------------------------------

# Distancia euclidiana
  D_euclidiana = function(A,B){ return(sqrt(sum((A-B)^2))) } # calcula distancia

# Distancia de manhatan
  D_manhattan = function(A,B){ return(sum(abs(A-B))) }
  
  # Testando
  A = c(1, 2, 3, 4, 5)
  B = c(6, 7, 8, 9, 10)
  dist(rbind(A,B), method = "manhattan")
  D_manhattan(A,B)
  D_manhattan(B,A)

# Distancia de correlação
  D_correlation = function(x,y){
    n = length(x)
    output = (n*sum(x*y) - sum(x)*sum(y))/(sqrt(n*sum(x^2) - sum(x)^2) * sqrt(n*sum(y^2) - sum(y)^2))
    return(output)
  }
  # OBS: Quando os elementos estao muito perto, essa distancia eh 1. 
  # Porem, estamos chamando de muito perto para as outras funcoes quando a distancia eh 0, nao 1.
  # Para que a funcao de manhattan retorne 0 quando os elementos estiverem muito proximos ou
  # no mesmo lugar eh necessario fazer uma transformada.
  
  D_correlation_transform = function(x,y){
    dist_original = D_correlation(x,y)
    dist_new = 1-dist_original
    return(round(dist_new, 2))
  }
  
  
  # Testando
  C = c(1, 2, 3, 4, 5)
  D = c(10, 20, 30, 40, 50)
  cor(C, D)
  D_correlation(C, D) # Mostra 1
  D_correlation_transform(C, D) # Mostra 0
  
  E = c(1, 2, 3, 4, 5)
  G = c(3, 27, 41, 20, 94)
  cor(E, G)
  D_correlation(E, G) # Mostra ~ 0.8
  D_correlation_transform(G, E) # Mostra 0.2
  
# ----------------------------------------------------
# FUNCAO GENERICA DO KNN COM DIFERENTES DISTANCIAS PARA BANCO DE MANA
# ----------------------------------------------------

# Funcao que recebe varios e retorna varios que foram preditos
# x-> quem vai ser adivinhado (nao tem label, pois a gente vai tentar adivinhar)
# X-> os dados reais (quem vc conhece)
# L -> labels/classes conhecidas
# met.dist -> "e" (euclidiana), "m" (manhatan) e "c" (correlacao)
KNN.generico <- function(x, X, L, k=3, met.dist="e"){ # Se o usuario nao preencher o k, por default é 3
  m=nrow(x)
  n = nrow(X)
  
  if (is.null(m)){ m = 1 }
  
  P = NULL # variavel que guarda as predicoes
  P$class = 0*(1:m) # inicializa o vetor de predições
  for(j in 1:m){
    d = 0*(1:n)
    for(i in 1:n){
      if (met.dist == "e"){
        d[i] = D_euclidiana(x[j,], X[i,])
      }
      else{
        if (met.dist == "m"){
          d[i] = D_manhattan(x[j,], X[i,])
        }
        if (met.dist == "c"){
          d[i] = D_correlation_transform(x[j,], X[i,])
        }
      }
      
    }
    o = order(d) # Ordena os indices das menores distancias (quem sao as pessoas mais proximas) 
    
    # o[1:k] -> obtem as k pessoas mais próximas
    # L[o[1:k]] -> Obtem as k classes das pessoas mais próximas
    # sort(table(L[o[1:k]]) -> mostra a tabela com as classes que mais apareceram (decresing=T)
    vote = sort(table(L[o[1:k]]), decreasing = TRUE) # Obtem as classes dos k vizinhos mais proximos
    
    # No exemplo anterior a gente convertia as classes como numeric, mas para esses dados as classes sao strings ("M" ou "B")
    #P$class[j] = as.numeric(names(vote[1]))
    
    # Quando dar problema de tipo há duas alternativas:
    # Ou altera o código (se tiver acesso ao código fonte)
    # Ou muda o tipo da variável no banco
    
    # Nesse caso, foi facil e apenas alteramos o tipo
    P$class[j] = names(vote[1])
  } 
  
  # Retorna a classe mais votada para ser a do gamer que estamos tentando adivinhar
  return(P) 
}
  

# ----------------------------------------------------
# APLICANDO NO BANCO DA MAMA
# ---------------------------------------------------- 
  # Obtendo os dados
  data_mama = read.delim("wdbc.data", sep = ",", header = FALSE)
  head(data_mama) # As colunas sao os atributos da imagem
  
  labs = data_mama[,2] # Classes (MALIGNO OU BENIGNO)
  ids = data_mama[,1] # IDs
  head(ids)
  head(labs)
  
  y = data_mama[,c(-1,-2)] # tira a coluna 1 e 2
  y = scale(y) # IMPORTANTE
  
  rownames(y) = ids # coloca os IDs como nome das linhas 
  k = seq(1, ncol(y), by=3) 
  y = y[,k] # Pega um terco das colunas
  n = nrow(y)
  set.seed(1234)
  
  mconfu = matrix(0, 2, 2) # matriz preenchida com zeros
  p = 0.8 # porcentagem dos dados que sera utilizada para treino
  
  # Pegando os dados de treino
  t = sample(1:n, floor(p*n)) 
  yt = y[t,]
  labt = labs[t]
  
  # -----------------------------------------------------
  # Predizendo com o metodo de distancia euclidiano
  # -----------------------------------------------------
  P_e = KNN.generico(y[-t,], yt, labt, k=1, met.dist = "e")
  
  # acertos
  mconfu[1,1] = sum((labs[-t] == "B") & (P_e$class == "B"))
  mconfu[2,2] = sum((labs[-t] == "M") & (P_e$class == "M"))
  #erros
  mconfu[1,2] = sum((labs[-t] == "B") & (P_e$class == "M"))
  mconfu[2,1] = sum((labs[-t] == "M") & (P_e$class == "B"))
  
  print("Quantidade total de acertos:")
  sum(diag(mconfu)) # soma a quantidade de acertos da matriz de confusao
  print("Quantidade total da matriz:")
  sum(mconfu) # Soma a quantidade total da matriz
  print("Porcentagem de acerto:")
  p_acerto_e = sum(diag(mconfu))/sum(mconfu); p_acerto_e
  
  # -----------------------------------------------------
  # Predizendo com o metodo de distancia manhattan
  # -----------------------------------------------------
  P = KNN.generico(y[-t,], yt, labt, k=1, met.dist = "m")
  
  # acertos
  mconfu[1,1] = sum((labs[-t] == "B") & (P$class == "B"))
  mconfu[2,2] = sum((labs[-t] == "M") & (P$class == "M"))
  #erros
  mconfu[1,2] = sum((labs[-t] == "B") & (P$class == "M"))
  mconfu[2,1] = sum((labs[-t] == "M") & (P$class == "B"))
  
  print("Quantidade total de acertos:")
  sum(diag(mconfu)) # soma a quantidade de acertos da matriz de confusao
  print("Quantidade total da matriz:")
  sum(mconfu) # Soma a quantidade total da matriz
  print("Porcentagem de acerto:")
  p_acerto = sum(diag(mconfu))/sum(mconfu); p_acerto
  
  # -----------------------------------------------------
  # Predizendo com o metodo de distancia de correlacao
  # -----------------------------------------------------
  P = KNN.generico(y[-t,], yt, labt, k=1, met.dist = "c")
  
  # acertos
  mconfu[1,1] = sum((labs[-t] == "B") & (P$class == "B"))
  mconfu[2,2] = sum((labs[-t] == "M") & (P$class == "M"))
  #erros
  mconfu[1,2] = sum((labs[-t] == "B") & (P$class == "M"))
  mconfu[2,1] = sum((labs[-t] == "M") & (P$class == "B"))
  
  print("Quantidade total de acertos:")
  sum(diag(mconfu)) # soma a quantidade de acertos da matriz de confusao
  print("Quantidade total da matriz:")
  sum(mconfu) # Soma a quantidade total da matriz
  print("Porcentagem de acerto:")
  p_acerto = sum(diag(mconfu))/sum(mconfu); p_acerto
  
  
  
  
# ----------------------------------------------------
# OUTRAS COISASS
# ----------------------------------------------------  
  
# ----------------------------------------------------
# FUNCOES DOS KNNs COM DIFERENTES DISTANCIAS
# ----------------------------------------------------
  # Funcao que recebe varios e retorna varios que foram preditos
  # x-> quem vai ser adivinhado (nao tem label, pois a gente vai tentar adivinhar)
  # X-> os dados reais (quem vc conhece)
  # L -> labels/classes conhecidas
  KNN.manhattan <- function(x, X, L, k=3){ # Se o usuario nao preencher o k, por default é 3
    n = nrow(X)
    d = 0*(1:n) # inicializa o vetor com zero em n posições
    for(i in 1:n){
      d[i] = D_manhattan(x, X[i,]) # Calcula a distancia entre quem vamos adivinhar contra todos os outros gamers
    } 
    o = order(d) # Ordena os indices das menores distancias (quem sao as pessoas mais proximas) 
    
    # o[1:k] -> obtem as k pessoas mais próximas
    # L[o[1:k]] -> Obtem as k classes das pessoas mais próximas
    # sort(table(L[o[1:k]]) -> mostra a tabela com as classes que mais apareceram (decresing=T)
    vote = sort(table(L[o[1:k]]), decreasing = TRUE) # Obtem as classes dos k vizinhos mais proximos
    
    # Retorna a classe mais votada para ser a do gamer que estamos tentando adivinhar
    return(as.numeric(names(vote[1]))) 
  }

  KNN.correlation <- function(x, X, L, k=3){ # Se o usuario nao preencher o k, por default é 3
    m=nrow(x)
    n = nrow(X)
    
    if (is.null(m)){ m = 1 }
    
    P = NULL # variavel que guarda as predicoes
    P$class = 0*(1:m) # inicializa o vetor de predições
    for(j in 1:m){
      d = 0*(1:n)
      for(i in 1:n){d[i] = D_correlation(x[j,], X[i,])}
      o = order(d) # Ordena os indices das menores distancias (quem sao as pessoas mais proximas) 
      
      # o[1:k] -> obtem as k pessoas mais próximas
      # L[o[1:k]] -> Obtem as k classes das pessoas mais próximas
      # sort(table(L[o[1:k]]) -> mostra a tabela com as classes que mais apareceram (decresing=T)
      vote = sort(table(L[o[1:k]]), decreasing = TRUE) # Obtem as classes dos k vizinhos mais proximos
      
      # No exemplo anterior a gente convertia as classes como numeric, mas para esses dados as classes sao strings ("M" ou "B")
      #P$class[j] = as.numeric(names(vote[1]))
      
      # Quando dar problema de tipo há duas alternativas:
      # Ou altera o código (se tiver acesso ao código fonte)
      # Ou muda o tipo da variável no banco
      
      # Nesse caso, foi facil e apenas alteramos o tipo
      P$class[j] = names(vote[1])
    } 
    
    # Retorna a classe mais votada para ser a do gamer que estamos tentando adivinhar
    return(P) 
  }

  # ----------------------------------------------------
  # TESTANDO NO BANCO DE JOGADORES
  # ----------------------------------------------------
    # Obtendo os dados
    dados = read.delim("SkillCraft1_Dataset.csv", sep=",")
    head(dados)
    classe = dados[,2] # faixa do do gamer. 1 -> branca e 8-> preta
    IDs = dados[,1]
    n = ncol(dados)
    y = dados[,6:n] # So desejamos a partir da 6 coluna porque 
    y = scale(y) # nao pode esquecer
    N = nrow(y)
    
    # Para nao fazer mais aleatorio, colocamos num for utilizando o metodo leave-one-out (LOO)
    
    # Executando
    # Generalizando a matriz de confusao
    m = length(unique(classe)) 
    confu = matrix(0, m, m) # matriz preenchida com zeros
    
    for(u in 1:N){
      # y[u,] -> Todas colunas do gamer u (gamer que sera previsto sua classe)
      # y[-u,] -> Todos dados dos outros gamers, exceto o gamer u (gamer que sera previsto sua classe)
      predito = KNN.manhattan(y[u,], y[-u,], classe[-u])
      for(i in 1:m){
        for(j in 1:m){
          # Percorre a matriz de confusao campo a campo
          confu[i,j] = confu[i,j] + sum( (predito == i) & classe[u] == j) 
          # (predito == i)
          # Suponha que i é a linha do "eu disse" e as colunas j sao as classes reais
          # Se a classe que foi predita é igual a classe do "eu disse" e a classe real do gamer for igual a classe "real"
          # Então você localiza o campo i,j na matriz e soma um. 
          # Pois quando eu falar que a classe 
        }
      }
    }
    
    sum(diag(confu)) # soma a quantidade de acertos da matriz de confusao
    sum(confu) # Soma a quantidade total da matriz
    p_acerto = sum(diag(confu))/sum(confu); p_acerto
  
  


# ------------------------------------------------------------------
# ----------- KNN PARA O BANCO DE GAMERS (Starcraft) ---------------
# ------------------------------------------------------------------
# fazer o knn em um for que pegue cada gamer por vez, e não que pegue aleatoriamente
  # Fazer a matriz de confusão de vários níveis
  # Fazer com 6 e 3 vizinhos. Dá pra fazer votação entre eles ou daria pra pegar sempre o primeiro

  # Funcao que recebe um e retorna o que foi predito
  # x-> quem vai ser adivinhado (nao tem label, pois a gente vai tentar adivinhar)
  # X-> os dados reais (quem vc conhece)
  # L -> labels/classes conhecidas
  KNN <- function(x, X, L, k=3){ # Se o usuario nao preencher o k, por default é 3
    n = nrow(X)
    d = 0*(1:n) # inicializa o vetor com zero em n posições
    for(i in 1:n){
      d[i] = D(x, X[i,]) # Calcula a distancia entre quem vamos adivinhar contra todos os outros gamers
    } 
    o = order(d) # Ordena os indices das menores distancias (quem sao as pessoas mais proximas) 
    
    # o[1:k] -> obtem as k pessoas mais próximas
    # L[o[1:k]] -> Obtem as k classes das pessoas mais próximas
    # sort(table(L[o[1:k]]) -> mostra a tabela com as classes que mais apareceram (decresing=T)
    vote = sort(table(L[o[1:k]]), decreasing = TRUE) # Obtem as classes dos k vizinhos mais proximos
    
    # Retorna a classe mais votada para ser a do gamer que estamos tentando adivinhar
    return(as.numeric(names(vote[1]))) 

  }

  # Obtendo os dados
  dados = read.delim("SkillCraft1_Dataset.csv", sep=",")
  head(dados)
  classe = dados[,2] # faixa do do gamer. 1 -> branca e 8-> preta
  IDs = dados[,1]
  n = ncol(dados)
  y = dados[,6:n] # So desejamos a partir da 6 coluna porque 
  y = scale(y) # nao pode esquecer
  N = nrow(y)
  
  # Para nao fazer mais aleatorio, colocamos num for utilizando o metodo leave-one-out (LOO)

  # Executando
  # Generalizando a matriz de confusao
  m = length(unique(classe)) 
  confu = matrix(0, m, m) # matriz preenchida com zeros
  
  for(u in 1:N){
    # y[u,] -> Todas colunas do gamer u (gamer que sera previsto sua classe)
    # y[-u,] -> Todos dados dos outros gamers, exceto o gamer u (gamer que sera previsto sua classe)
    predito = KNN(y[u,], y[-u,], classe[-u])
    for(i in 1:m){
      for(j in 1:m){
        # Percorre a matriz de confusao campo a campo
        confu[i,j] = confu[i,j] + sum( (predito == i) & classe[u] == j) 
        # (predito == i)
          # Suponha que i é a linha do "eu disse" e as colunas j sao as classes reais
          # Se a classe que foi predita é igual a classe do "eu disse" e a classe real do gamer for igual a classe "real"
          # Então você localiza o campo i,j na matriz e soma um. 
          # Pois quando eu falar que a classe 
      }
    }
  }
  
  sum(diag(confu)) # soma a quantidade de acertos da matriz de confusao
  sum(confu) # Soma a quantidade total da matriz
  p_acerto = sum(diag(confu))/sum(confu); p_acerto
  
  

  
# Para banco de dados da mama
# B -> Bootstrap
cross.validation <- function(taxa.treino = 0.8, k.value=1, labs, y, B = 100){
  acertoknn = erro1knn = erro2knn = 0*(1:B) # inicializando as variaveis
  acertolda = erro1lda = erro2lda = 0*(1:B) # inicializando as variaveis
  
  # Roda o experimento B vezes
  for(b in 1:B){
    p = taxa.treino # porcentagem dos dados que sera utilizada para treino
    
    # Pegando os dados de treino
    t = sample(1:n, floor(p*n)) 
    yt = y[t,] # amostra de treino
    labt = labs[t] # labels de treino
    
    # Predizendo com knn
    P.knn = KNN(y[-t,], yt, labt, k=k.value)
    
    # Faz o modelo de predicao com lda
    modelo = lda(yt, labt)
    povo_quer_saber = predict(modelo, y[-t,]) # prediz o teste
    
    # Matriz de confusao para o knn
      mconfu = matrix(0, 2, 2) # matriz preenchida com zeros
      # acertos
      mconfu[1,1] = sum((labs[-t] == "B") & (P.knn$class == "B"))
      mconfu[2,2] = sum((labs[-t] == "M") & (P.knn$class == "M"))
      #erros
      mconfu[1,2] = sum((labs[-t] == "B") & (P.knn$class == "M"))
      mconfu[2,1] = sum((labs[-t] == "M") & (P.knn$class == "B"))
    
    # Matriz de confusao para o lda
    m.confusao = matrix(0, 2, 2) # Matriz de confusao
      # Acertos
      m.confusao[1,1] = sum((labs[-t] == "B") & (povo_quer_saber$class == "B"))
      m.confusao[2,2] = sum((labs[-t] == "M") & (povo_quer_saber$class == "M"))
      
      # Erros
      m.confusao[1,2] = sum((labs[-t] == "B") & (povo_quer_saber$class == "M"))
      m.confusao[2,1] = sum((labs[-t] == "M") & (povo_quer_saber$class == "B"))
      
      
      # Pegando os dados de acertos do knn 
      nknn = nrow(y[-t,]) 
      acertoknn[b] = ((mconfu[1,1] + mconfu[2,2])/nknn)
      erro1knn[b] = mconfu[1,2]/nknn
      erro2knn[b] = mconfu[2,1]/nknn
      
      # Pegando os dados de acertos do lda 
      nlda = nrow(y[-t,]) 
      acertolda[b] = ((m.confusao[1,1] + m.confusao[2,2])/nlda)
      erro1lda[b] = m.confusao[1,2]/nlda
      erro2lda[b] = m.confusao[2,1]/nlda
  }
  
  mean.acertoknn = mean(acertoknn)
  mean.acertolda = mean(acertolda)
  
  print("Acerto medio knn ")
  print(mean.acertoknn)
  
  print("Acerto medio knn ")
  print(mean.acertolda)
  
  par(mfrow=c(1,2))
  # plotando grafico 
  plot(1:B, acertolda, col="blue", type="l", lwd=3, ylim=c(0,1), main = "LDA")  
  points(1:B, erro1lda, col="pink", type="l", lwd=3)
  points(1:B, erro2lda, col="red", type="l", lwd=3)
  abline(h=mean.acertolda, lwd=2)
  
  # plotando grafico 
  plot(1:B, acertoknn, col="blue", type="l", lwd=3, ylim=c(0,1), main = "KNN")  
  points(1:B, erro1knn, col="pink", type="l", lwd=3)
  points(1:B, erro2knn, col="red", type="l", lwd=3)
  abline(h=mean.acertoknn, lwd=2)
  
}
  

cross.validation(taxa.treino = 0.5, k.value=3, labs, y, B = 100)
  
