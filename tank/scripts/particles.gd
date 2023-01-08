extends Particles2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.


func _ready():
	var dieTimer := Timer.new();
	add_child(dieTimer)
	dieTimer.connect("timeout", self,"die")
	dieTimer.wait_time = 1.0
	dieTimer.start();
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	#if emitting == false:
	pass
	
func die():
	queue_free();

