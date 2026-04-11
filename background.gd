class_name Background
extends Polygon2D

@export var prompt: Prompt

# Should be between 1 and 10
static var greyness_level: int = 20

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prompt.connect("prompt_finished", darken)

func darken() -> void:
	greyness_level -= 1
	update_color()
	if greyness_level == 0:
		get_node("../Background/FadeOutTimer").stop()
		prompt.show_text_from_file(Prompt.epilogue_file_name)

func update_color() -> void:
	var color_val := 0.05*float(greyness_level)
	color = Color(color_val, color_val, color_val)
