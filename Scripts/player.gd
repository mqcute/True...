extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -600.0

var ORIGINAL_SCALE = $Sprite2D.scale

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

#animations
func _process(_delta: float) -> void:
	if Input.get_axis("ui_left", "ui_right") and is_on_floor(): # walking
		$Sprite2D.rotation_degrees = 10 if sin(Time.get_ticks_msec() * 2 * get_process_delta_time())/3 > 0 else -10
		$Sprite2D.scale = Vector2(ORIGINAL_SCALE)
	elif !is_on_floor(): # air
		$Sprite2D.rotation = 0
		$Sprite2D.scale = Vector2(ORIGINAL_SCALE.x,ORIGINAL_SCALE.y * 1.2)
	else: # idle
		$Sprite2D.rotation = 0
		$Sprite2D.scale = Vector2(ORIGINAL_SCALE)
