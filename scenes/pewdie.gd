extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movement = Vector2.ZERO
var gravity = 160.0

var is_dead = false

onready var progress = $ProgressBar
var health = 1000.0
const MAX_HEALTH = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	if is_dead:
		return
		
	if !is_on_floor():
		movement.y = gravity
	
	move_and_slide(movement, Vector2(0, -1))
	
func throw_pie(player):
	var throw = self.position - player.position

func take_damage(damage_amount):
	if is_dead:
		return
		
	health -= damage_amount
	progress.value = health/MAX_HEALTH
	if health <= 0.0:
		die()

func die():
	$Sprite.hide()
	$DeathParticles.restart()
