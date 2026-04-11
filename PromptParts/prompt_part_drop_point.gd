class_name PromptPartDropPoint
extends PromptPart

var tags: String # TODO: should consider tags.

func render(offset: int) -> Control:
	var label =  _get_richtext("___", offset)
	label.set_script(load("res://prompt_drop_point.gd"))
	return label


static func create() -> PromptPartDropPoint:
	var res = PromptPartDropPoint.new()
	return res
