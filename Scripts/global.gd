extends Node


func _input(KEY_F11): 
	if KEY_F11.is_action_pressed("toggle_fullscreen"):
		if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


#variaveis do jogador
var i_hp = 120
var i_atk = 25
var i_heal = 25
#variaveis do inimigo
var inimigo_hp = 160
var inimigo_atk = 10
var big_shot = 20


#variaveis do inimigo_2
var inimigo2_hp = 120
var inimigo2_atk = 15
var big_shot2 = 25
