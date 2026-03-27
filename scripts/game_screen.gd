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
var total_earned = 1000
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
	#show_animation()
	round_winning_label.text = "Spinning"
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
	var rng = RandomNumberGenerator.new()
	rng.randomize()

	for i in range(15):
		left_slot.texture = SLOT_TEXTURES[rng.randi_range(1, SLOT_TEXTURES.size()-1)]
		mid_slot.texture = SLOT_TEXTURES[rng.randi_range(1, SLOT_TEXTURES.size()-1)]
		right_slot.texture = SLOT_TEXTURES[rng.randi_range(1, SLOT_TEXTURES.size()-1)]
		await get_tree().create_timer(0.2).timeout
	# Reset round winning every time
	#round_winning = 0
	
	# Spin Again (WILD WILD WILD)
	if left == mid and mid == right and left == 5:
		round_winning_label.text = "Spin Again"
		spin = true
		return
	
	# All 3 match → full payout
	if left == mid and mid == right:
		round_winning = bet * MULTIPLIER[left]
		round_winning_label.text = "You won: " + str(round_winning)
	
	# Any 2 match → 50% payout (correct symbol used)
	elif left == mid:
		if right == 5:  # wild support
			round_winning = bet * MULTIPLIER[left]
		else:
			round_winning = bet * MULTIPLIER[left] * 0.5
		round_winning_label.text = "You won: " + str(round_winning)
	
	elif left == right:
		if mid == 5:
			round_winning = bet * MULTIPLIER[left]
		else:
			round_winning = bet * MULTIPLIER[left] * 0.5
		round_winning_label.text = "You won: " + str(round_winning)
	
	elif mid == right:
		if left == 5:
			round_winning = bet * MULTIPLIER[mid]
		else:
			round_winning = bet * MULTIPLIER[mid] * 0.5
		round_winning_label.text = "You won: " + str(round_winning)
	
	else:
		round_winning_label.text = "No Win"
	
	total_earned += round_winning
	update_amount_label()
	
func show_animation():
	pass

func update_amount_label():
	winnings_label.text = "Total Winnings: $" + str(total_earned)
	
func bet_button_clicked(bet_placed):
	bet = bet_placed
	if bet_put:
		return
	if total_earned - bet_placed >= 0:
		total_earned -= bet_placed
		update_amount_label()
		bet_label.text = "BET: $" + str(bet_placed)
		bet_put = true
		spin = true
		
func _on_bet_5_pressed() -> void:
	bet_button_clicked(5)

func _on_bet_25_pressed() -> void:
	bet_button_clicked(25)

func _on_bet_50_pressed() -> void:
	bet_button_clicked(50)

func _on_bet_100_pressed() -> void:
	bet_button_clicked(100)

func _on_bet_250_pressed() -> void:
	bet_button_clicked(250)

func _on_restart_btn_pressed() -> void:
	get_tree().reload_current_scene()
	
func _on_close_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
