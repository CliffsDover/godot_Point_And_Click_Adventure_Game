extends "res://templates/scenes/Scene_Base.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#onready var Game = get_node("/root/Game" )
#onready var Cursor = preload( "res://templates/scenes/Cursor_Crosshair.tscn" ).instance()


func _ready():
	pass
	#print( "[Scene_Test_1] _ready")
	#print( Game.GetAllVerbs() )
	#set_process_input( true )
	
func ActionHandler( objects ):
	print( "[ActionHandler]" )
	print( objects[0] )
	print( objects[1] )


func CursorClickedAt( pos ):
	print( "[CursorClickedAt]" )
	print( pos )
