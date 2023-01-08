extends Position2D

onready var parent = $"..";
onready var offset = $offset
onready var offset_start_pos = offset.position;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#not sure what to call this variable its mouse position form -1 to 1
	var mousePosNorm = (get_viewport().get_mouse_position() - (get_viewport_rect().size / 2)) / get_viewport_rect().size * 2
	offset.position = mousePosNorm * 75
	rotation = 0;

	
#	print_debug(get_viewport().get_mouse_position().normalized().angle());
	
	
#	if(parent.look_direction == Vector2.ZERO):
#		offset.position = Vector2.ZERO;
#	else:
#		rotation = parent.look_direction.angle();
#		offset.position = offset_start_pos;
