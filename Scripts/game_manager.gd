extends Node

@onready var coin_text: Label = %CoinText

var score : int = 0

func add_point(point : int):
	score += point
	coin_text.text = "i have " + str(score) + "/16 truecoins"
