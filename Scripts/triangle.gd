extends Control


func _draw() -> void:
	var points := PackedVector2Array([
		Vector2(0,0),
		Vector2(7,14),
		Vector2(14,0)
	])
	
	var colors := Color(Color.BLACK, 0.5)
	
	draw_colored_polygon(points, colors)
