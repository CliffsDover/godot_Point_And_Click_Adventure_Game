extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var focusedAction

func _ready():
	print( "[ActionMenu_Base] _ready")
	Hide()
	#connect( "signal_mouseEnteredActionMenuItem", self, "on_mouseEnteredActionMenuItem", [ actionName ] )
	
#func _input(event):
func _process( delta ):
	#print( "input" )
	focusedAction = null
	for item in get_children():
		#print( "!!!" + owner.get_node( "HUD/Cursor/Area2D" ).name )
		if item.get_node( "Area2D" ).overlaps_area( owner.get_node( "HUD/Cursor/Area2D" ) ):
			#print( "[ActionMenu_Base] "  + item.actionName )
			focusedAction = item.actionName	
			item.SetState( 1 )
		else:
			item.SetState( 0 )
			
	if focusedAction:
		owner.SetInfoText( focusedAction + " " + owner.focusedObject.objectName ) 
	else:
		owner.SetInfoText( owner.focusedObject.objectName ) 

func _on_mouseEnteredActionMenuItem(actionName):
	return
	#print( "[_on_mouseEnteredActionMenuItem] " + actionName )
	#print( get_parent() )
	#owner.SetInfoText( actionName + " " + owner.focusedObject.objectName ) 
	#focusedAction = actionName
	
	
func _on_mouseExitedActionMenuItem(actionName):
	return
	#print( "[_on_mouseExitedActionMenuItem]" + actionName )
	#if owner.focusedObject:
	#	owner.SetInfoText( owner.focusedObject.objectName ) 
	#focusedAction = null
	
func Show():
	set_process( true )
	for item in get_children():
		item.visible = true
		item.get_node( "Area2D" ).monitorable = true
	visible = true
	
func Hide():
	set_process( false )	
	for item in get_children():
		item.visible = false
		item.get_node( "Area2D" ).monitorable = false		
	visible = false