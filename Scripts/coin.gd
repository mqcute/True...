extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var clink_1: AudioStreamPlayer = $Clink1
@onready var clink_2: AudioStreamPlayer = $Clink2
@onready var clink_3: AudioStreamPlayer = $Clink3
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	SignalBus.lg_mode.connect(_change_animation)


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


func _change_animation(lg) -> void:
	if lg:
		animated_sprite_2d.play("lg")
	else:
		animated_sprite_2d.play("default")
