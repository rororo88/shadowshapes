extends State
class_name AirState

@export var landing_state : State
@export var landing_animation : String = "landing"
@export var air_resist = 900
@export var air_accel = 2500

func state_physics_process(delta):
	if heroi.is_on_floor():
		transition.emit("GroundState")
	if heroi.direction == Vector2.ZERO:
		apply_air_ressit(delta) 
	if heroi.direction != Vector2.ZERO:
		apply_air_accel(delta)

func on_enter():
	animation_player.play("jump")
	
func apply_air_ressit(delta):
	heroi.velocity.x = move_toward(heroi.velocity.x, 0, air_resist * delta)
	
func apply_air_accel(delta):
	heroi.velocity.x = move_toward(heroi.velocity.x, heroi.speed * heroi.direction.x, air_accel * delta)
