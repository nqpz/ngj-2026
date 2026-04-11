class_name PromptPartString
extends PromptPart

var content: String

func render(offset: int) -> Control:
	return _get_richtext(content, offset)

static func create(content: String) -> PromptPartString:
	var res = PromptPartString.new()
	res.content = content
	return res
