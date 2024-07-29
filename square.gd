extends Area2D

func _ready():
	Global.square_shape = self

func _on_body_entered(body):
	if body.is_in_group("Heroi"):
		$CollectSound.play()
		square_collected()
		await get_tree().create_timer(0.3).timeout
		queue_free()

func square_collected():
	Global.square = true
	print("coletou quadrado")
