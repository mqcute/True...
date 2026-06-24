extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	var tween := create_tween()
	tween.set_ignore_time_scale(true)
	tween.set_parallel(true)
	tween.set_ease(Tween.EASE_IN)
	tween.set_trans(Tween.TRANS_BACK)
	tween.tween_property(body, "position", Vector2(body.position.x, body.position.y + 1000), 1)
	
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CIRC)
	tween.tween_property(Engine, "time_scale", 0, 1)
	
	tween.set_trans(tween.TRANS_LINEAR)
	tween.tween_property(Carefree, "pitch_scale", 0.01, 1)
	
	
	body.get_node("CollisionShape2D").queue_free()
	
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	Carefree.pitch_scale = 1
	get_tree().reload_current_scene()
