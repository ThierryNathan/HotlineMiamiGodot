extends "res://Assets/Scripts/PersonagemBase.gd"

onready var navegacao = get_tree().get_root().find_node("Navigation2D", true, false)
onready var destinos = navegacao.get_node("Destinos")

var movimentacao = Vector2()
var destinos_possiveis = []
var caminho = []

export var distancia_minima = 5
export var velocidade_movimento = 0.5

func _ready():
	randomize()
	destinos_possiveis = destinos.get_children()
	criar_caminho()

func criar_caminho():
	var novo_destino = destinos_possiveis[randi() % destinos_possiveis.size() - 1]
	caminho = navegacao.get_simple_path(position, novo_destino.position, false)

func _physics_process(delta):
	navegar()

func navegar():
	var distancia_ate_destino = position.distance_to(caminho[0])
	
	if distancia_ate_destino > distancia_minima:
		mover()
	else:
		atualizar_caminho()

func mover():
	look_at(caminho[0])
	movimentacao = (caminho[0] - position).normalized() * (VELOCIDADE_MAXIMA * velocidade_movimento)
	
	if is_on_wall():
			criar_caminho() 
	
	move_and_slide(movimentacao)

func atualizar_caminho():
	if caminho.size() == 1:
		if $Timer.is_stopped():
			$Timer.start()
	else:
		caminho.remove(0)

func _on_Timer_timeout():
	criar_caminho()
