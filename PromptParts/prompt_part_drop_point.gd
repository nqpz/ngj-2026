class_name PromptPartDropPoint
extends PromptPart

var tags: String # TODO: should consider tags.

func render(offset: int) -> Control:
	return _get_richtext("___", offset)


static func create() -> PromptPartDropPoint:
	var res = PromptPartDropPoint.new()
	return res
