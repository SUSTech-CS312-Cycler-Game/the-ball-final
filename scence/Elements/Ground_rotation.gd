extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var angle = 15
var t=0
var velocity = 0.5
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
func _process(delta):
	set_rotation(Vector3(angle*cos(t)*PI/180,0,angle*sin(t)*PI/180) )
	t+=delta*velocity

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
