extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var time = 0.3
export var min_scale = 0.5
export var max_scale = 1.2
var phase = -1	# -1: hiding, 0: stop, 1: enlarging, 2:shrinking
var increment
var original_rect
# Called when the node enters the scene tree for the first time.
func _ready():
	original_rect = self.get_rect()
	increment = (2*max_scale - min_scale-1)/time
	self.visible = false
	self.set_scale(Vector2(min_scale, min_scale))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var scale = self.get_scale()
	if phase == 1:
		if self.get_scale().x < max_scale:
			scale += Vector2(increment, increment)*delta
			self.set_scale(Vector2(scale))
			self.find_place()
		else:
			self.set_scale(Vector2(max_scale, max_scale))
			phase = 2
			self.find_place()
	elif phase == 2:
		if self.get_scale().x > 1.0:
			scale -= Vector2(increment, increment)*delta
			self.set_scale(Vector2(scale))
			self.find_place()
		else:
			self.set_scale(Vector2(1, 1))
			phase = 0
			self.find_place()

func find_place():
	var movement = (1-self.get_scale().x) * original_rect.position
	self.rect_position = original_rect.position + movement
	

func start():
	phase = 1
	self.visible = true
	self.disabled = false
	self.set_scale(Vector2(min_scale, min_scale))

func reset():
	self.visible = false
	self.disabled = true
	self.set_scale(Vector2(min_scale, min_scale))

func _on_Timer_timeout():
	start()
	pass # Replace with function body.
