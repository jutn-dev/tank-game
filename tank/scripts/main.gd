extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var level_instace
onready var fps = $CanvasLayer/fps

# Called when the node enters the scene tree for the first time.
func _ready():
	load_level("level1")	
	Engine.set_target_fps(10000000);
	print_debug(Engine.get_target_fps())
	pass # Replace with function body.


func unload_level():
	if is_instance_valid(level_instace):
		level_instace.queue_free();
	level_instace = null
	
func load_level(level: String):
	unload_level();
	var level_path := "res://levels/" + level + ".tscn";
	print(level_path);
	var level_resource = load(level_path);
	if level_resource:
		level_instace = level_resource.instance();
		add_child(level_instace);
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("reload_level"):
		load_level("level1")
	fps.text = str(Engine.get_frames_per_second());
	if level_instace.get_node("enemies").get_child_count() == 0:
		Global.winText.visible = true;
		
	pass
