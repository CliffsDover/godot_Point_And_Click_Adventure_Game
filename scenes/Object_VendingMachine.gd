extends "res://templates/scenes/Object_Base.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func getAvailableVerbs():
	return [ "Look At", "Walk To", "Use" ]
