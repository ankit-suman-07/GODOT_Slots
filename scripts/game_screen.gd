extends Control

var rng = RandomNumberGenerator.new()

@onready var left_slot = $CenterContainer/HBoxContainer/FirstPanel/left
@onready var mid_slot = $CenterContainer/HBoxContainer/SecondPanel/middle
@onready var right_slot = $CenterContainer/HBoxContainer/ThirdPanel/right

@onready var winnings_label = $WinningsLabel
@onready var bet_label = $BetLabel

const SEVEN = preload("res://assets/seven.png")
const STAR = preload("res://assets/star.png")
const CHERRY = preload("res://assets/cherries.png")
const LEMON = preload("res://assets/lemon.png")
const BELL = preload("res://assets/bell.png")
const WILD = preload("res://assets/cards.png")

const SLOT_TEXTURES = [
	SEVEN,
	STAR,
	CHERRY,
	LEMON,
	BELL,
	WILD
]

const MULTIPLIER = [25, 15, 10, 5, 2, 1]
var WEIGHTS = PackedFloat32Array([1, 3, 4, 6, 8, 3])
var bet = 0
var total_earned = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func spin_slot():
	# Use weights instead of probabilities
	var left_index = rng.rand_weighted(WEIGHTS)
	var mid_index = rng.rand_weighted(WEIGHTS)
	var right_index = rng.rand_weighted(WEIGHTS)
	
	update_slots(left_index, mid_index, right_index)
	#check_slots(left_index, mid_index, right_index)
	

func update_slots(left, mid, right):
	left_slot.texture = SLOT_TEXTURES[left]
	mid_slot.texture = SLOT_TEXTURES[mid]
	right_slot.texture = SLOT_TEXTURES[right]
	



func _on_spin_btn_pressed() -> void:
	spin_slot()
	

func update_winning():
	pass

func update_amount_label():
	winnings_label.text = "Total Winnings: $" + str(total_earned)


func _on_bet_5_pressed() -> void:
	total_earned -= 5
	update_amount_label()
	bet_label.text = "BET: $5"
	print("5")


func _on_bet_25_pressed() -> void:
	total_earned -= 25
	update_amount_label()
	bet_label.text = "BET: $25"
	print("25")


func _on_bet_50_pressed() -> void:
	total_earned -= 50
	update_amount_label()
	bet_label.text = "BET: $50"
	print("50")


func _on_bet_100_pressed() -> void:
	total_earned -= 100
	update_amount_label()
	bet_label.text = "BET: $100"
	print("100")


func _on_bet_250_pressed() -> void:
	total_earned -= 250
	update_amount_label()
	bet_label.text = "BET: $250"
	print("250")


func _on_restart_btn_pressed() -> void:
	get_tree().reload_current_scene()
	



func _on_close_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
