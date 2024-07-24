extends StaticBody2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Heroi"):
		var sprite = body.get_node("AnimatedSprite2D")
		sprite.modulate = Color.BLACK

func _on_area_2d_body_exited(body):
	if body.is_in_group("Heroi"):
		var sprite = body.get_node("AnimatedSprite2D")
		sprite.modulate = Color.WHITE
