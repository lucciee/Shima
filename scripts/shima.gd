extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var walking = 0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		$AnimatedSprite2D.play("walk")
		walking = 1

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"): # and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.play("fly")
		walking = 0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.flip_h = direction < 0
		
		
		if is_on_floor():
			velocity.y = JUMP_VELOCITY/2
			
		velocity.x = direction * SPEED/(1 + walking * 2)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
