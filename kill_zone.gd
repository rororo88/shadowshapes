extends Area2D

var damage = 100

func _on_body_entered(body):
	if "get_damage" in body:
		var knockback_direction = Vector2.ZERO
		body.get_damage(damage, knockback_direction)
