extends Area2D

var pode_clicar = false

func _on_Porta_body_entered(body):
	if body.collision_layer == 1:
		pode_clicar = true
	else:
		abrir()


func _on_Porta_body_exited(body):
	if body.collision_layer == 1:
		pode_clicar = false


func _on_Porta_input_event(viewport, event, shape_idx):
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and pode_clicar:
		abrir()

func abrir():
	$AnimationPlayer.play("AbrirPorta")
