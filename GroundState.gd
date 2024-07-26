extends State
class_name GroundState

@export var jump_velocity : float = -600
@export var air_state : State
@export var jump_animation : String = "jump"

func state_process(delta):
	if(!heroi.is_on_floor()):
		next_state = air_state

func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
func jump():
	heroi.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)
