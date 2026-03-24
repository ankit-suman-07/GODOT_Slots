extends Control

@onready var left_slot = $CenterContainer/HBoxContainer/FirstPanel/left
@onready var mid_slot = $CenterContainer/HBoxContainer/SecondPanel/middle
@onready var right_slot = $CenterContainer/HBoxContainer/ThirdPanel/right

@onready var winnings_label = $WinningsLabel
@onready var bet_label = $BetLabel

const SEVEN = preload("res://assets/seven.png")
const BELL = preload("res://assets/bell.png")
const LEMON = preload("res://assets/lemon.png")
const CHERRY = preload("res://assets/cherries.png")
const STAR = preload("res://assets/star.png")
const WILD = preload("res://assets/cards.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func spin_slot():
	print("Spining")

func change_image():
	pass



func _on_spin_btn_pressed() -> void:
	spin_slot()
	



func _on_bet_5_pressed() -> void:
	print("5")


func _on_bet_25_pressed() -> void:
	print("25")


func _on_bet_50_pressed() -> void:
	print("50")


func _on_bet_100_pressed() -> void:
	print("100")


func _on_bet_250_pressed() -> void:
	print("250")


func _on_restart_btn_pressed() -> void:
	get_tree().reload_current_scene()
	



func _on_close_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
