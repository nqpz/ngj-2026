extends Polygon2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func darken() -> void:
	var d = 0.1
	color.r -= d
	color.g -= d
	color.b -= d

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	# DEBUG
	# if Input.is_key_pressed(KEY_SPACE):
	# 	darken()
