extends CharacterBody2D
class_name Heroi

# VAR animação
@onready var sprite : Sprite2D = $Sprite2D
var animation_locked : bool = false
@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state_machine : HeroiStateMachine = $HeroiStateMachine

# VAR movimento
var was_in_air : bool = false
var direction : Vector2 = Vector2.ZERO
var start_pos : Vector2 = Vector2(91,452)
@export var speed = 300

@export var gravity: float = 1700.0

# VAR Vida e vitalidade
@export var health := 100
@export var max_health = 100

# VAR KNOCKBACK VAR
@export var knockback_force: float = 850.0
@export var knockback_duration: float = 0.1
var knockback_time: float = 0.0
var knockback_direction: Vector2 = Vector2.ZERO

# REFERENCIA MONSTRO - PARA PATHFINDER
@export var monster_path : NodePath

func _ready():
	animation_tree.active = true

# PHYSICS - FRAME
func _physics_process(delta):

# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta

# MOVE MOVE MOVE
	direction = Input.get_vector("left", "right", "up", "down")
	if direction.x != 0 && state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if knockback_time > 0:
		knockback_time -= delta
		velocity.x = knockback_direction.x * knockback_force
		velocity.y = knockback_direction.y * knockback_force + gravity * delta
		$AnimatedSprite2D.play("knockback")

	move_and_slide()
	update_animation()
	update_facing_direction()

# ANIMAÇÃO
func update_animation():
	animation_tree.set("parameters/Move/blend_position", direction.x)
	

# FLIP SPRITE
func update_facing_direction():
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true


# RECEBER DANO
func get_damage(amount: int, received_knockback_direction: Vector2) -> void:
	health -= amount
	print(health)
	apply_knockback(received_knockback_direction)
	$AnimatedSprite2D.play("knockback")
	if health <= 0:
		die()

# KNOCKBACK
func apply_knockback(the_knockback_direction: Vector2) -> void:
	knockback_time = knockback_duration
	self.knockback_direction = the_knockback_direction
	if ! is_on_floor():
		$AnimatedSprite2D.play("knockback")

# MORTE
func die():
	if health <= 0:
		print("Heroi Morreu!!")
		Global.call_deferred("lose_life") #lose_life()
		reset_hero()

# RESPAWN
func reset_hero():
	health = max_health
	global_position = start_pos
	velocity = Vector2.ZERO
	print("respawn", health)
	if has_node(monster_path):
		var monster = get_node(monster_path) as Monstro
		monster.reset_pos()
	
