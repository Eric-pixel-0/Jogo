extends Spatial

var posicaoDaCamera = {}
var rotacaoDaCamera = {}
var contador

func _ready():
	
	contador = 0
	
	listaDePosicoes()
	
	translation = posicaoDaCamera[0]
	rotation = rotacaoDaCamera[0]
	$Timer.start()
	
func _on_Timer_timeout():
	
	contador += 1
	if contador >= posicaoDaCamera.size():
		contador = 0
	
	translation = posicaoDaCamera[contador]
	rotation = rotacaoDaCamera[contador]
	
	$Timer.start()

func listaDePosicoes():
	posicaoDaCamera[0] = Vector3(46.0,53.0,43.0)
	rotacaoDaCamera[0] = Vector3(0.0,deg2rad(52),0.0)
	
	#posicaoDaCamera[1] = Vector3(13.8,37.2,20.9)
	#rotacaoDaCamera[1] = Vector3(deg2rad(-24.5),deg2rad(46.1),0.0)
	
