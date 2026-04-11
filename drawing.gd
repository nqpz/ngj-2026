class_name Drawing
extends Node2D

@export var image: Texture2D

# Should be between 1 and 10
var greyness_level: int = 1

func _ready():
	$Sprite2D.texture = image
	update_color()

func increase_interaction():
	if(greyness_level == 10):
		return
	greyness_level = greyness_level + 1
	update_color()

func update_color():
	var color_val = 0.1*float(greyness_level)
	$Sprite2D.modulate = Color(color_val, color_val, color_val)
