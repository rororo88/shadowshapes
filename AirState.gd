extends State
class_name AirState

@export var landing_state : State
@export var landing_animation : String = "landing"

func state_process(delta):
	if(heroi.is_on_floor()):
		next_state = landing_state
