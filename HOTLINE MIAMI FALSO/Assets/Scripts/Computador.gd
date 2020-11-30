extends Node2D

var pode_clicar = false
var combinacao

export var tamanho_da_combinacao = 4

signal combinacao

export var grupo_de_travas = "Não definido"

func _on_Area2D_body_entered(body):
	pode_clicar = true


func _on_Area2D_body_exited(body):
	pode_clicar = false
	$CanvasLayer/ComputadorTela.hide()


func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and pode_clicar:
		$CanvasLayer/ComputadorTela.popup_centered()		


func _ready():
	gerar_combinacao()
	emit_signal("combinacao", combinacao, grupo_de_travas)


func gerar_combinacao():
	combinacao = GeradorDeCombinacoes.gerar_combinacao(tamanho_da_combinacao)
	definir_texto_do_popup()
	
	
func definir_texto_do_popup():
	#$CanvasLayer/ComputadorTela.set_text(combinacao)
	pass
