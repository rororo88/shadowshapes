extends CharacterBody2D
class_name Monstro

# VAR monstro

var health: float = 100.0
@export var movement_speed = 230
@export var damage: int = 50

@export var target: Node2D = null
@onready var sprite_2d = $AnimatedSprite2D
@onready var navigation_agent_2d = $NavigationAgent2D

# Variavel Posição Inicial
var start_pos : Vector2 = Vector2(-130, -2)

func _ready():
	set_physics_process(false)
	call_deferred("seeker_setup")

func seeker_setup():
	await get_tree().physics_frame
	if target:
		navigation_agent_2d.target_position = target.global_position
		set_physics_process(true)

func _physics_process(_delta):
	if target:
		navigation_agent_2d.target_position = target.global_position
	if navigation_agent_2d.is_navigation_finished():
		return
		
	var current_agent_position = global_position
	var next_path_position = navigation_agent_2d.get_next_path_position()
	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	move_and_slide()
	
	#ANIMAÇÂO AQUI
	if velocity.x > 0:
		sprite_2d.flip_h = false
	else:
		sprite_2d.flip_h = true
		
# FUNC RESET DE POSIÇÂO
func reset_pos():
	set_position(start_pos)


# DANO
func _on_hitbox_body_entered(body):
	if "get_damage" in body:
		var knockback_direction = (body.global_position - global_position).normalized()
		knockback_direction.y -= 1
		knockback_direction = knockback_direction.normalized()
		body.get_damage(damage, knockback_direction)

