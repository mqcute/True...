extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(_body: Node2D) -> void:
	game_manager.add_point(1)
	var i = randi_range(1, 3)
	match i:
		1:
			animation_player.play("PickUp1")
		2:
			animation_player.play("PickUp2")
		3:
			animation_player.play("PickUp3")
		
