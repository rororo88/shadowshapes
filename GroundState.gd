extends State
class_name GroundState

@export var jump_velocity : float = -600
@export var air_state : State
@export var jump_animation : String = "jump"
@onready var jump_sound = $"../../JumpSound"


func state_physics_process(_delta):
	heroi.move()
	
func state_input(event : InputEvent):
	if(event.is_action_pressed("jump")):
		jump()
		
func jump():
	heroi.velocity.y = jump_velocity
	animation_player.play("jump")
	transition.emit("AirState")
	jump_sound.play()
