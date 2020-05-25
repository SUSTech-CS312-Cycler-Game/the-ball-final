extends CanvasLayer

signal quit
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pausing
var music_position
var current_state
var time = 0.0
var winned = false
var left

func _process(delta):
	if not pausing and not winned:
		time += delta
		if time >= 60:
			var minutes = int(time) / 60
			var seconds = int(time) % 60
			$time_board.set_text("Time: %dm" % minutes + "%ds" % seconds)
		else:
			$time_board.set_text("Time: %.1fs" % time)
	pass

func _ready():
	pausing = false
	time = 0.0
	winned = false
	self.pause_mode = Node.PAUSE_MODE_PROCESS
	if not get_parent().editor_description.length() < 2:
		$buttons_after_win/next_button.visible = false
		$buttons_after_win/next_button.disabled = true
	$bgm_player.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			on_pause()

func on_pause():
	if not pausing:
		pausing = true
		music_position = $bgm_player.get_playback_position()
		$bgm_player.stop()
		$se/pause.play()
		get_tree().set_pause(true)
		for bt in $pausing_buttons.get_children():
			bt.start()
	else:
		pausing = false
		get_tree().set_pause(false)
		for bt in $pausing_buttons.get_children():
			bt.reset()
		$bgm_player.play(music_position)

func back_to_menu():
	get_tree().set_pause(false)
	emit_signal("quit")

func _on_World_win():
	$se/win.play()
	$win_info.visible = true
	winned = true
	for bt in $buttons_after_win.get_children():
		bt.start_move()
#	save_progress()

func _on_next_button_pressed():
	var stage = int(get_parent().editor_description)
	if stage < 2:
		var next_scence = load("res://scence/Sections/single_stage%d.tscn" % (stage+1))
		get_tree().change_scene_to(next_scence)

func _on_continue_pressed():
	on_pause()
	pass # Replace with function body.


func restart_game():
	on_pause()
	var scence
	if get_parent().editor_description.length() < 2:
		var stage = int(get_parent().editor_description)
		scence = load("res://scence/Sections/single_stage%d.tscn" % stage)
	else:
		scence = load("res://scence/Sections/%s.tscn" % get_parent().editor_description)
	get_tree().change_scene_to(scence)
	pass # Replace with function body.


func _on_Player_out():
	$se/out.play()
	pass # Replace with function body.


func _on_Player_jump():
	$se/jump.play()
	pass # Replace with function body.


func _on_Brick_distroy():
	$se/break.play()
	pass # Replace with function body.
