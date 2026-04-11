class_name DropableTextureRect
extends TextureRect

var was_changed: bool = false

func _can_drop_data(_at_position: Vector2, _data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var drawing: Drawing = data.get_parent()
	texture = drawing.image
	was_changed = true
	modulate = Color.BLACK
	Prompt.prompt.add_drawing(drawing)
