extends Control

func _get_drag_data(position):
	var drawing := get_parent().get_child(0).duplicate()
	var scale = 0.6
	drawing.scale = Vector2(scale, scale)
	drawing.position = Vector2(0, 0)
	drawing.rotation = 0.1
	var preview := Control.new()
	preview.add_child(drawing)
	set_drag_preview(preview)
	return self
