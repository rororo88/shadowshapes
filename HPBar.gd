extends ProgressBar

@onready var heroi = $"../../../Heroi"

func _ready():
	heroi.connect("damage_taken", Callable(self, "_on_damage_taken"))
	heroi.connect("player_respawn", Callable(self, "_on_player_respawn"))
	
	
func _on_damage_taken(amout):
	set_value_no_signal(value - amout)
	print(amout)
	
func _on_player_respawn():
	set_value_no_signal(max_value)
