
Linguagem R:

	#- Instalação: Pesquisar "R download for Windows"/ Entra no primeiro link para baixar/Após baixar iniciar instalação/ Dê next...next e finish/ Pronto!
	#- Configuração inicial:
		Para abrir seu R através do cmd (no caso do windows) você tem que ir em: computador/ Propriedades do Sistema/ Configurações avançadas do sistema/ Variáveis de Ambiente/ Na caixa de Variáveis do Sistema procure a linha com nome de "Path" clique duas vezes nela para abrir/ Adicione ";C:\Program Files\R\R-3.5.0\bin" (não esquecer de colocar ; antes do caminho do R que é executável) /Clique em ok e pronto! Agora você só precisa abrir o cmd e digitar "R".
	
# GERAL
	# -> Para sair do R pelo cmd:
		quit("no") (Sai sem salvar)
		q() (Também sai do R)

	# -> Informações sobre funções.
		help(nome_funcao) # Retorna informações sobre a funcao passada como parâmetro
		example(nome_funcao) # Retorna exemplos de como se usa a funcao passada como parâmetro
	
# -> VARIÁVEIS
	# Visualiza todos objetos que estão sendo usados durante a sessão.
		objects() ou ls()
	
	# Excluindo DETERMINADAS variáveis que estão no workspace (objetos que estão na sessão)
		rm(nome_var1, nome_var2)
	
    # Excluindo TODAS as variáveis do workspace.
		rm(list = ls()) OU rm(list = objects()) # Apaga todas as variáveis.
	

# -> OPERAÇÕES BÁSICAS		
	
	print(x) # Mostra o conteúdo de x (que pode ser uma variável, um vetor, etc)
	0:10 # Gera um intervalo de 0 a 10. Saida: 0 1 2 3 4 5 6 7 8 9 10
	sum(0:10) # Soma os números do intervalo de 0 a 10.
	abs(num) # Deixa o num em módulo (positivo).
	
	# Atribuição de valores.
		num <- 4 # Atribui valor a variável
		num <- 4 * 2 # Atribui o resultado da operação, poderia ser +, -, /, *, etc
	
	# Raíz quadrada
		sqrt(num) # Calcula a raíz quadrada da variável num.
		sqrt(-17+0i) # Calcula a raíz quadrada de um número complexo.

	# Formatando casas decimais.
		options(digits = 3) # Após esse comando, os números serão exibidos com duas casas decimais. APENAS MOSTRA.
		num_arredondado <- round(num, 2) # Arredonda o num para apenas 2 casas decimais e armazena o valor arredondado em num_arredondado.
			# num poderia ser um vetor. Se for, todos elementos do vetor ficam com 2 casas decimais.
	
# -> VETORES
	# Atribuindo valores para o vetor
		lista <- c(1,2,3,4,5,6,7,8) # Cria um vetor chamado lista e que tem os elementos 1, 2, 3, 4, 5, 6, 7, 8
		assign ("lista", c(1,2,3,4,5,6,7,8)) # outro jeito de fazer atribuição.
		lista <- 2:5 # Cria um vetor sequencial de 2 até 5. Esse comando é equivalente a seq(2,5)
	
	# Operações
		nome_vetor + 2 # Todos os elementos do nome_vetor soferá a soma (poderia ser -, * e /). A operação não altera o vetor, ela gera um vetor resultante que pode ser salvo em alguma variável.
		nome_vetor1 + nome_vetor2 # Todos elementos do nome_vetor1 e nome_vetor2 serão somados (também poderia ser -, * e /). A operação é realizada de elemento a elemento.
		sqrt(nome_vetor) # Calcula a raiz quadrada de cada elemento do vetor. (Gera um novo vetor)
		sin(nome_vetor) # Calcula o seno de cada elemento do vetor. (Gera um novo vetor)
		abs(nome_vetor) # Deixa todos os elementos positivos ou em módulo.
		
		
	# Nomeando elementos de um vetor
		names(nome_dataframe) # Imprime os nomes das colunas do dataframe.
		names(nome_vetor) <- vetor_classificador("elem 1", "elem 2", "elem 3") # Os vetores não precisam ter tamanhos iguais, mas o 1° elemento do nome_vetor será correspondente ao 1° elemento do vetor_classificador e assim por diante. O nome do elemento nome_vetor[1] será chamado de "elem 1", o do nome_vetor[2] será "elem 2", e assim por diante.
		nome_vetor # Após utilizar a função names no nome_vetor, ao imprimi-lo na tela, o nome correspondente a cada elemento aparecerá acima de seu respectivo elemento.
		nome_vetor["elem 2"] # Após usar a função names no nome_vetor, é possível visualizar o que tem na posição do vetor através de seu nome.
		nome_vetor["elem 2"] <- 22 # Após usar a função names no nome_vetor, é possível alterar o que tem na posição do vetor através de seu nome.
		
	# Atribuindo valores repetidos a um vetor através de outro.
		vet <- rep(nome_vetor, each = 2) # Se nome_vetor = (1,2,3), vet = (1,1,2,2,3,3), mas se nome_vetor for uma variável x=2 teremos vet = (2,2)
		vet <- rep(nome_vetor, times = 2) # Se nome_vetor = (1,2,3), vet = (1,2,3,1,2,3), mas se nome_vetor for uma variável x=2 teremos vet = (2,2)

	# Acessando valores do vetor
		lista # Se escrever apenas o nome da variável que você atribuiu algum valor o programa exibe ela inteira, mesmo sendo um vetor
		lista[2] # Acessa/consulta e mostra o 2° elemento do vetor. O indice do vetor em R começa em 1 e não em 0, como é em algumas linguagens
		lista[c(1,3)] # Obtém os valores das posições 1 e 3 do vetor lista
		lista[2:5] # Obtém os valores das posições 2, 3, 4 e 5 do vetor lista
	
	# Agrupando elementos do vetor
		tipos <- factor(nome_vetor) # Será salvo na variável tipos elementos que aparecem uma vez ou mais no nome_vetor, assim há o agrupamento dos dados. Ex: nome_vetor=["a", "b", "c", "a", "a", "b"]. O vetor tipos ficará ["a", "b", "c"]
		as.integer(tipos) # Esse comando mostra o nível de agrupamento em números. Para cada indice que corresponde ao elemento do vetor original é atribuido um número. Esse número é referente ao nível de aparições daquele elemento no vetor inteiro. Ex: Se "a" aparece mais vezes ele terá o menor número inteiro(1), pois será o 1° em frequência de aparições. Ao executar esse comando com nome_vetor=["a", "b", "c", "a", "a", "b"], teremos [1,2,3,1,1,2].
		levels(tipos) # Mostra os agrupamentos do vetor. Usando o nome_vetor acima teriamos como resultado ["a", "b", "c"]
		
	# Funções que podem ser realizadas com vetores
		# Obtendo média simples dos elementos do vetor.
			mean(nome_vetor)
		
		# Obtendo a mediana do vetor.
			median(nome_vetor)
		
		# Obtem o desvio padrão do vetor.
			sd(nome_vetor) # sd é equivalente a standard deviation.
		
		# Somando valores dos elementos do vetor.
			sum(nome_vetor) # Desde que não tenha nenhum elementou faltando (NA), faz a soma de todos os elementos do vetor.
			sum(nome_vetor, na.rm = TRUE) # Caso tenha algum elemento NA, e mesmo assim queira que a soma seja realizada. Essa propriedade da função remove os NA e faz a soma dos elementos do vetor.
			
		# Obtendo o tamanho do vetor.
			length(nome_vetor)
			
		# Organizando o vetor em ordem crescente.
			sort(nome_vetor)
			
		# Obtendo o valor máximo ou mínimo do vetor.
			max(nome_vetor1, nome_vetor2) # Pode-se obter o valor máximo de mais que um vetor.
			min(nome_vetor)
			
		# Obtendo valores máximos ou mínimos de cada posição dos vetores.
			pmax(nome_vetor1, nome_vetor2) # Pode-se obter os valores máximos entre vetores diferentes. Há a comparação dos elementos das mesmas posições.
			pmin(nome_vetor1, nome_vetor2, nome_vetor3)
			
		# Comando de repetição para a criação/geração de vetor. GERAÇÃO DE VETORES PADRONIZADOS.
			seq(0,5, by=.2) # Faz um for de 0(from) a 100(to) pulando(by) de 3 em 3.
			seq(10) # Gera um vetor de 1 a 10. 
			seq(10, 5, -0.5) # Gera um vetor que vai de 10(from) até 5(to) a cada -0.5(by).
			seq(10,5) # Gera vetor de (10,9,8,7,6,5). Esse comando é equivalente a 10:5
			
			
	# Operadores lógicos aplicados a vetores.
		vet_resultado <- nome_vetor < 1 # Compara todas as posições do vetor nome_vetor com "<1" e a posição que for menor que 1 recebe TRUE e a que for >= recebe FALSE. Exemplo: Se nome_vetor = (0,1,2), vet_resultado=(TRUE, FALSE, FALSE)
		vet_resultado <- nome_vetor <= 1
		vet_resultado <- nome_vetor == 1
		vet_resultado <- nome_vetor1 == nome_vetor2 # Compara elemento a elemento de cada vetor e gera um vetor com qual elemento é igual(TRUE) e qual não é igual(FALSE). 
		vet_resultado <- nome_vetor >= 1
		vet_resultado <- nome_vetor1 > nome_vetor2 # É possível comparar dois vetores diretamente, desde que eles tenham o mesmo tamanho ou sejam divisíveis.
		vet_resultado <- nome_vetor > 1 & nome_vetor <=20 # Operador AND
		vet_resultado <- nome_vetor > 1 | nome_vetor <=20 # Operador OR
		vet_resultado <- !nome_vetor > 1 # Operador NOT, inverte o resultados onde elemento >1 ou <1.
	
	# Strings
		# Concatenando.
			string <- paste(c("X","Y"), 1:10, sep="")
			string <- paste("X", "2", sep="")

# -> MATRIZES
	# Criando matrizes
		matrix(0, 3, 4) # Criando uma matriz nula(0) de 3 linhas e 4 colunas.
		matrix(nome_vetor, 2, 4) # Criando uma matriz que será preenchida com os elementos do vetor. Dimensão: 2 linhas e 4 colunas.
		dim(nome_vetor) <- c(2, 4) # Transformando o nome_vetor em uma matriz de 2 linhas e 4 colunas. OBS: O nome_vetor precisa ter a mesma quantidade de elementos que uma matriz 2x4 teria.
	
	# Acessando valores da matriz.
		nome_matriz[2,4] # Acessa a posição 2,4 da matriz. (linha 2 e coluna 4)
		nome_matriz[2,4] <- 3 # Altera/atribui o valor que está na posição 2,4 da matriz. (linha 2 e coluna 4)
		nome_matriz[2,] # Acessa todos os valores que estão na linha 2 da matriz. (linha 2)
		nome_matriz[,4]  # Acessa todos os valores que estão na coluna 4 da matriz. (coluna 4)
		nome_matriz[,1:3] # Acessa os valores que estão entre as colunas 1 e 3 da matriz.
		nome_matriz[1:3,] # Acessa os valores que estão entre as linhas 1 e 3 da matriz.
		
	# Nomeando as linhas e as colunas da matriz.
		rownames(nome_matriz) <- c("R1","R2","R3")
		colnames(nome_matriz) <- c("C1","C2","C3","C4")

	# Aplicando funções em matrizes.
		apply(X=nome_matriz,MARGIN=1,FUN=sum) # Soma os valores de cada linha. MARGIN=1: Pega as linhas. MARGIN=2: Pega as colunas. FUN=sum: Aplica a funcao soma nas linhas(1) ou nas colunas(2).
		apply(X=nome_matriz,MARGIN=2,FUN=max) # Valor máximo de cada coluna. MARGIN=1: Pega as linhas. MARGIN=2: Pega as colunas. FUN=max: Aplica a funcao maximo nas linhas(1) ou nas colunas(2).
	
	# Operacoes com matrizes.
		nome_matriz1 * nome_matriz2 # Multiplicacao usual
		nome_matriz1 %*% nome_matriz2 # Multiplicacao matricial
		diag(nome_matriz) # Obtem a diagonal da matriz
	
# -> DATA FRAMES (São dados distribuídos de maneira semelhante a uma planilha do Excel)
	# Criando um data frame
	dataFrame <- data.frame(nome_vetor1, nome_vetor2, nome_vetor3) # Criando um data frame através de 3 vetores que possuem a mesma quantidade de elementos. O nome de cada vetor será referente a uma coluna.
	
	# Acessando um data frame
	dataFrame # Mostra uma tabela com todos os dados do data frame.
	dataFrame[[2]] ou dataFrame["nome_vetor2"] ou dataFrame$nome_vetor2 # Mostra os dados referentes à 2° coluna do data frame.
	dataFrame[, "nome_vetor2"] # Mostra os dados referentes a 2° coluna do data frame em forma de vetor.
	
	# Junção de dois data frames
	dataFrame1 <- read.csv("nome_do_arq1.csv")
	dataFrame2 <- read.table("nome_do_arq2.txt", sep="\t" header=TRUE)
	dataFrame3 <- merge(x=dataFrame1, y=dataFrame2) # Faz a junção dos dois frames, eles precisam ter estruturas semelhantes em relação a n° de colunas e linhas(Conferir).
	
	
# -> GRÁFICOS
	# -> Salvando uma imagem de um gráfico que será gerado.
		png(file="caminho_onde_vai_salvar/nome_do_arq_a_ser_criado.png", width=700, height=700) # Prepara as configurações iniciais para ser possível salvar.
		boxplot(lista) # Gera o gráfico
		dev.off() # Pega o gráfico gerado e salva através das configurações iniciais.
		
	# -> Criando um gráfico de barras
		barplot(nome_vetor) # Gera um gráfico de barras. OBS: Ao usar o comando names() no nome_vetor e criar um gráf. de barras, o gráf. fica com as colunas nomeadas.
		
		barplot(nome_vetor) # Criando gráfico de barras antes de executar o comando abline.
		abline(h = mean(nome_vetor)) # Adicionando no gráf. de barras uma linha horizontal(h) ou vertical(v) com o valor da média simples dos elementos do nome_vetor.
		abline(v = median(nome_vetor)) # Adicionando no gráf. de barras uma linha horizontal(h) ou vertical(v) com o valor da mediana do nome_vetor.
		
	# -> Criando um Scatter plot (grafico de pontos)
		plot(nome_vetor1, nome_vetor2) # nome_vetor1 refere-se aos valores do eixo x e nome_vetor2 refere-se aos valores do eixo y.
		
		plot(nome_vetor1, nome_vetor2, pch=as.integer(tipos)) # Através desse comando é possível plotar um gráfico que em cada ponto, dependendo do tipo de dados, assume um ponto diferente. (bolinha, +, triangulo).
		legend("topright", levels(tipos), pch=as.integer(tipos)) # Adiciona legenda na posição "topright" do gráfico, com as legendas "a", "b", "c"(que está no vetor tipos) respectivo para cada tipo de ponto do gráfico(pch).
	# -> Gráfico de perspectiva(3D)
		persp(nome_matriz) # Cria um gráfico com relevo dependendo dos valores da matriz.
		persp(nome_matriz, expand=0.2) # Cria um gráfico com relevo dependendo dos valores da matriz. E altera o tamanho do eixo z(altura do gráfico).
	
	# -> Gráfico heat map
		image(nome_matriz)
	
	# -> Gera um histograma (parecido com gráfico de barras) a partir dos valores que tem no vetor chamado lista
		hist(lista) 

		?nome_do_comando # Gera informações sobre o comando, como se fosse um help. Por exemplo: "?hist", aparecerá informações sobre o comando hist

	# -> Criando um gráfico de pizza
		slices <- c(10, 12,4, 16, 8) # Valores que terá cada "fatia"
		lbls <- c("Session 1", "Session 2", "Session 3", "Session 4", "Session 5") # O nome que cada "fatia" irá possuir. OBS: Precisa estar na mesma sequencia que os valores de cada fatia, e precisa ter a mesma quantidade de elementos os dois vetores, tanto o com os nomes tanto o com os valores
		pie(slices, labels = lbls, main="Titulo do grafico") # Gera o gráfico passando os valores, os nomes de cada valor e o título do gráfico.

		
# -> ARQUIVOS
	# -> Abrir/importar arquivos no R
		# .CVS(Comma Separated Values ou Valores Separados por vírgula) 
		read.csv(file="caminho_onde_esta_o_arq/nome_do_arq.csv") 
		read.csv("nome_do_arq.csv")
		
		# TXT
		read.table("nome_do_arq.txt", sep="\t, header=TRUE") # Abre uma tabela que contém dados que estão armazenados no arquivo nome_do_arq. Esses dados são separados por tab (\t, ou seja os dados são separados através de tab para serem mostrados na tabela - poderia ser outro caracter que não seja tab) e a 1° linha dos dados são o cabeçalho (TRUE, por padrão é FALSE então tem que mudar se quiser que a primeira linha seja o cabeçalho). 
		
	# -> Exportar dados do R em arquivos externos
		# .CVS(Comma Separated Values ou Valores Separados por vírgula) 
		write.csv(nome_tabela, "nome_arq.csv")
		
		# .xlsx (planilha Excel)
		write.xlsx(tabela, caminho, sheetName=nomeDaAba, append = TRUE)  
			# tabela: para ficar formatada bonitinha e tal, tem que ser uma tabela no formato de string pois o excel reconhece o formato.
			# caminho: Local onde sera salvo a planilha. Incluindo o nome do arquivo na string de extensão do arquivo.
			# sheetName: Nome da aba que a sua tabela será inserida.
			# append: Se =TRUE, ao inserir outra tabela na mesma planilha, a tabela que foi inserida anteriormente não é apagada e cria-se uma nova aba para inserção da nova tabela. Se for =FALSE, ao inserir outra tabela, a que foi inserida anteriormente é substituída pela nova.
	
	# -> Executando código que está em arquivo .R
		list.files() # Mostra os arquivos que estão no mesmo diretório que você está
		source("nome_do_arq.R") # Executa o código em R que está no arquivo .R, neste arquivo normalmente se armazena algum código em R, como uma funcao por exemplo
		
		
# -> BIBLIOTECAS
	
	install.packages("nome_biblioteca") # Instalando uma biblioteca
	install.packages("xlsx") # Importa o pacote para mexer com arquivos excel
	library(xlsx) # Carregando o pacote (sempre carregar ao usar funções do pacote)

	help(package="nome_biblioteca") # Mostra informações gerais sobre a biblioteca
	
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		