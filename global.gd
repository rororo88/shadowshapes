extends Node

var max_lives = 3
var lives = max_lives
var hud 


func lose_life():
	lives -= 1
	hud.load_hearts()
	if lives <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
		lives = max_lives

func add_life():
	pass
