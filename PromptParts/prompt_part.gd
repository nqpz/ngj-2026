class_name PromptPart
extends Node

func render(offset: int) -> Control:
	assert(false, "Implemented by children")
	return Control.new()
	
func _get_richtext(string: String, offset: int) -> RichTextLabel:
	var label = RichTextLabel.new()
	label.push_color(Color(0.5, 0.5, 0.5))
	label.add_text(string)
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.fit_content = true
	label.position = Vector2(offset, 0)
	return label
