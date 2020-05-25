extends CanvasLayer

signal statge_select

export var stage1_path = "res://scence/Sections/single_stage1.tscn"
export var stage2_path = "res://scence/Sections/single_stage2.tscn"
export var double_mode_path = "res://scence/Sections/double_stage1.tscn"
export var track_mode_path = "res://scence/Sections/Track_World.tscn"
export var playground_mode_path = "res://scence/Sections/playground_1.tscn"
var stage_button_left = 0
var stage_buttons = [
	"stage1_start",
	"stage2_start"
]

# Called when the node enters the scene tree for the first time.
func _ready():	
	$bgm_player.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_single_start_pressed():
	for bt in $stage_buttons.get_children():
		print(bt.get_name())
		bt.start_move()

func _on_stage1_start_pressed():
	var stage = load((stage1_path))
	get_tree().change_scene_to(stage)
	pass # Replace with function body.

func _on_stage2_start_pressed():
	var stage = load((stage2_path))
	get_tree().change_scene_to(stage)


func _on_quit_pressed():
	get_tree().quit()


func _on_double_start_pressed():
	var double_mode = load((double_mode_path))
	get_tree().change_scene_to(double_mode)

func _on_track_start_pressed():
	var senece = load((track_mode_path))
	get_tree().change_scene_to(senece)
	pass # Replace with function body.


func _on_playground_start_pressed():
	var senece = load((playground_mode_path))
	get_tree().change_scene_to(senece)
	pass # Replace with function body.
