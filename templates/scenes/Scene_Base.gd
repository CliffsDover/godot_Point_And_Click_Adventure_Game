extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
onready var Game = get_node("/root/Game" )
#onready var Cursor = preload( "res://templates/scenes/Cursor_Crosshair.tscn" ).instance()
var focusedObject

onready var TextInterfaceEngine = $HUD/Dialogs/TextInterfaceEngine

func _ready():
	print( "[Scene_Base] _ready")
	set_process_input( true )
	set_process( true )
	Input.set_mouse_mode( Input.MOUSE_MODE_HIDDEN )
	$HUD/Cursor/Area2D.connect( "area_entered", self, "on_Cursor_area_entered" )
	$HUD/Cursor/Area2D.connect( "area_exited", self, "on_Cursor_area_exited" )
	#$HUD/ActionMenu.Hide()
	#print( $HUD/ActionMenu/ActionMenuItem_LookAt.position ) 
	
func _process(delta):
	$HUD/Cursor.position = get_global_mouse_position()
	
func _input(event):
	if event is InputEventMouseButton and event.pressed:	
		if $HUD.has_node( "ActionMenu" ) and focusedObject:
			if $HUD/ActionMenu.visible:
				if $HUD/ActionMenu.focusedAction:
					# trigger event
					ActionHandler( [ $HUD/ActionMenu.focusedAction, focusedObject ] )
					$HUD/ActionMenu.Hide()			
				else:
					# action canceled
					$HUD/ActionMenu.Hide()
					
				# check if cursor is still overlapping object	
				if focusedObject.get_node( "Area2D" ).overlaps_area( $HUD/Cursor/Area2D ):
					SetInfoText( focusedObject.objectName )
				else:
					#print( "Set current object to null" )
					focusedObject = null
					ShowInfoBar( false )
			else: # show action menu
				var verbs = focusedObject.getAvailableVerbs()
				#$HUD/ActionMenu.position = get_global_mouse_position()
				#$HUD/ActionMenu.visible = true
				$HUD/ActionMenu.focusedAction = null
				$HUD/ActionMenu.Show( verbs )
		else:
			CursorClickedAt( get_global_mouse_position() )
	
	
func on_Cursor_area_entered( area ):
	if $HUD.has_node( "ActionMenu" ) and not $HUD/ActionMenu.visible:
		print( "Current object: " + area.get_parent().name )
		focusedObject = area.get_parent()
		if not IsInfoBarShown():
			SetInfoText( focusedObject.objectName )
			ShowInfoBar( true )
		#SetInfoText( area.get_parent().objectName )
	
func on_Cursor_area_exited( area ):
	if $HUD.has_node( "ActionMenu" ) and not $HUD/ActionMenu.visible:
		print( "Current object: null" )
		focusedObject = null
		ShowInfoBar( false )
		
func ActionHandler( objects ):
	pass
	
func CursorClickedAt( pos ):
	pass
	
func SetInfoText( text ):
	$HUD/InfoBar/CenterContainer/InfoText.text = text

func ShowInfoBar( isVisible ):
	$HUD/InfoBar.visible = isVisible
	
func IsInfoBarShown():
	return $HUD/InfoBar.visible 
	
func GetDialogBox( pos ):
	var tie = TextInterfaceEngine.duplicate()
	print( tie )
	tie.rect_position = pos
	tie.rect_size = Vector2( 1024, 64 )
	$HUD/Dialogs.add_child( tie )
	return tie
	
func RemoveDialogBox( tie ):
	$HUD/Dialogs.remove_child( tie )
	tie.queue_free() 
