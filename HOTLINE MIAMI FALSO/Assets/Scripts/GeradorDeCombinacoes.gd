extends Node

func gerar_combinacao(tamanho):
	var combinacao = []
	for numero in range(tamanho):
		#Gerar números entre 0 e 10.
		combinacao.append(randi() % 10)
	return combinacao
