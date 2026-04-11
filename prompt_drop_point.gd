extends Control

@export var prompt: Prompt

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return true

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	# Assume that the first child of the control is the drawing.
	prompt.add_drawing(data.get_child(0))
