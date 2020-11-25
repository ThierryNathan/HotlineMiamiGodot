extends "res://Assets/Scripts/Porta.gd"

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


func _on_PortaTrancada_body_entered(body):
	if body.collision_layer == 1:
		pode_clicar = false
