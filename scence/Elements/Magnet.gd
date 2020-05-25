extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var Force = 10
export var distance_scale = 0.05
# Called when the node enters the scene tree for the first time.
func _ready():
	$Field.gravity = Force
	$Field.gravity_distance_scale = distance_scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
