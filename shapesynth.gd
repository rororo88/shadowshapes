extends Area2D

var player_inside = false


func _on_body_entered(body):
	if body.is_in_group("Heroi"):
		player_inside = true

func _on_body_exited(body):
	if body.is_in_group("Heroi"):
		player_inside = false

func _process(_delta):
	if player_inside and Input.is_action_just_pressed("interact"):
		ganhou()
		
func ganhou():
	if Global.square == true:
		print("ganhou quadrado")
		if Global.triangle == true:
			print("ganhou triangulo")
			if Global.circle == true:
				print("ganhou circulo")
				get_tree().change_scene_to_file("res://win.tscn")

	else:
		return
