class_name Background
extends Polygon2D

@export var prompt: Prompt

# Should be between 1 and 10
static var greyness_level: int = 10

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prompt.connect("prompt_finished", darken)

func darken() -> void:
	greyness_level -= 1
	update_color()

func update_color() -> void:
	var color_val := 0.1*float(greyness_level)
	color = Color(color_val, color_val, color_val)
