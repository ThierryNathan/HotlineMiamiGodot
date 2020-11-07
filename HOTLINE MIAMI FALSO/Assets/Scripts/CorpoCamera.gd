extends "res://Assets/Scripts/PersonagemBase.gd"

const TOLERANCIA_FOV = 20
const VERMELHO = Color(1, 0.25, 0.25)
const BRANCO = Color(1, 1, 1)
# Alcance da câmera.
const ALCANCE_MAXIMO_DE_DETECCAO = 640
var jogador

func _ready():
	jogador = get_node("/root").find_node("PlasticSnake", true, false)

func _process(delta):
	if JogadorNoCampoDeVisao() and JogadorNaLinhaDeVisao():
		$Lanterna.color = VERMELHO
	else:
		$Lanterna.color = BRANCO

func JogadorNoCampoDeVisao():
	var DirecaoDoNPC = Vector2(1, 0).rotated(global_rotation)
	var DirecaoAteJogador = (jogador.position - global_position).normalized()
	
	if abs(DirecaoAteJogador.angle_to(DirecaoDoNPC)) < deg2rad(TOLERANCIA_FOV):
		return true
	else:
		return false
	
func JogadorNaLinhaDeVisao():
	var areaDoJogo = get_world_2d().direct_space_state
	var obstaculoNaLinhaDeVisao = areaDoJogo.intersect_ray(global_position, jogador.global_position, [self], collision_mask)
	
	if not obstaculoNaLinhaDeVisao:
		return false
	
	var distanciaAteJogador = jogador.global_position.distance_to(global_position)
	var jogadorNoAlcance = distanciaAteJogador < ALCANCE_MAXIMO_DE_DETECCAO
	
	if obstaculoNaLinhaDeVisao.collider == jogador and jogadorNoAlcance:
		return true 
	else:
		return false 
	
	
