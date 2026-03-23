extends Control

@onready var left_slot = $CenterContainer/HBoxContainer/FirstPanel/left
@onready var mid_slot = $CenterContainer/HBoxContainer/SecondPanel/middle
@onready var right_slot = $CenterContainer/HBoxContainer/ThirdPanel/right

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
