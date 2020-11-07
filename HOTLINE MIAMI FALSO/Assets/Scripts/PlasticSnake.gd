extends "res://Assets/Scripts/PersonagemBase.gd"

var movimento = Vector2()

# Update da unity:
func _physics_process(delta):
	atualiza_movimento()
	move_and_slide(movimento)

func atualiza_movimento():
	look_at(get_global_mouse_position())
	
	if Input.is_action_pressed("mover_baixo") and not Input.is_action_pressed("mover_cima"):
		movimento.y = clamp (movimento.y + VELOCIDADE, 0, VELOCIDADE_MAXIMA)
	elif Input.is_action_pressed("mover_cima") and not Input.is_action_pressed("mover_baixo"):
		movimento.y = clamp (movimento.y - VELOCIDADE, -VELOCIDADE_MAXIMA, 0)
	else:
		movimento.y = lerp (movimento.y, 0, FRICCAO)
		
	if Input.is_action_pressed("mover_esquerda") and not Input.is_action_pressed("mover_direita"):
		movimento.x = clamp (movimento.x - VELOCIDADE, -VELOCIDADE_MAXIMA, 0)
	elif Input.is_action_pressed("mover_direita") and not Input.is_action_pressed("mover_esquerda"):
		movimento.x = clamp (movimento.x + VELOCIDADE, 0, VELOCIDADE_MAXIMA)
	else:
		movimento.x = lerp (movimento.x, 0, FRICCAO)

