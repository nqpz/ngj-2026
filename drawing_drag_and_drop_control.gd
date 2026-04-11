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
