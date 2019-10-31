    			            #----Testes de hipótese----#

#---Comparação de variâncias de uma distribuição normal---#

#--Vetores contendo o valor das variáveis--#
A<-c(145, 127, 136, 142, 141, 137) 	
B<-c(143, 128, 132, 138, 142, 132)

#Primeira forma#

#-calculando a variância de cada máquina-#
varA<- var(A)
varB<- var(B)

#Definindo as hipóteses

#H0: varA=varB
#Ha: varA!=varB


             #-Vamos calcular a estatística de teste-# 
#-Como temos o computador a disposição não precisamos da tabela da distribuição F e podemos calcular o P-valor diretamente-#
nA<- length(A)
nB<-length(B)

f<- varA/varB

p_value <-2*pf(f,nA-1,nB-1, lower = F)

#Segunda Forma#
