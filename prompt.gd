class_name Prompt
extends Node2D

signal prompt_finished

var prompt_file_name: String = 'res://Prompts/prompts.txt'
var prompt_list: PackedStringArray

@export var testDrawing: Drawing

func _ready():
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
		if d != drawing:
			d.decrease_interaction()
	show_next_prompt()

func show_next_prompt():
	assert(prompt_list.size() > 0, "Prompt list was empty")
	var idx = randi() % prompt_list.size()
	$RichTextLabel.text = prompt_list[idx]
	prompt_list.remove_at(idx)
	emit_signal("prompt_finished")
