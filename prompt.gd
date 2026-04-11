class_name Prompt
extends Node2D

signal prompt_finished

var prompt_file_name: String = 'res://Prompts/prompts.txt'
var prompt_list: PackedStringArray

@export var testDrawing: Drawing

static var prompt: Prompt

func _ready():
	prompt = self
	read_prompts()
	show_next_prompt()

func read_prompts():
	var f = FileAccess.open(prompt_file_name, FileAccess.READ)
	var text = f.get_as_text()
	prompt_list = text.split("\n")

# Use this when when a drawing is added to the prompt.
func add_drawing(drawing: Drawing):
	# Decrease interaction for all drawings not picked.
	for d in drawing.get_parent().get_children():
		if d.step() and d != drawing:
			d.decrease_interaction()
	if drawing.get_parent() == null:
		# TODO: Fade to black
		pass
	else:
		show_next_prompt()

func show_next_prompt():
	assert(prompt_list.size() > 0, "Prompt list was empty")
	var idx = randi() % prompt_list.size()
	_render_prompt(prompt_list[idx])
	prompt_list.remove_at(idx)
	emit_signal("prompt_finished")
	
func _render_prompt(prompt: String):
	# Remove old children:
	for c in $Node2D.get_children():
		$Node2D.remove_child(c)
		c.queue_free()

	var offset: int = 0
	var prompt_parts = _parse_prompt_string(prompt)
	for pp in prompt_parts:
		var rendered = pp.render(offset)
		$Node2D.add_child(rendered)
		offset = offset + rendered.size.x
	
func _parse_prompt_string(prompt: String) -> Array[PromptPart]:
	var results: Array[PromptPart]
	print(prompt)
	var current_index = 0
	var is_last_part = false

	while true:
		# Get text part:
		var next_index = prompt.find("[", current_index)
		# If we don't find any drop points after this, the text part lasts the rest of the string
		# and we are done after handling that string
		if next_index == -1:
			is_last_part = true
			next_index = prompt.length()
		var text_part = prompt.substr(current_index, next_index - current_index)
		results.append(PromptPartString.create(text_part))
		current_index = next_index
		print("found: ", text_part)

		if is_last_part:
			break

		# Get drop point part:
		next_index = prompt.find("]", current_index) + 1 # include the "]"
		var dp_part = prompt.substr(current_index, next_index - current_index)
		results.append(PromptPartDropPoint.create())
		current_index = next_index
		print("droppointpart ", dp_part)

	return results
