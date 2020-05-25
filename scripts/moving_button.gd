extends Button
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var start = 0
export var end = 0
export var time = 1.0
var move = false

# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_position.x = start


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var distance = end-start

	if move:
		self.rect_position.x += delta*(end-start)/time
	if abs(self.rect_position.x-start) >= abs(distance):
		self.rect_position.x = end
		move = false

func reset():
	self.rect_position.x = start

func _on_Timer_timeout():
	move = true

func start_move():
	$Timer.start()
