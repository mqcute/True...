extends Node

@onready var coin_text: Label = %CoinText
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var score : int = 0
var ending_playing : bool = false
var lg : bool = false

func add_point(point : int):
	score += point
	coin_text.text = "i have " + str(score) + "/16 truecoins"
	if score == 16:
		ending_playing = true
		animation_player.play("ending")
		get_tree().paused = true

func _process(_delta: float) -> void:
	pass
	if Input.is_action_just_pressed("lg_toggle"):
		lg = not lg
		SignalBus.lg_mode.emit(lg)
