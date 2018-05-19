extends "res://templates/scenes/Scene_Base.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#onready var Game = get_node("/root/Game" )
#onready var Cursor = preload( "res://templates/scenes/Cursor_Crosshair.tscn" ).instance()

func _ready():
	print( "[Scene_Test_1] _ready")
	print( Game.GetAllVerbs() )
	

