class_name Drawing
extends Node2D

@export var image: Texture2D

# Should be between 1 and 10
var greyness_level: int = 1

func _ready():
	$Sprite2D.texture = image
	update_color()
	$AnimationPlayer.play("scale")

func step() -> bool:
	# Delete drawing if same color as background.
	if greyness_level + 2 >= Background.greyness_level - 1:
		# Fade out. Once faded out, the animation will call remove() further down.
		$Disappear.play("disappear")
		return false
	else:
		return true

func remove():
	get_parent().remove_child(self)
	queue_free()

func decrease_interaction():
	if greyness_level == 20:
		return
	greyness_level += 2
	update_color()

func update_color():
	var color_val = 0.05*float(greyness_level)
	$Sprite2D.modulate = Color(color_val, color_val, color_val)
