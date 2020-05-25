extends Spatial
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var length =0
export var velocity =0.0
export var angle = 0 
var t
# Called when the node enters the scene tree for the first time.
func _ready():
	t=0
	var children = $Hammer.get_children()
	children[0].set_translation(Vector3(0,-length,0))
	children[1].set_translation(Vector3(0,-length,0))
	children[2].set_translation(Vector3(0,-length/2,0))
	children[2].set_scale(Vector3(0.1,length/2,0.1))
	var trans = $Hammer.get_translation()
	trans.y += length-12
	$Hammer.set_translation(trans)
	pass # Replace with function body.
func _process(delta):
	$Hammer.set_rotation(Vector3(cos(t)*PI*angle/180,0,0))
	t+=delta*velocity
