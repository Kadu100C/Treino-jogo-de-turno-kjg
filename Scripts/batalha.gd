extends Node2D


@onready var bruh: Sprite2D = $Control/bruh
@onready var act: MarginContainer = $Control/act
@onready var timer: Timer = $timer
@onready var jogador: AnimatedSprite2D = $Control/I
@onready var inimigo: AnimatedSprite2D = $Control/inimigos/inimigo
@onready var magic: MarginContainer = $Control/magic
@onready var vida_jogador: ProgressBar = $Control/I/vida_jogador



var turno = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	vida_jogador.value = Global.i_hp
	bruh.visible = false
	act.visible = false
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

	if turno == -1:
		inimigo.play("little_shot")
		await get_tree().create_timer(1.5).timeout
		jogador.play("damage")
		await get_tree().create_timer(1).timeout
		inimigo.play("enemy_idle")
		jogador.play("idle")
		Global.i_hp -= Global.inimigo_atk
		vida_jogador.value = Global.i_hp
		print(Global.i_hp)
		turno = 1

func _on_lutar_pressed() -> void:
	turno = 0
	jogador.play("act")
	await get_tree().create_timer(1).timeout
	jogador.play("attack")
	inimigo.play("enemy_damage")
	await get_tree().create_timer(1).timeout
	inimigo.play("enemy_idle")
	Global.inimigo_hp -= Global.i_atk
	await get_tree().create_timer(1).timeout
	jogador.play("idle")
	turno = -1

func _on_magia_pressed() -> void:
	turno = 2
	jogador.play("prep_cast")
	await get_tree().create_timer(0.5).timeout
	jogador.play("cast")

func _on_curar_pressed() -> void:
	turno = 0
	Global.i_hp += 20
	vida_jogador.value = Global.i_hp
	jogador.play("idle")
	turno = -1

func _on_aprimorar_pressed() -> void:
	turno = 0
	Global.i_atk += 10
	jogador.play("idle")
	turno = -1
