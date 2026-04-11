class_name Prompt
extends Node2D

signal prompt_finished

static var prompt_file_name: String = 'res://Prompts/prompts.txt'
static var prologue_file_name: String = "res://Prompts/prologue.txt"
static var epilogue_file_name: String = 'res://Prompts/epilogue.txt'
var prompt_list: PackedStringArray

var message_queue = null
var current_message_timer: float = 9999999
var message_time: float = 6

@export var drawings: Node2D
@export var tutorial_things: Node2D

static var prompt: Prompt

func _ready():
	prompt = self
	read_prompts()
	_show_tutorial()

func _show_tutorial():
	print("hiding")
	drawings.hide()
	_render_prompt("I feel my [] stopping.")

func _show_real_scene():
	drawings.show()
	tutorial_things.hide()
	show_text_from_file(prologue_file_name)

func _process(delta):
	if message_queue == null:
		return
	current_message_timer += delta
	if current_message_timer >= message_time:
		current_message_timer = 0
		if  message_queue.size() > 0:
			_render_prompt(message_queue[0])
			message_queue.remove_at(0)
		else:
			show_next_prompt()
			message_queue = null

func read_prompts():
	var f = FileAccess.open(prompt_file_name, FileAccess.READ)
	var text = f.get_as_text()
	prompt_list = text.split("\n", false)

func show_text_from_file(file_name: String):
	current_message_timer = 999999999 # Certainly above max time, so we render immediately
	var f = FileAccess.open(file_name, FileAccess.READ)
	var text = f.get_as_text()
	message_queue = text.split("\n", false)

# Keep track to keep the used drawings the same color
var drawings_used_for_current_prompt := []

# Use this when when a drawing is added to the prompt.
func add_drawing(drawing: Drawing):
	drawings_used_for_current_prompt.append(drawing)
	if !_all_drop_points_are_filled():
		return
	# Decrease interaction for all drawings not picked.
	var all_deleted = true

	for maybe_drawing in drawing.get_parent().get_children():
		var d := maybe_drawing as Drawing
		if d && d.step():
			if d not in drawings_used_for_current_prompt:
				d.decrease_interaction()
			# At least one drawing still exists, so we're not quite done yet.
			all_deleted = false
	# Reset for next prompt
	drawings_used_for_current_prompt = []
	if all_deleted:
		get_node("../Background/FadeOutTimer").start()
	else:
		$AnimationPlayer.play("fade_out") # Animation calls show_next_prompt()

func show_next_prompt():
	assert(prompt_list.size() > 0, "Prompt list was empty")
	# If we wan't so show the next prompt, but "drawings" are hidden, it means that we are in the
	# tutorial level (the only time drawings are not visible) and that the user has finished the
	# tutorial prompt. In that case we need to go to the real scene:
	# (Yes, this is the best place to tranistion from tutorial to real)
	if !drawings.visible:
		_show_real_scene()
	var idx = randi() % prompt_list.size()
	_render_prompt(prompt_list[idx])
	$AnimationPlayer.play("fade_in")
	prompt_list.remove_at(idx)
	emit_signal("prompt_finished")

func _all_drop_points_are_filled() -> bool:
	for c in $Node2D.get_children():
		var image := c as DropableTextureRect
		if image && !image.was_changed:
			return false
	return true

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
