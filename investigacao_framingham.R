##---Investigação bioestatística básica sobre dados da base framingham usando R---##


#--Baixando os dados--#
dados=read.csv("caminho\\framingham.csv")

head(dados)

#--Investigar se o fumante tem mais doenças cardiovasculares--#
A<-table(dados$currentSmoker,dados$TenYearCHD)#criando tabela para comparar fumantes com CHD

percentA<-prop.table(A)#tabela com porcentagens referentes a tabela A

#--Gráfico em barra--#
barplot(percentA,main = "% de CHD em Fumantes",xlab = "Fumantes X NFumantes")
barplot(percentA)


#----Investigar os batimentos cardíacos e a pressão do grupo de fumantes e não fumantes----#

#--Separando fumantes e não fumantes--#
#a função subset 
dadoF<-subset(dados,dados$currentSmoker==1)
dadoNF<-subset(dados,currentSmoker==0)

head(dados)

#--histograma comparando pacientes fumantes com não fumantes pela pressão--#
par(mfrow=c(1,2))
hist(dadoF$sysBP,xlab="Pressão Sistólica",ylab="Fumantes",main="",col=8)
hist(dadoNF$sysBP,xlab="Pressão Sistólica",ylab="Não Fumantes",main="",col=8)

#--Médias de pressão de pacientes Fumantes e não fumantes--#
mean(dadoF$sysBP)#Média de pressão em fumantes
  129.4504
mean(dadoNF$sysBP)#Média de pressão em não fumantes
  135.1911
