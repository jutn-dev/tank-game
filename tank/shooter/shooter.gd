extends KinematicBody2D
class_name Shooter

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var shoot_time = 0.5;
export(int) var bullet_amount = 1;

var can_shoot: bool = true;

onready var shoot_point: Node = $gun/Sprite/shootPoint
var bullet = preload("res://scenes/bullet.tscn")
onready var bullets = $"%bullets"
onready var gun = $gun
onready var shoot_particles_2d = $gun/Sprite/shootPoint/shootParticles2D
onready var shoot_player = $shootPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot():
	can_shoot = false;
	for i in bullet_amount:
		var bullet_instance = bullet.instance();
		bullet_instance.global_position = shoot_point.get_global_position();
		bullet_instance.global_rotation = shoot_point.get_global_rotation();
		bullets.add_child(bullet_instance);
	shoot_player.play();
	shoot_particles_2d.emitting = true;
	yield(get_tree().create_timer(shoot_time), "timeout");
	can_shoot = true;

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
