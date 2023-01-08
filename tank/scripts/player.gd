extends "res://shooter/shooter.gd"


#export(float) var ok = 1;
export var speed : float = 400;
#onready var shoot_player = $shootPlayer

#onready var gun = $gun
#onready var shoot_point = $gun/Sprite/shootPoint
#var bullet = preload("res://scenes/bullet.tscn")
#onready var bullets = Global.bullets
#onready var shoot_particles_2d = $gun/Sprite/shootPoint/shootParticles2D

var explosion_effect = preload("res://common/effects/explosion.tscn");
onready var sprite = $sprite

#var can_shoot = true;
var look_direction : Vector2;
var is_dead : bool = false
var velocity: Vector2;
var next_rotation: float;
# Called when the node enters the scene tree for the first time.
func _ready():
	gun = $sprite/gun;
	shoot_point = $sprite/gun/Sprite/shootPoint
	shoot_particles_2d = $sprite/gun/Sprite/shootPoint/shootParticles2D
	pass	

func _physics_process(delta):
	if is_dead:
		return;
	var input : Vector2;
	input.x = Input.get_axis("left", "right");
	input.y = Input.get_axis("up", "down");
	velocity = input.normalized();
	move_and_slide(velocity.normalized() * speed);

	if input != Vector2.ZERO:
		look_direction = input;
	

	next_rotation = lerp_angle(rotation,look_direction.angle(), 5 * delta);
	global_rotation = next_rotation;

func _process(delta):
	if is_dead:
		return;
	gun.look_at(get_global_mouse_position());
	if(Input.is_action_pressed("fire_bullet") && can_shoot):	
		shoot();
		
		
		
	var fps = Engine.get_frames_per_second();
	var Position_lerp_interval = velocity / fps;
	var lerp_position = global_position + Position_lerp_interval;
	
	var Rotation_lerp_interval = next_rotation / fps;
	var lerp_Rotation = global_rotation + Rotation_lerp_interval;	

	
	if fps > Engine.iterations_per_second:
		print_debug("high fps");
		sprite.set_as_toplevel(true);
		sprite.global_rotation = lerp_angle(sprite.global_rotation, lerp_Rotation + deg2rad(90), 50 * delta);
		sprite.global_scale = global_scale;
		sprite.global_position = sprite.global_position.linear_interpolate(lerp_position, 50 * delta);
	else:
		sprite.global_position = global_position
		sprite.set_as_toplevel(false);


func _on_bulletDetector_body_entered(body):
	if body.is_in_group("player_hurt") && !is_dead:
		is_dead = true;
		visible = false;
		sprite.set_as_toplevel(false);
		$CollisionShape2D.disabled = true;
		$bulletDetector/CollisionShape2D.disabled = true;
		var explosion = explosion_effect.instance()
		explosion.position = global_position;
		explosion.emitting = true;
		get_tree().current_scene.add_child(explosion)
	pass # Replace with function body.
