extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var bounce_player_2d = $bouncePlayer2D


export var bouces : int = 1;
var wall_hit_paticle = preload("res://common/effects/wallHit.tscn");

var speed : float = 1000.0
onready var velocity = Vector2(speed, 0).rotated(rotation);
# Called when the node enters the scene tree for the first time.
func _ready():
#	for i in 360:
#		for j in 360:
#			print_debug(velocity.bounce(Vector2(i,j)));
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	move_and_slide(velocity.rotated(rotation))
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		velocity = velocity.bounce(collision.normal)

	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal);
		rotation = velocity.angle();
		bouces -= 1;
		#print_debug("normal: ",  collision.normal,  " v: ", velocity.bounce(collision.normal))		
		if bouces < 0:
			queue_free();
		bounce_player_2d.play();
		var wall_hit = wall_hit_paticle.instance()
		wall_hit.emitting = true;
		wall_hit.position = global_position
		wall_hit.rotation = global_rotation
		get_tree().current_scene.add_child(wall_hit);
