extends Node2D


@onready var bruh: Sprite2D = $Control/bruh
@onready var act: MarginContainer = $Control/act
@onready var escolha: MarginContainer = $Control/escolha

@onready var timer: Timer = $timer
@onready var jogador: AnimatedSprite2D = $Control/I
@onready var inimigo: AnimatedSprite2D = $Control/inimigos/inimigo
@onready var inimigo_2: AnimatedSprite2D = $Control/inimigos/inimigo2

@onready var magic: MarginContainer = $Control/magic
@onready var vida_jogador: ProgressBar = $Control/I/vida_jogador
@onready var vida_inimigo: ProgressBar = $Control/inimigos/inimigo/vida_inimigo
@onready var vida_inimigo_2: ProgressBar = $Control/inimigos/inimigo2/vida_inimigo_2

@onready var musica_de_batalha__ruder_buster_: AudioStreamPlayer2D = $"Control/musica_de_batalha_(ruder_buster)"
@onready var enemy_hit: AudioStreamPlayer2D = $"Control/efeitos sonoros/enemy_hit"
@onready var i_slash: AudioStreamPlayer2D = $"Control/efeitos sonoros/i_slash"
@onready var take_damage: AudioStreamPlayer2D = $"Control/efeitos sonoros/take_damage"
@onready var curinha: AudioStreamPlayer2D = $"Control/efeitos sonoros/curinha"
@onready var buff: AudioStreamPlayer2D = $"Control/efeitos sonoros/buff"
@onready var enemy_attck: AudioStreamPlayer2D = $"Control/efeitos sonoros/enemy_attck"



var turno = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vida_jogador.value = Global.i_hp
	vida_inimigo.value = Global.inimigo_hp
	vida_inimigo_2.value = Global.inimigo2_hp
	bruh.visible = false
	act.visible = false
	escolha.visible = false
	magic.visible = false
	turno = 1

func _process(delta: float) -> void:
	#print(turno)
	if turno == 1:
		act.visible = true
	else:
		act.visible = false
	if turno == 2:
		magic.visible = true
	else:
		magic.visible = false
	if turno == 3:
		escolha.visible = true
	else:
		escolha.visible = false



	if Global.i_hp <= 0:
		musica_de_batalha__ruder_buster_.stop()
		jogador.play("damage")
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Scenes/voce_perdeu_wtf.tscn")

	if Global.inimigo_hp and Global.inimigo2_hp <= 0:
		pass

	if Global.inimigo_hp <= 0:
		inimigo.play("enemy_bruh")


	if Global.inimigo2_hp <= 0:
		inimigo_2.play("enemy_bruh")

func turno_inimigo():
	if turno == -1:
		if Global.i_hp <= Global.inimigo_hp:
			inimigo.play("little_shot")
			enemy_attck.play()
		else:
			inimigo.play("big_shot")
			enemy_attck.play()
		await get_tree().create_timer(1.5).timeout
		jogador.play("damage")
		take_damage.play()
		await get_tree().create_timer(1).timeout
		inimigo.play("enemy_idle")
		jogador.play("idle")
		if Global.i_hp <= Global.inimigo_hp:
			Global.i_hp -= Global.inimigo_atk
			if Global.inimigo2_hp >= 0:
				turno = -2
				turno_inimigo2()
			else:
				turno = 1
		else:
			Global.i_hp -= Global.big_shot
			await get_tree().create_timer(3).timeout
			turno = 1
		vida_jogador.value = Global.i_hp
		print(Global.i_hp)
	else:
		pass


func turno_inimigo2():
	if turno == -2:
		if Global.i_hp <= Global.inimigo2_hp:
			inimigo_2.play("little_shot")
			enemy_attck.play()
		else:
			inimigo_2.play("big_shot")
			enemy_attck.play()
		await get_tree().create_timer(1.5).timeout
		jogador.play("damage")
		take_damage.play()
		await get_tree().create_timer(1).timeout
		inimigo_2.play("enemy_idle")
		jogador.play("idle")
		if Global.i_hp <= Global.inimigo2_hp:
			Global.i_hp -= Global.inimigo2_atk
			turno = 1
		else:
			Global.i_hp -= Global.big_shot2
		vida_jogador.value = Global.i_hp
		print(Global.i_hp)
		turno = 1
	else:
		pass



func _on_lutar_pressed() -> void:
	turno = 0
	jogador.play("act")
	await get_tree().create_timer(1).timeout
	turno = 3
func _on_inimigo_a_pressed() -> void:
	turno = 0
	jogador.play("attack")
	await get_tree().create_timer(0.4).timeout
	i_slash.play()
	inimigo.play("enemy_damage")
	await get_tree().create_timer(0.5).timeout
	enemy_hit.play()
	await get_tree().create_timer(1).timeout
	inimigo.play("enemy_idle")
	Global.inimigo_hp -= Global.i_atk
	vida_inimigo.value = Global.inimigo_hp
	await get_tree().create_timer(1).timeout
	jogador.play("idle")
	if Global.inimigo_hp >= 0:
		turno = -1
		turno_inimigo()
	elif Global.inimigo_hp <= 0:
		turno = -2
		turno_inimigo2()
		
func _on_inimigo_b_pressed() -> void:
	turno = 0
	jogador.play("attack")
	await get_tree().create_timer(0.4).timeout
	i_slash.play()
	inimigo_2.play("enemy_damage")
	await get_tree().create_timer(0.5).timeout
	enemy_hit.play()
	await get_tree().create_timer(1).timeout
	inimigo_2.play("enemy_idle")
	Global.inimigo2_hp -= Global.i_atk
	vida_inimigo_2.value = Global.inimigo2_hp
	await get_tree().create_timer(1).timeout
	jogador.play("idle")
	if Global.inimigo_hp >= 0:
		turno = -1
		turno_inimigo()
func _on_magia_pressed() -> void:
	turno = 2
	jogador.play("prep_cast")
	await get_tree().create_timer(0.5).timeout
	jogador.play("cast")

func _on_curar_pressed() -> void:
	curinha.play()
	turno = 0
	Global.i_hp += 20
	vida_jogador.value = Global.i_hp
	jogador.play("idle")
	if Global.inimigo_hp >= 0:
		turno = -1
		turno_inimigo()
func _on_aprimorar_pressed() -> void:
	buff.play()
	turno = 0
	Global.i_atk += 10
	jogador.play("idle")
	if Global.inimigo_hp >= 0:
		turno = -1
		turno_inimigo()
