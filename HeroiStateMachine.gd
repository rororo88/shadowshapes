extends Node
class_name HeroiStateMachine

@export var heroi : CharacterBody2D
@export var current_state : State
@export var animation_player : AnimationPlayer

var states : Dictionary = {}

func _ready():
	for child in get_children():
		if(child is State):
			states[child.name] = child
			
			# SET STATES
			child.heroi = heroi
			child.animation_player = animation_player
			child.transition.connect(on_child_transition)
			
		else:
			push_warning("Child " + child.name + "is not a State for HeroiStateMachine")
	current_state.on_enter()


func _physics_process(delta):
		current_state.state_physics_process(delta)

func _process(delta):
	current_state.state_process(delta)

func _input(event : InputEvent):
	current_state.state_input(event)
	
func on_child_transition(new_state_name : StringName):
	var new_state = states.get(new_state_name)
	if new_state != null:
		if new_state != current_state:
			current_state.on_exit()
			new_state.on_enter()
			current_state = new_state
	else:
		push_warning("Erro!")
