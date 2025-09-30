extends AnimatedSprite2D

@onready var enemy_sprites: AnimatedSprite2D = $enemy_sprites

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func little_shot():
	enemy_sprites.play("little_shot")

func big_shot():
	enemy_sprites.play("big_shot")

func damage():
	enemy_sprites.play("enemy_damge")
