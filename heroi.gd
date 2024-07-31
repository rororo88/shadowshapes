extends CharacterBody2D
class_name Heroi

signal damage_taken(amout)
signal player_respawn

@onready var damage_sound = $DamageSound
@onready var death_sound = $DeathSound


# VAR animação
@onready var sprite : Sprite2D = $Sprite2D
@onready var state_machine : HeroiStateMachine = $HeroiStateMachine
@onready var animation_player : AnimationPlayer = $AnimationPlayer

# VAR movimento
var direction : Vector2 = Vector2.ZERO
var start_pos : Vector2 = Vector2(91,452)
@export var speed = 350

@export var gravity: float = 1700.0

# VAR Vida e vitalidade
@export var health := 100
@export var max_health = 100

# VAR KNOCKBACK VAR
@export var knockback_force: float = 700.0
@export var knockback_duration: float = 0.1
var knockback_time: float = 0.0
var knockback_direction: Vector2 = Vector2.ZERO

# REFERENCIA MONSTRO - PARA PATHFINDER
@export var monster_path : NodePath

func _ready():
	set_position(start_pos)
	
	
# PHYSICS - FRAME
func _physics_process(delta):
	direction = Input.get_vector("left", "right", "up", "down")

# Add gravity
	if not is_on_floor():
		velocity.y += gravity * delta

# MOVE MOVE MOVE

	if knockback_time > 0:
		knockback_time -= delta
		velocity.x = knockback_direction.x * knockback_force
		velocity.y = knockback_direction.y * knockback_force + gravity * delta
		animation_player.play("knockback")

	move_and_slide()
	update_animation()
	update_facing_direction()

func move():
	if direction.x != 0:
		velocity.x = direction.x * speed
		animation_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		animation_player.play("idle")
	
# ANIMAÇÃO
func update_animation():
	#animation_tree.set("parameters/Move/blend_position", direction.x)
	pass

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
	emit_signal("damage_taken", amount)
	apply_knockback(received_knockback_direction)
	animation_player.play("knockback")
	damage_sound.play()
	if health <= 0:
		die()

# KNOCKBACK
func apply_knockback(the_knockback_direction: Vector2) -> void:
	knockback_time = knockback_duration
	self.knockback_direction = the_knockback_direction
	if ! is_on_floor():
		animation_player.play("knockback")

# MORTE
func die():
	if health <= 0:
		print("Heroi Morreu!!")
		Global.call_deferred("lose_life") #lose_life()
		death_sound.play()
		reset_hero()

# RESPAWN
func reset_hero():
	# reset items
	Global.square = false
	##
	health = max_health
	knockback_time = 0.0
	set_position(start_pos)
	emit_signal("player_respawn")
	print("respawn", health)
	if has_node(monster_path):
		var monster = get_node(monster_path) as Monstro
		monster.reset_pos()
	
