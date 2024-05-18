extends Node2D

@export var fancy_button : PackedScene

func _ready():
	for i in range(20):
		var hue = randf()  # Random hue between 0 and 1
		var saturation = randf()  # Random saturation between 0 and 1
		
		var b = fancy_button.instantiate()
		$GridContainer.add_child(b)
		b.button_color = Color.from_hsv(hue, saturation, .6)
		b.update_button_color()
		b.button_text = "Click to disable!"
		b.update_text()
		b.pressed.connect(b.set.bind("disabled", true))
		

func _input(_event):
	if Input.is_key_pressed(KEY_SPACE):
		$AnimatedButton.disabled = true
	if Input.is_key_pressed(KEY_K):
		$AnimatedButton.disabled = false

func quit_game():
	get_tree().quit()
