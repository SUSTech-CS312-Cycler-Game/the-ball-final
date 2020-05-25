extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var player = null
export var transform_velocity = 1
# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	$Area.gravity_vec=get_global_transform().basis.x*transform_velocity
	var material:SpatialMaterial
	material = $conveyor.get_surface_material(0) as SpatialMaterial
	var texture:AnimatedTexture
	texture = material.albedo_texture as AnimatedTexture
	texture.fps = 3*transform_velocity
