extends Spatial

signal win(id)
var winned = false
var all_pick
var p1 = 0
var p2 = 0
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
	update_UI(p1, p2, remain)
	if not winned and get_tree().get_nodes_in_group("pick up") == []:
		winned = true
		if p1 > p2:
			emit_signal("win", 1)
		else:
			emit_signal("win", 2)


func update_UI(p1, p2, remain):
	$UI/p1_score.set_text("P1: %d" % p1)
	$UI/p2_score.set_text("P2: %d" % p2)
	$UI/remain.set_text("Remain: "  + str(remain))

func _on_UI_quit():
	var start_menu = load("res://start_menu.tscn")
	get_tree().change_scene_to(start_menu)

func _on_Player1_points(val):
	p1 = val

func _on_Player2_points(val):
	p2 = val




