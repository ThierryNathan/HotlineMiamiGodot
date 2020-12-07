extends Popup

func definirTexto(combinacao):
	$NinePatchRect/CenterContainer/NinePatchRect/Label.text = ("ROGERIO?"+ 
	PoolStringArray(combinacao).join("") +"Rodrigo?!!")
