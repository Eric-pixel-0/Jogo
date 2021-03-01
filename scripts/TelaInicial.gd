extends Control

signal entrar

var visibilidadeDasOpcoes = false

func _on_configuracoes_pressed():
	$configuracoes/botaoGirar.play("aoPassarOMouse")
	$MenuPrincipal.visible = not visibilidadeDasOpcoes
	visibilidadeDasOpcoes = not visibilidadeDasOpcoes

func _on_EntrarJogar_pressed():
	emit_signal("entrar")
	queue_free()
