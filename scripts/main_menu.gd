extends Control

@onready var button_select_sound = $ButtonSelectSound

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_play_game_pressed() -> void:
	button_select_sound.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().change_scene_to_file("res://scenes/game_screen.tscn")



func _on_exit_pressed() -> void:
	button_select_sound.play()
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
