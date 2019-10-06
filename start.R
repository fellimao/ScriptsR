		#---Funções básicas para utilizar em cálculos estatísticos---#

	#--SELECT--#
#A função select tem objetivo de selecionar colunas de uma tabela

install.packages("nycflights13")
library(nycflights13)
library(dplyr)

#--Base de dados para testar--#
flights

select(flights,dep_delay,dep_time)

#--Para ocutar coluna--#
#select(banco,-day,-nome_coluna)

select(flights,-day,-month)
#--Para selecionar de uma coluna a outra--#
#select(banco,coluna_inicio:coluna_fim)
select(flights,day:sched_dep_time)
#também é possível usar essa função com o número de cada coluna
select(flights,2:4)

#---HELP FUNCTIONS SELECT---#

#Para selecionar todoas as colunas que iniciam com certa palavra
#select(banco,starts_with("frase/palavra"))
select(flights,starts_with("d"))

#Para selecionar colunas terminadas em uma letra ou palavra específica
#select(banco,ends_with("letra/palavra"))
select(flights,ends_with("e"))

#Para selecionar colunas que contem certa palavra 
#select(banco,contains("palavra"))

#Seleciona toda a tabela mas com as colunas de sua escolha no inicio
#select(base,coluna1,coluna2,...,colunaN,everything())
select(flights,time_hour,air_time,everything())

#Para renomear certa coluna
#novo_nome_banco<-select(base_antiga,x1=coluna1,...,xN=colunaN,everything())
voos<-select(flights,ano=year,everything())
voos


		#--DISTINCT--#
#Função que retorna dados unicos de uma determinada coluna ou mais
#distinct(base,coluna1,coluna2,...,colunaN)
distinct(voos,ano,day)
