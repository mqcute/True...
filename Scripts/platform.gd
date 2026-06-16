extends AnimatableBody2D


func _on_area_2d_body_entered(_body: Node2D) -> void:
	$AnimationPlayer.play("new_animation")

func _on_area_2d_body_exited(_body: Node2D) -> void:
	$AnimationPlayer.play_backwards("new_animation")
