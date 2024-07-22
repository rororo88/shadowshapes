extends CharacterBody2D
class_name Monstro

# VAR monstro

var health: float = 100.0
var speed: float = 240
var damage: int = 50
var target: Heroi 

func _physics_process(delta: float) -> void:
	if target == null:
		target = get_tree().get_nodes_in_group("Heroi")[0]
		#print(target.global_position)

	if target != null:
		velocity = position.direction_to(target.position) * speed
		#print(target.global_position)
		move_and_slide()

# DANO
func _on_hitbox_body_entered(body):
	if "get_damage" in body:
		var knockback_direction = (body.global_position - global_position).normalized()
		body.get_damage(damage, knockback_direction)
		
