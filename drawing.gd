class_name Drawing
extends Node2D

@export var image: Texture2D

# Should be between 1 and 10
var greyness_level: int = 1

func _ready():
	greyness_level = (randi() % 3)
	$Sprite2D.texture = image
	update_color()
	$AnimationPlayer.play("scale")

func increase_interaction():
	if greyness_level == 0:
		return
	# Make less grey
	greyness_level -= 1
	# But not greyer than minimum
	if greyness_level < 0:
		greyness_level = 0
	$AnimationPlayer.speed_scale *= 1.1401754251
	update_color()

func decrease_interaction():
	if greyness_level == 20:
		return
	# Make greyer
	greyness_level += 1
	# But not greyer than background
	if greyness_level > Background.greyness_level:
		greyness_level = Background.greyness_level
	$AnimationPlayer.speed_scale /= 1.1401754251
	update_color()

func step() -> bool:
	# Delete drawing if same color as background (the background will be changed with -1 after this).
	if greyness_level >= Background.greyness_level - 1:
		# Fade out. Once faded out, the animation will call remove() further down.
		$Disappear.play("disappear")
		return false
	else:
		return true

func remove():
	get_parent().remove_child(self)
	queue_free()

func update_color():
	var color_val = 0.05*float(greyness_level)
	$Sprite2D.modulate = Color(color_val, color_val, color_val)
