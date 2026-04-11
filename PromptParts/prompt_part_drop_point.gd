class_name PromptPartDropPoint
extends PromptPart

var tags: String # TODO: should consider tags.
var background: TextureRect

func render(offset: int) -> Control:
	background = DropableTextureRect.new()
	background.texture = load('res://drop_point_background.png')
	background.position = Vector2(offset, -10)
	background.stretch_mode = TextureRect.STRETCH_SCALE
	background.expand_mode = TextureRect.EXPAND_KEEP_SIZE
	return background

func setDrawing(drawing: Drawing):
	background.texture = drawing.image

static func create() -> PromptPartDropPoint:
	var res = PromptPartDropPoint.new()
	return res
