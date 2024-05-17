extends Control

@export var anim_player : AnimationPlayer
@export var button_color : Color

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
