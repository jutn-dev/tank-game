extends "res://shooter/shooter.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var look_distance: float = 1000.0;

onready var target_path_timer = $newTargetPathTimer
onready var navigation_agent_2d = $NavigationAgent2D

onready var explosion_particle = preload("res://common/effects/explosion.tscn");
onready var player = $"%tank"



# Called when the node enters the scene tree for the first time.
func _ready():
	bullet = preload("res://scenes/enemy_bullet.tscn");
	navigation_agent_2d.set_target_location(global_position);		
	#navigation_agent_2d.set_target_location(player.global_position);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if global_position.distance_to(player.global_position) < look_distance:	
		if (can_shoot):
			shoot();
	
	gun.look_at(player.global_position)
	
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


func _on_Area2d_body_exited(body):
	if body.is_in_group("hurt_enemy"):
		var explosion = explosion_particle.instance()
		explosion.position = global_position;
		explosion.emitting = true;
		get_tree().current_scene.add_child(explosion)
		
		queue_free();
	pass # Replace with function body.
