extends Button

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_configuracoes_mouse_entered():
	$botaoGirar.play("aoPassarOMouse")
	
func _on_configuracoes_mouse_exited():
	$botaoGirar.play("aoSairComOMouse")
