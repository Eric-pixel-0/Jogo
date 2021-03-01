extends Spatial

var distanciaMaximaEdicao = 100
var tamanhoMaximoEsfera = 3
var tamanhoMinimoEsfera = 1
var taxaCrescimentoEsfera = 0.1

var ferramentaVoxel
var modoDeEdicao = false

var areaJogadorAtual
var areaJogadorAntiga
var tamanhoDeUmaArea = 48

var meusVoxels = {}
var meusVoxelsOnOff = {}
var meusVoxelsRaio = {}
var contador = 0

func _ready():
	ferramentaVoxel = get_node("VoxelLodTerrain").get_voxel_tool()
	areaJogadorAntiga = retornaAAreaDeUmLocal($Jogador/PraRotacionar.get_global_transform().origin)
	
	$Mouse.scale.x = tamanhoMinimoEsfera
	$Mouse.scale.y = tamanhoMinimoEsfera
	$Mouse.scale.z = tamanhoMinimoEsfera
	
func _input(event):
	
#	#para mover a esfera de edicao de acordo com a visao do personagem
#	if (event is InputEventMouseMotion) and (modoDeEdicao):
#		var origem = $Jogador/PraRotacionar.get_global_transform().origin
#		var direcao = -$Jogador/PraRotacionar.get_global_transform().basis.z.normalized()
#
#		var temporaria = ferramentaVoxel.raycast(origem, direcao, distanciaMaximaEdicao)
#		if temporaria != null:
#			$Mouse.translation = temporaria.position
#		else:
#			pass

	if (event is InputEventMouseMotion) and (modoDeEdicao):
		var origem = $Jogador/PraRotacionar.get_global_transform().origin
		var direcao = -$Jogador/PraRotacionar.get_global_transform().basis.z.normalized()
		
		$Mouse.translation = origem + direcao * 10
	
	#para aumentar ou diminuir a esfera de edicao
	if (event is InputEventMouseButton) and modoDeEdicao:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				if $Mouse.scale.x < tamanhoMaximoEsfera:
					$Mouse.scale.x = $Mouse.scale.x + taxaCrescimentoEsfera
					$Mouse.scale.y = $Mouse.scale.y + taxaCrescimentoEsfera
					$Mouse.scale.z = $Mouse.scale.z + taxaCrescimentoEsfera
					
			if event.button_index == BUTTON_WHEEL_DOWN:
				if $Mouse.scale.x > tamanhoMinimoEsfera:
					$Mouse.scale.x = $Mouse.scale.x - taxaCrescimentoEsfera
					$Mouse.scale.y = $Mouse.scale.y - taxaCrescimentoEsfera
					$Mouse.scale.z = $Mouse.scale.z - taxaCrescimentoEsfera
					
	
func _process(_delta):
	
#	#atualiza o mapa de acordo com a caminhada
#	if moveu():
#		if mudouDeArea():
#			for i in contador:
#				if meusVoxelsOnOff[i] == 1:
#					ferramentaVoxel.mode = VoxelTool.MODE_ADD
#				else:
#					ferramentaVoxel.mode = VoxelTool.MODE_REMOVE
#				ferramentaVoxel.do_sphere(meusVoxels[i], meusVoxelsRaio[i])
	
	if Input.is_action_just_pressed("modoDeEdicao"):
		modoDeEdicao = not modoDeEdicao
		$Mouse.visible = modoDeEdicao
		
	if Input.is_action_just_pressed("cavar") and modoDeEdicao:
		ferramentaVoxel.mode = VoxelTool.MODE_REMOVE
		alterar()
	
	if Input.is_action_just_pressed("tampar") and modoDeEdicao:
		ferramentaVoxel.mode = VoxelTool.MODE_ADD
		alterar()
		
	#$Agua.translation = Vector3($Jogador.translation.x,0,$Jogador.translation.z)

func alterar():
	var local = $Mouse.get_global_transform().origin
	ferramentaVoxel.do_sphere(local, $Mouse.scale.x)
	get_node("VoxelLodTerrain").debug_save_all_modified_blocks()
	
#	#armazena a edicao
#	meusVoxels[contador] = local
#	meusVoxelsRaio[contador] = $Mouse.scale.x
#	if ferramentaVoxel.mode == VoxelTool.MODE_ADD:
#		meusVoxelsOnOff[contador] = 1
#	else:
#		meusVoxelsOnOff[contador] = 0
#	contador = contador + 1
	
func moveu():
	var moveu = false
	if Input.is_action_pressed("movement_forward") or Input.is_action_pressed("movement_backward") or Input.is_action_pressed("movement_left") or Input.is_action_pressed("movement_right"):
		moveu = true
		
	return moveu
	
func retornaAAreaDeUmLocal(local):
	var resultado = {}
	var temporaria1 = local.x
	var temporaria2 = local.z
	
	resultado[0] = int (temporaria1/tamanhoDeUmaArea)
	resultado[1] = int (temporaria2/tamanhoDeUmaArea)
	
	return resultado

func mudouDeArea():
	var mudou = false
	
	areaJogadorAtual = retornaAAreaDeUmLocal($Jogador/PraRotacionar.get_global_transform().origin)
	if (areaJogadorAntiga[0] != areaJogadorAtual[0]) or (areaJogadorAntiga[1] != areaJogadorAtual[1]):
		mudou = true
		print("Mudou!!!")
		areaJogadorAntiga = retornaAAreaDeUmLocal($Jogador/PraRotacionar.get_global_transform().origin)
		
	return mudou
#func tampar(local):
##	ferramentaVoxel.set_voxel(local, 7)
##	meusVoxels[contador] = local
##	meusVoxelsOnOff[contador] = 1
##	contador = contador + 1
#
#	ferramentaVoxel.mode = VoxelTool.MODE_ADD
#	ferramentaVoxel.do_sphere(local, $Mouse.scale.x)
#	meusVoxels[contador] = local
#	meusVoxelsOnOff[contador] = 1
#	meusVoxelsRaio[contador] = $Mouse.scale.x
#	contador = contador + 1
	
func _on_TelaInicial_entrar():
	$TelaInicial.queue_free()
	$CameraTelaInicial.queue_free()
	
	var temporaria = preload("res://recursos/Jogador.tscn")
	var instanciaJogador = temporaria.instance()
	
	add_child(instanciaJogador)
	
	instanciaJogador.translation = Vector3(-42.0,40.0,-50.0)
	instanciaJogador.rotation = Vector3(0.0,deg2rad(180),0.0)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#$Terreno/VoxelTerrain.set_viewer_path(instanciaJogador.get_path())
	
#func _on_Casa_input_event(_camera, _event, click_position, _click_normal, _shape_idx):
#	pass
#	$Mouse.translation = click_position
