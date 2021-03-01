extends Spatial

#Um dia tem 86400 segundos por padrão
const SEGUNDOS_EM_UM_DIA = 60

func _ready():
	pass
	#Para fazer o sol girar:
	$Timer.start()

func _on_Timer_timeout():
	$Ceu.environment.background_sky_rotation.x = $Ceu.environment.background_sky_rotation.x - 360.0 * $Timer.get_wait_time() / SEGUNDOS_EM_UM_DIA
	#Faz o sol girar um pouco a cada tempo de espera
	#MoverOSOl = 512 segundos, é o equivalente a mover 2 graus a cada 2 segundos, mas de forma mais demorada
	rotate_x(deg2rad(360.0 * $Timer.get_wait_time() / SEGUNDOS_EM_UM_DIA))
	$Timer.start()
	

#var temporaria = $Lua.environment.background_sky.sun_latitude
#$Lua.environment.background_sky.sun_latitude += - 360.0 * $Timer.get_wait_time() / SEGUNDOS_EM_UM_DIA

#	if (8.0 <= posicaoDoSol and posicaoDoSol < 10.0):
#		$RaiosDeSol/DirectionalLight.light_color = Color("#ffff80")
#	elif (6.0 <= posicaoDoSol and posicaoDoSol < 8.0):
#		$RaiosDeSol/DirectionalLight.light_color = Color("#ffdf80")
#	elif (4.0 <= posicaoDoSol and posicaoDoSol < 6.0):
#		$RaiosDeSol/DirectionalLight.light_color = Color("#ffc080")
#	elif (2.0 <= posicaoDoSol and posicaoDoSol < 4.0):
#		$RaiosDeSol/DirectionalLight.light_color = Color("#ff80ff")
#	elif (0.0 <= posicaoDoSol and posicaoDoSol < 2.0):
#		$RaiosDeSol/DirectionalLight.light_color = Color("#bf80ff")
#	else:
#		$RaiosDeSol/DirectionalLight.light_color = Color("ffffff")
