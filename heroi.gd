extends CharacterBody2D
class_name Heroi

# Variáveis de movimento
var start_pos : Vector2 = Vector2(91,452)
@export var speed = 300
@export var jump_force: float = -600.0
@export var gravity: float = 1700.0

# Vida e vitalidade
@export var health := 100
@export var max_health = 100

#KNOCKBACK VAR
@export var knockback_force: float = 850.0
@export var knockback_duration: float = 0.1
var knockback_time: float = 0.0
var knockback_direction: Vector2 = Vector2.ZERO

# REFERENCIA MONSTRO
@export var monster_path : NodePath

func _ready():
	pass

# função chamada a cada frame
func _physics_process(delta: float) -> void:

	if knockback_time > 0:
		knockback_time -= delta
		velocity.x = knockback_direction.x * knockback_force
		velocity.y = knockback_direction.y * knockback_force + gravity * delta
		$AnimatedSprite2D.play("knockback")
	else:
	# movimento horizontal
		if Input.is_action_pressed("right"):
			velocity.x = + speed 
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("run")
		elif  Input.is_action_pressed("left"):
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("run")
			velocity.x = - speed
		
		else:
			velocity.x = 0
			$AnimatedSprite2D.play("idle")
	
	# aplicando gravidade
	if not is_on_floor():
		velocity.y += gravity * delta
		$AnimatedSprite2D.play("jump")
	else:
		velocity.y = 0 # reset vertical

# pulo
	if is_on_floor() and Input.is_action_pressed("jump"):
		velocity.y = jump_force
		
	# MOVE
	move_and_slide()

	# função para receber dano
func get_damage(amount: int, received_knockback_direction: Vector2) -> void:
	health -= amount
	print(health)
	apply_knockback(received_knockback_direction)
	$AnimatedSprite2D.play("knockback")
	if health <= 0:
		die()

# função knockback
func apply_knockback(the_knockback_direction: Vector2) -> void:
	knockback_time = knockback_duration
	self.knockback_direction = the_knockback_direction
	if ! is_on_floor():
		$AnimatedSprite2D.play("knockback")

# MORTE
func die():
	if health <= 0:
		print("Heroi Morreu!")
		Global.call_deferred("lose_life") #lose_life()
		reset_hero()

func reset_hero():
	health = max_health
	global_position = start_pos
	velocity = Vector2.ZERO
	print("respawn", health)
	if has_node(monster_path):
		var monster = get_node(monster_path) as Monstro
		monster.reset_pos()
	
