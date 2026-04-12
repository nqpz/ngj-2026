extends Control

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(at_position: Vector2, data: Variant) -> void:
	var drawing = data.get_parent() as Drawing
	if drawing:
		drawing.position = at_position + drawing.image.get_size() * 0.3
