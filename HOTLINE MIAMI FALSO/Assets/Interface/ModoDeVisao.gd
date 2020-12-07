extends CanvasModulate

const ESCURO = Color("322e2e")
const VISAONOTURNA = Color("335a3a")
var intervalo = false

func _ready():
	color = ESCURO
	
func alternar_modo():
	if not intervalo:
		if color == VISAONOTURNA:
			modo_escuro()
		else:
			modo_visao_noturna()
		intervalo = true
		$Timer.start()

func modo_escuro():
	color = ESCURO
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision_off.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("Lanterna", "show")
	get_tree().call_group("Rotulos", "hide")

func modo_visao_noturna():
	color = VISAONOTURNA
	$AudioStreamPlayer2D.stream = load("res://Assets/SFX/nightvision.wav")
	$AudioStreamPlayer2D.play()
	get_tree().call_group("Lanterna", "hide")
	get_tree().call_group("Rotulos", "show")

func _on_Timer_timeout():
	intervalo = false
