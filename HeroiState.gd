extends Node
class_name State

@export var can_move : bool = true
signal transition(new_state_name : StringName)

var heroi : CharacterBody2D
var animation_player : AnimationPlayer

func state_process(_delta):
	pass

func state_physics_process(_delta):
	pass

func state_input(event : InputEvent):
	pass
	
func on_enter():
	pass
	
func on_exit():
	pass
