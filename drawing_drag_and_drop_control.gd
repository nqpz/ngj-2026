extends Control

func _get_drag_data(position):
	# The sprite is always the first child.
	var sprite2d := get_parent().get_child(0).duplicate()
	var s := 0.6
	sprite2d.scale = Vector2(s, s)
	sprite2d.position = Vector2(0, 0)
	sprite2d.rotation = 0.1
	var preview := Control.new()
	preview.add_child(sprite2d)
	set_drag_preview(preview)
	return self

var is_entered := false
var is_pressed := false
static var has_played := false

func check():
	if is_entered and is_pressed and !has_played:
		has_played = true
		get_parent().get_node("ClickSound").play()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		is_pressed = event.pressed
		if is_pressed:
			check()
		else:
			has_played = false

func _on_mouse_entered() -> void:
	is_entered = true
	check()

func _on_mouse_exited() -> void:
	is_entered = false
