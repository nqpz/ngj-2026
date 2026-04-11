extends Polygon2D

@export var prompt: Prompt

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	prompt.connect("prompt_finished", darken)

func darken() -> void:
	var d := 0.1
	color.r -= d
	color.g -= d
	color.b -= d
