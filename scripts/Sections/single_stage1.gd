#extends Spatial
#
#signal win
#var winned = false
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass # Replace with function body.
#
#
#func _process(delta):
#	if not winned and get_tree().get_nodes_in_group("pick up") == []:
#		winned = true
#		emit_signal("win")
#	pass
#
#func update_UI(score, remain):
#	$UI/score_board.set_text("Score: " + str(score) + "/"  + str(remain))
#
#func _on_UI_quit():
#	var start_menu = load("res://start_menu.tscn")
#	get_tree().change_scene_to(start_menu)
