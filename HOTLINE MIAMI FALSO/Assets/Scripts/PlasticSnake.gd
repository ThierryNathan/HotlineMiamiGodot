extends "res://Assets/Scripts/PersonagemBase.gd"

var movimento = Vector2()
var disfarcado = false
const SPRITE_JOGADOR = "res://Assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const OCCLUDER_JOGADOR = "res://Assets/Personagens/LightOccluder2D.tres"
const SPRITE_CAIXA = "res://Assets/GFX/PNG/Tiles/tile_130.png"
const OCCLUDER_CAIXA = "res://Assets/Personagens/BoxOccluder.tres"
const LUZ_JOGADOR = "res://Assets/GFX/PNG/Hitman 1/hitman1_stand.png"
const LUZ_CAIXA = "res://Assets/GFX/PNG/Tiles/tile_130.png"
export var lentidao_disfarce = 0.25
var multiplicador_de_velocidade = 1
var duracao_do_disfarce = 5
export var quantidade_disfarces = 3

# Update da unity:
func _physics_process(delta):
	atualiza_movimento()
	move_and_slide(movimento)
	if disfarcado:
		$Label.text = str($Timer.time_left).pad_decimals(2)
		$Label.rect_rotation = -rotation_degrees


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

func _input(event):
	if Input.is_action_just_pressed("visão_noturna"):
		get_tree().call_group("Interface", "alternar_modo")
	if Input.is_action_just_pressed("ativar_disfarce"):
		ativar_disfarce()


func ativar_disfarce():
	if disfarcado:
		revela()
	elif quantidade_disfarces > 0:
		disfarce()


func revela():
	$Sprite.texture = load(SPRITE_JOGADOR)
	$LightOccluder2D.occluder = load(OCCLUDER_JOGADOR)
	$Light2D.texture = load(LUZ_JOGADOR)
	$Label.hide()
	
	multiplicador_de_velocidade = 1
	disfarcado = false
	collision_layer = 16


func disfarce():
	$Sprite.texture = load(SPRITE_CAIXA)
	$LightOccluder2D.occluder = load(OCCLUDER_CAIXA)
	$Light2D.texture = load(LUZ_CAIXA)
	
	multiplicador_de_velocidade = lentidao_disfarce
	quantidade_disfarces -= 1 
	collision_layer = 16
	disfarcado = true
	$Timer.start()
	
	
func _ready():
	$Timer.wait_time = duracao_do_disfarce
	revela()
