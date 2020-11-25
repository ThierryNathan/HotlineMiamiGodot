extends Popup

var combinacao = [4, 0, 0, 2]
var tentativa = []

onready var display = $VBoxContainer/DisplayContainer/Display
onready var luz = $VBoxContainer/TecladoContainer/GridContainer/Luz

signal combinacao_correta

func _ready():
	conectar_botoes()

func conectar_botoes():
	for filho in $VBoxContainer/TecladoContainer/GridContainer.get_children():
		if filho is Button:
			filho.connect("pressed", self, "botao_pressionado", [filho.text])

func botao_pressionado(botao):
	if botao == "OK":
		checar_tentativa()
	else:
		inserir(int(botao))

func checar_tentativa():
	if tentativa == combinacao:
		luz.texture = load("res://Assets/GFX/Interface/PNG/dotGreen.png")
		$Timer.start()
	else:
		reiniciar_trava()

func inserir(botao):
	tentativa.append(botao)
	atualizar_display()

func atualizar_display():
	display.text = PoolStringArray(tentativa).join("")
	if tentativa.size() == combinacao.size():
		checar_tentativa()

func reiniciar_trava():
	luz.texture = load("res://Assets/GFX/Interface/PNG/dotRed.png") 
	display.text = ""
	tentativa.clear()

func _on_Timer_timeout():
	emit_signal("combinacao_correta")
	reiniciar_trava()
