extends CanvasLayer

func _ready():
	load_hearts()
	Global.hud = self

func load_hearts():
	$HeartsFull.size.x = Global.lives * 16
	$HeartsEmpty.size.x = (Global.max_lives - Global.lives) * 16
	$HeartsEmpty.position.x = $HeartsFull.position.x + $HeartsFull.size.x * $HeartsFull.scale.x
