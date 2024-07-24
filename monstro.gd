extends CharacterBody2D
class_name Monstro

# VAR monstro

var health: float = 100.0
var speed: float = 100
var damage: int = 50
var target: Heroi 

@onready var navigation_agent_2d = $NavigationAgent2D

func _ready():
	pass
	
func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position

func _physics_process(delta):
	if navigation_agent_2d.is_navigation_finished():
		return
		
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * speed
	move_and_slide()

	#if target == null:
		#target = get_tree().get_nodes_in_group("Heroi")[0]
		##print(target.global_position)
#
	#if target != null:
		#velocity = position.direction_to(target.position) * speed
		##print(target.global_position)
		#move_and_slide()

# DANO
func _on_hitbox_body_entered(body):
	if "get_damage" in body:
		var knockback_direction = (body.global_position - global_position).normalized()
		knockback_direction.y -= 1
		knockback_direction = knockback_direction.normalized()
		body.get_damage(damage, knockback_direction)
		
