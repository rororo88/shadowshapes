extends Area2D

func _ready():
	Global.circle_shape = self

func _on_body_entered(body):
	if body.is_in_group("Heroi"):
		$CollectSound.play()
		circle_collected()
		await get_tree().create_timer(0.3).timeout
		queue_free()

func circle_collected():
	Global.circle = true
	print("coletou circulo")
