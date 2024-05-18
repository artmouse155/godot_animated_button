extends Node2D

@export var fancy_button : PackedScene

func _ready():
	return 0
	for i in range(20):
		$GridContainer.add_child(fancy_button.instantiate())
