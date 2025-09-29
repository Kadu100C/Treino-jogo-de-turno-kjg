extends CanvasLayer

@onready var resume: Button = $VBoxContainer/resume
@onready var button: Button = $VBoxContainer/Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		get_tree().paused = true
		resume.grab_focus()

func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_button_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://Scenes/tela_inicial.tscn")
