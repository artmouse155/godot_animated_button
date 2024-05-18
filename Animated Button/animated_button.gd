@tool

extends Control

@onready var anim_player : AnimationPlayer = $AnimationPlayer
@onready var top : Panel = $Control/Control/Top
@onready var text_box : RichTextLabel = $Control/Control/Top/RichTextLabel

@export_multiline var button_text : String = "Animated Button":
	get:
		return button_text
	set(value):
		await ready
		push_warning("text!", name, value)
		text_box.text = value
		propagate_call("update")
		button_text = value

@export var button_color : Color = Color(0.66796875, 0, 0):
	get:
		return button_color
	set(value):
		print("color!", name, value)
		propagate_call("update")
		button_color = value

var disabled : bool = false

var touching_mouse : bool = false
var am_pressed : bool = false

signal pressed

func _ready():
	pass

func mouse_entered_func():
	touching_mouse = true
	if !disabled:
		play_anim("hover")
	
func mouse_exited_func():
	touching_mouse = false
	if !disabled:
		if not am_pressed:
			play_anim("hover_exit")
	
func gui_input_func(ev : InputEvent):
	if ev is InputEventMouseButton:
		am_pressed = ev.pressed
		if !disabled:
			if am_pressed:
				play_anim("pressed")
			else:
				if not touching_mouse:
					play_anim("pressed_and_exit")
				else:
					play_anim("released")
					pressed.emit()

func play_anim(anim_name : String):
	print(anim_name)
	if not (anim_name == anim_player.get_current_animation()):
		anim_player.stop(true)
	anim_player.play(anim_name)

func set_disabled(d : bool = true):
	disabled = d
	if disabled:
		play_anim("pressed")
