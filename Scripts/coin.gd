extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var clink_1: AudioStreamPlayer = $Clink1
@onready var clink_2: AudioStreamPlayer = $Clink2
@onready var clink_3: AudioStreamPlayer = $Clink3

func _on_body_entered(_body: Node2D) -> void:
	game_manager.add_point(1)
	_play_random()
	animation_player.play("PickUp")

func _play_random() -> void:
	match randi_range(1, 3):
		1:
			clink_1.play()
		2:
			clink_2.play()
		3:
			clink_3.play()
