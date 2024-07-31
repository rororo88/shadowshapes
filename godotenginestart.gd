extends Sprite2D

@onready var logo_vertical_color_dark = $"."
@onready var tween = 

func _ready():
	logo_vertical_color_dark.modulate = Color(1,1,1,0)
	fade_in()
	
	func fade_in():
	tween.interpolate_property(logo_vertical_color_dark, "modulate", Color(1,1,1,0), Color(1,1,1,1), 2.0, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
