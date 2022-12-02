extends KinematicBody2D

onready var sprite = $AnimatedSprite


export var gravity: float = 8
export var jump_force: float = -220
export var acceleration: float = 600
export var friction: float = 300
export var max_speed: float = 160

var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta): # delta is time since last call in ms
	var x_input: float = Input.get_axis("ui_left", "ui_right")
	if x_input != 0:
		velocity.x = move_toward(velocity.x, x_input * max_speed, delta * acceleration)
		sprite.flip_h = x_input < 0
	
	var friction_mod: float = 1.0
	if is_on_floor():
		if Input.is_action_pressed("ui_up"):
			velocity.y = jump_force
	else:
		friction_mod = 0.5

	velocity.y += gravity
	velocity = move_and_slide(velocity, Vector2.UP)
	
	
	velocity.x = move_toward(velocity.x, 0, delta * friction * friction_mod)
	if abs(velocity.x) > 0.001:
		sprite.play("run")
	else:
		sprite.play("idle")
