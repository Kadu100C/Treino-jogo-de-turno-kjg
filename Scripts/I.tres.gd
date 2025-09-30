extends AnimatedSprite2D

@onready var i_sprites: AnimatedSprite2D = $i_sprites


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func vento():
	i_sprites.play("1 idle")

func act():
	i_sprites.play("2 act")

func attack():
	i_sprites.play("3 attack")

func prep_cast():
	i_sprites.play("4 prep_cast")

func cast():
	i_sprites.play("5 casting")

func damage():
	i_sprites.play("6 damage")
