extends Button

@onready var restart_sound = $RestartSound

func _on_pressed():
	restart_sound.play()
	await get_tree().create_timer(0.08).timeout
	get_tree().change_scene_to_file("res://main.tscn")
