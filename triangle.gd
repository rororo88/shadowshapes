extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Heroi"):
		$CollectSound.play()
		triangle_collected()
		await get_tree().create_timer(0.3).timeout
		queue_free()

func triangle_collected():
	Global.triangle = true
	print("coletou triangulo")
