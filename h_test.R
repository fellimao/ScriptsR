    			            #----Testes de hip�tese----#

#---Compara��o de vari�ncias de uma distribui��o normal---#

#--Vetores contendo o valor das vari�veis--#
A<-c(145, 127, 136, 142, 141, 137) 	
B<-c(143, 128, 132, 138, 142, 132)

#Primeira forma#

#-calculando a vari�ncia de cada m�quina-#
varA<- var(A)
varB<- var(B)

#Definindo as hip�teses

#H0: varA=varB
#Ha: varA!=varB


             #-Vamos calcular a estat�stica de teste-# 
#-Como temos o computador a disposi��o n�o precisamos da tabela da distribui��o F e podemos calcular o P-valor diretamente-#
nA<- length(A)
nB<-length(B)

f<- varA/varB

p_value <-2*pf(f,nA-1,nB-1, lower = F)

#Segunda Forma#
