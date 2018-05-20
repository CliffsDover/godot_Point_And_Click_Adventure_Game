extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var Game = get_node("/root/Game" )
#onready var Cursor = preload( "res://templates/scenes/Cursor_Crosshair.tscn" ).instance()
var focusedObject

func _ready():
	print( "[Scene_Base] _ready")
	set_process_input( true )
	set_process( true )
	Input.set_mouse_mode( Input.MOUSE_MODE_HIDDEN )
	$HUD/Cursor/Area2D.connect( "area_entered", self, "on_Cursor_area_entered" )
	$HUD/Cursor/Area2D.connect( "area_exited", self, "on_Cursor_area_exited" )
	
func _process(delta):
	$HUD/Cursor.position = get_global_mouse_position()
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:	
		if $HUD.has_node( "ActionMenu" ) and focusedObject:
			if $HUD/ActionMenu.visible:
				if $HUD/ActionMenu.focusedAction:
					# trigger event
					ActionHandler( [ $HUD/ActionMenu.focusedAction, focusedObject.objectName ] )
					$HUD/ActionMenu.visible = false
				else:
					# action canceled
					$HUD/ActionMenu.visible = false
					
				# check if cursor is still overlapping object	
				if not focusedObject.get_node( "Area2D" ).overlaps_area( $HUD/Cursor/Area2D ):
					print( "Set current object to null" )
					focusedObject = null
			else: # show action menu
				$HUD/ActionMenu.position = get_global_mouse_position()
				$HUD/ActionMenu.visible = true
				$HUD/ActionMenu.focusedAction = null
	
	
func on_Cursor_area_entered( area ):
	print( "Current object: " + area.get_parent().objectName )
	focusedObject = area.get_parent()
	
func on_Cursor_area_exited( area ):
	if $HUD.has_node( "ActionMenu" ) and not $HUD/ActionMenu.visible:
		print( "Current object: null" )
		focusedObject = null
		
func ActionHandler( objects ):
	pass

