extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.i_hp = 120
	Global.i_atk = 20
	Global.inimigo_hp = 160
	Global.inimigo_atk = 10
	Global.big_shot = 20


#botão para iniciar o jogo
func _on_iniciar_jogo_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/batalha.tscn")

#botão de sair
func _on_sair_pressed() -> void:
	get_tree().quit()

#botão para ir para a tela de créditos
func _on_creditos_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/tela_creditos.tscn")
