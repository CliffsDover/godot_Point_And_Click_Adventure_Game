extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var Game = get_node("/root/Game" )
#onready var Cursor = preload( "res://templates/scenes/Cursor_Crosshair.tscn" ).instance()

func _ready():
	print( "[Scene_Base] _ready")
	set_process_input( true )
	set_process( true )
	Input.set_mouse_mode( Input.MOUSE_MODE_HIDDEN )
	$HUD/Cursor/Area2D.connect( "area_entered", self, "on_Cursor_area_entered" )
	$HUD/Cursor/Area2D.connect( "area_exited", self, "on_Cursor_area_exited" )
	
func _process(delta):
	$HUD/Cursor.position = get_global_mouse_position()
	
	
func on_Cursor_area_entered( area ):
	print( "Current object: " + area.get_parent().objectName )
	
func on_Cursor_area_exited( area ):
	print( "Current object: null" )

