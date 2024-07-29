extends Node

# SHAPES VAR
var square = false
var triangle = false
var circle = false

var square_shape
var triangle_shape
var circle_shape

# LIFE VAR
var max_lives = 3
var lives = max_lives
var hud 

func lose_life():
	lives -= 1
	hud.load_hearts()
	if lives <= 0:
		get_tree().change_scene_to_file("res://game_over.tscn")
		lives = max_lives

func square_collect():
	square_shape.square_collected()
	
func triangle_collect():
	triangle_shape.triangle_collected()
