extends TextureProgress

export var multiplicador_suspeito = 2


func _ready():
	value = 0


func _process(delta):
	value -= step


func jogador_visto():
	value += step * multiplicador_suspeito

	if value == max_value:
		fim_de_jogo()


func fim_de_jogo():
	get_tree().quit()
