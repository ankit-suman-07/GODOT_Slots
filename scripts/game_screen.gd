extends Control

var rng = RandomNumberGenerator.new()

@onready var left_slot = $CenterContainer/HBoxContainer/FirstPanel/left
@onready var mid_slot = $CenterContainer/HBoxContainer/SecondPanel/middle
@onready var right_slot = $CenterContainer/HBoxContainer/ThirdPanel/right

@onready var winnings_label = $WinningsLabel
@onready var round_winning_label = $RoundWinning
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
var WEIGHTS = PackedFloat32Array([2, 2, 4, 4, 2, 3])
var bet = 0
var total_earned = 100
var round_winning = 0
var spin = false
var bet_put = false

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
	
	#var left_index = 5
	#var mid_index = 5
	#var right_index = 5
	
	update_slots(left_index, mid_index, right_index)
	#check_slots(left_index, mid_index, right_index)
	update_winning(left_index, mid_index, right_index)

func update_slots(left, mid, right):
	left_slot.texture = SLOT_TEXTURES[left]
	mid_slot.texture = SLOT_TEXTURES[mid]
	right_slot.texture = SLOT_TEXTURES[right]

func _on_spin_btn_pressed() -> void:
	round_winning = 0
	if spin:
		print("Spinning")
		spin = false
		bet_put = false
		spin_slot()

func update_winning(left, mid, right):
	if left == right and left == mid and left == 5:
		print("Spin Again !!!!!!")
		round_winning_label.text = "Spin Again"
		spin = true
	# All 3 match → full payout
	elif left == mid and mid == right:
		round_winning = bet * MULTIPLIER[left]
		round_winning_label.text = "You won: " + str(round_winning)
		total_earned += round_winning
		return
		
	# Any 2 match → 50% payout
	elif left == mid or left == right or mid == right:
		if left == mid and right == 5:
			round_winning = bet * MULTIPLIER[left]
		elif left == right and mid == 5:
			round_winning = bet * MULTIPLIER[left]
		elif right == mid and left == 5:
			round_winning = bet * MULTIPLIER[right]
		else:
			round_winning = bet * MULTIPLIER[left] * 0.5
		round_winning_label.text = "You won: " + str(round_winning)
	elif mid == right:
		round_winning = bet * MULTIPLIER[mid] * 0.5
		round_winning_label.text = "You won: " + str(round_winning)
	
	total_earned += round_winning
	update_amount_label()

func update_amount_label():
	winnings_label.text = "Total Winnings: $" + str(total_earned)
	

func _on_bet_5_pressed() -> void:
	if bet_put:
		return
	bet = 5
	if total_earned - bet >= 0:
		total_earned -= 5
		update_amount_label()
		bet_label.text = "BET: $5"
		bet_put = true
		spin = true

func _on_bet_25_pressed() -> void:
	if bet_put:
		return
	bet = 25
	if total_earned - bet >= 0:
		total_earned -= 25
		update_amount_label()
		bet_label.text = "BET: $25"
		bet_put = true
		spin = true

func _on_bet_50_pressed() -> void:
	if bet_put:
		return
	bet = 50
	if total_earned - bet >= 0:
		total_earned -= 50
		update_amount_label()
		bet_label.text = "BET: $50"
		bet_put = true
		spin = true

func _on_bet_100_pressed() -> void:
	if bet_put:
		return
	bet = 100
	if total_earned - bet >= 0:
		total_earned -= 100
		update_amount_label()
		bet_label.text = "BET: $100"
		bet_put = true
		spin = true

func _on_bet_250_pressed() -> void:
	if bet_put:
		return
	bet = 250
	if total_earned - bet >= 0:
		total_earned -= 250
		update_amount_label()
		bet_label.text = "BET: $250"
		bet_put = true
		spin = true

func _on_restart_btn_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_close_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
