extends Spatial

signal win
var winned = false
var all_pick
var remain


# Called when the node enters the scene tree for the first time.
func _ready():
	all_pick = len(get_tree().get_nodes_in_group("pick up"))
	remain = all_pick
	pass # Replace with function body.

func _process(delta):
	if remain != len(get_tree().get_nodes_in_group("pick up")):
		$UI/se/pick.play()
		remain = len(get_tree().get_nodes_in_group("pick up"))
#	var remain = len(get_tree().get_nodes_in_group("pick up"))
	update_UI(all_pick-remain, remain)
	if not winned and get_tree().get_nodes_in_group("pick up") == []:
		winned = true
		emit_signal("win")
	pass

func update_UI(score, remain):
	$UI/score_board.set_text("Score: " + str(score) + "/"  + str(remain))

func _on_UI_quit():
	var start_menu = load("res://start_menu.tscn")
	get_tree().change_scene_to(start_menu)
