extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var shoot_time: float = 1.0;
export var look_distance: float = 1000.0;

onready var target_path_timer = $newTargetPathTimer
onready var navigation_agent_2d = $NavigationAgent2D


var bullet = preload("res://scenes/enemy_bullet.tscn");
onready var shoot_point = $shootPoint
onready var bullets = $"%bullets"
onready var explosion_particle = preload("res://common/effects/explosion.tscn")
onready var player = $"%tank"

var can_shoot : bool = true;

# Called when the node enters the scene tree for the first time.
func _ready():
	navigation_agent_2d.set_target_location(global_position);		
	#navigation_agent_2d.set_target_location(player.global_position);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.distance_to(player.global_position) < look_distance:	
		if (can_shoot):
			shoot();
	pass
	
	
func _physics_process(delta):
	if navigation_agent_2d.is_navigation_finished():
		return;
	#navigation_agent_2d.set_target_location(tank.global_position);
	var direction = global_position.direction_to(navigation_agent_2d.get_next_location());
	var velocity = direction * navigation_agent_2d.max_speed;
	move_and_slide(velocity);
	rotation = lerp_angle(rotation, direction.angle(), 0.1);
	
	for i in get_slide_count():
		var collision = get_slide_collision(i);
	pass



func _on_TargetPathTimer_timeout():
	if global_position.distance_to(player.global_position) < look_distance:	
		navigation_agent_2d.set_target_location(player.global_position);	
	pass # Replace with function body.


func shoot():
	can_shoot = false;
	var rng = RandomNumberGenerator.new()
	for i in 50:
		var bullet_instance = bullet.instance();
		bullet_instance.global_position = shoot_point.get_global_position();
		bullet_instance.global_rotation = rng.randf_range(0, 359)
		bullets.add_child(bullet_instance);
	yield(get_tree().create_timer(shoot_time), "timeout");
	can_shoot = true;





func _on_Area2d_body_entered(body):
	
	if body.is_in_group("hurt_enemy"):
		var explosion = explosion_particle.instance()
		explosion.position = global_position;
		explosion.emitting = true;
		get_tree().current_scene.add_child(explosion)
		
		queue_free();
	pass # Replace with function body.
