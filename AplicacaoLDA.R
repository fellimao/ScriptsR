#----Predição com LDA----#
#teste com dados limpos
dadosP = read.csv("C:\\Users\\beatr\\Documents\\6º Semestre\\Rec de Padrões\\Trabalho\\dados_preprocessado.csv", sep = ",", header = T)

#instalando biblioteca com o lda
install.packages("MASS")
library(MASS)

#Setamos um seed para gerar números aleatórios
set.seed(1234)

#Guardamos os labels da varivável compli dos nossos dados
dadosP.Label <- dadosP[, 11]

#Setamos 2/3 do nosso bando para ser treino (p = 67% do banco)
p = 0.67
n <- nrow(dadosP[3:12])

#Selecionar aleatoriamente os dados que serão utilizados para treino
set.seed(1234)
t <- sample(1:n, floor(p*n))
t

#Dados do treino guardados na variável treino
treino <- dadosP[t,]
treino

#Guarda as labels compli dos nossos dados de treino
labelTreino <- dadosP.Label[t]
labelTreino

#-Utilizando o método-#
dados_para_lda<-dadosP[3:13]
dadosP_pred_lda<-lda(compli ~., dados_para_lda, subset = t)
is(treino)

#--PREDIÇÃO com dados treino--#

ztreino<-predict(dadosP_pred_lda,dados_para_lda[t,])
ztreino$class

#Validação dos dados de test#
zteste<-predict(dadosP_pred_lda,dados_para_lda[-t,])
zteste$class

# Cria uma tabela comparando os valores que era esperado com os preditos pelo lda
A = data.frame(dadosP[t, "compli"], ztreino$class)
A[,1]==A[,2]
head(A)
soma_treino=sum(A[,1]!=A[,2])
p.erro.treino=soma_treino/nrow(dadosP[t,])
p.erro.treino

# Realizando a predição do banco de teste
B = data.frame(dadosP[-t, "compli"], zteste$class)
soma_teste=sum(B[,1]!=B[,2])
erros.teste=soma_teste/nrow(dadosP[-t,])
erros.teste
