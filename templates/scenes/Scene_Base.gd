extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var Game = get_node("/root/Game" )
onready var Cursor = preload( "res://templates/scenes/Cursor_Crosshair.tscn" ).instance()

func _ready():
	set_process_input( true )
	set_process( true )
	Input.set_mouse_mode( Input.MOUSE_MODE_HIDDEN )
	add_child( Cursor )
	print( Game.GetAllVerbs() )

func _process(delta):
	$Cursor.position = get_global_mouse_position()
