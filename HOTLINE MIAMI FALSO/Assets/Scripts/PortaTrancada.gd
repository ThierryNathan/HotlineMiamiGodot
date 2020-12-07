extends "res://Assets/Scripts/Porta.gd"

func _ready():
	#gerar_combinacao()
	$Label.rect_rotation = -rotation_degrees

#func gerar_combinacao():
	#var tamanho = 4
	#var combinacao = GeradorDeCombinacoes.gerar_combinacao(tamanho)
	#$CanvasLayer/PainelNumerico.combinacao = combinacao
	

func _on_PortaTrancada_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and pode_clicar:
		$CanvasLayer/PainelNumerico.popup_centered()

func _on_PortaTrancada_body_exited(body):
	if body.collision_layer == 1:
		pode_clicar = false
		$CanvasLayer/PainelNumerico.hide()

func _on_PainelNumerico_combinacao_correta():
	abrir()
	$CanvasLayer/PainelNumerico.hide()


func _on_Computador_combinacao(numeros, grupo_de_travas):
	$CanvasLayer/PainelNumerico.combinacao = numeros
	$Label.text = grupo_de_travas
