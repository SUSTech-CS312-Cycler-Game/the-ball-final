
extends RigidBody

# Display this member variable in the editor UI so game 
# designers can tweak player speed without changing source
# code
export var speed = 10
export var jumpable = false
export var jump_force = 200
export var power = 100
export var frac_val = 5

signal out
signal jump

# pick up counter
var count
# UI labels
var counter
var winner
# Support mouse/touch-screen input
var x_max
var y_max
var X = 0
var Y = 1

# A default position to apply forces
var position = Vector3(0, 0, 0)

var initial_position 
func _ready():
	# When this node enters the scene, start calling its
	# _fixed_process() method for physics logic
#    set_fixed_process(true)
	initial_position = get_translation()
	set_physics_process(true)
	# Initialize count
	count = 0
	# Get labels
#	counter = get_node("/root/World/Counter")
#	winner = get_node("/root/World/Winner")
	# Update labels
#	update_ui()
	# Get screen size
	var camera = get_node("../Camera")
	var rect = camera.get_viewport().get_visible_rect()
	x_max = rect.size[X]
	y_max = rect.size[Y]

func _physics_process(delta):
	# Get the direction that the user wants to move
	# in for x and z directions.
#	print(get_linear_velocity().length())
	var x = get_axis("horizontal") # left/right
	var z = get_axis("vertical")   # forward/back
	# Build a unit direction vector based on the user
	# input we received
	var direction = Vector3(x, 0, z).normalized()

	var v = get_linear_velocity().length()

	var v_unit = get_linear_velocity().normalized()
	var fraction = -frac_val*v_unit
	fraction[1] = 0

	if v_unit[1] > 0.1:
		fraction = Vector3(0, 0, 0)
	var force = power / (v+power/200.0)

	# Scale the magnitude of the applied force, for this
	# frame, by the time required to draw a frame.
	var magnitude =  speed * delta
	jump(delta)

	ball_add_force((force * direction + fraction)*delta)
	out_world()
	
func out_world():
	if get_translation()[1] < -150:
		emit_signal("out")
		set_translation(initial_position)
		set_linear_velocity(Vector3(0,0,0))
		set_angular_velocity(Vector3(0,0,0))

func jump(delta):
	if jumpable && Input.is_action_just_pressed("ball_jump"):
		jumpable = false
		apply_impulse(position,Vector3(0,jump_force*delta,0))
		emit_signal("jump")

func get_axis(axis):

	# Handle left/right movement
	if axis == "horizontal":
		# When 'left-arrow' key is pressed,
		# return a negative value.
		if Input.is_action_pressed("ui_left"):
		   return -1.0
		# When 'right-arrow' key is pressed,
		# return a positive value.
		elif Input.is_action_pressed("ui_right"):
		   return 1.0
	# Handle forward/back movement
	elif axis == "vertical":
		# When 'up-arrow' key is pressed,
		# return a negative value.
		if Input.is_action_pressed("ui_up"):
		   return -1.0
		# When 'down-arrow' key is pressed,
		# return a positive value.
		elif Input.is_action_pressed("ui_down"):
		   return 1.0
	return 0.0

func ball_add_force(force):
	# Wake up the player physics, if it is asleep 
	# and a force is being applied on any one of 
	# the three (X, Y, or Z) axis. 
	var x = force[0] 
	var y = force[1]
	var z = force[2]
	if (x or y or z) and is_sleeping():
		set_sleeping(false) # Wake up!
	# Apply the given force vector (at the default
	# position)
	apply_impulse(position,  force)

#func update_ui():
#	get_parent().get_node("UI/score_board").set_text("Score: " + str(count) )


func _on_Player_body_entered(body):
	if body.is_in_group("pick up"):
		body.hide()
		body.remove_from_group("pick up")
		body.free()
		count = count+1
#		update_ui()
	elif body.is_in_group("jumpable_plane"):
		jumpable = true
