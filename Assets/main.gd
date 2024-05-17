extends Node2D

@export var fancy_button : PackedScene

func _ready():
	for i in range(20):
		$GridContainer.add_child(fancy_button.instantiate())
