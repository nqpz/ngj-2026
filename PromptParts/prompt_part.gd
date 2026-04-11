class_name PromptPart
extends Control

func render(offset: int) -> Control:
	assert(false, "Implemented by children")
	return Control.new()
	
func _get_richtext(string: String, offset: int) -> RichTextLabel:
	var label = RichTextLabel.new()
	var font : FontFile = load("res://Oregano-Regular.ttf")
	font.set_embolden(0, 0.4)
	label.push_font(font)
	label.push_font_size(24)
	label.push_color(Color(0.2, 0.2, 0.2))
	label.add_text(string)
	label.autowrap_mode = TextServer.AUTOWRAP_OFF
	label.fit_content = true
	label.position = Vector2(offset, 0)
	return label
