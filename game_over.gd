extends Control

@onready var game_over_sound = $GameOverSound

func _ready():
	game_over_sound.play()
