extends KinematicBody2D

signal pew_pew_time

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var movement_speed = 150.0
var movement = Vector2.ZERO
var gravity = 120.0
var is_jumping = false

var ammo = 8
const MAX_AMMO = 8
const BURST_SIZE = 1
var jump_force = 5000

var gun_pivot_offset = Vector2(3.0, -3.0)

onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	var horizontal = Input.get_axis("ui_left", "ui_right")
	movement = Vector2(horizontal * movement_speed, gravity)
	if Input.is_action_just_pressed("ui_up"):
		is_jumping = true
		
	if Input.is_action_just_pressed("ui_select"):
		start_shooting()

func start_shooting():
	if ammo <= 0:
		reload()
		yield(animation, "animation_finished")
	
	animation.queue("recoil")
	ammo -= 1
	
func reload():
	animation.play("reload")
	ammo = MAX_AMMO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if is_jumping and is_on_floor():
		movement.y = -jump_force
		is_jumping = false
	move_and_slide(movement, Vector2(0, -1))
