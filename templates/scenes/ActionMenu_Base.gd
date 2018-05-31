extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var focusedAction
var enabledVerbs

func _ready():
	print( "[ActionMenu_Base] _ready")
	Hide()
	#connect( "signal_mouseEnteredActionMenuItem", self, "on_mouseEnteredActionMenuItem", [ actionName ] )
	
#func _input(event):
func _process( delta ):
	#print( "input" )
	focusedAction = null
	for item in get_children():
		# check if current action is supported by the focused object
		if enabledVerbs.has( item.actionName ):
			if item.get_node( "Area2D" ).overlaps_area( owner.get_node( "HUD/Cursor/Area2D" ) ):
				focusedAction = item.actionName	
				item.SetState( 1 )
			else:
				item.SetState( 0 )
		else: 
			# current object is not supported by the focused object
			# it should be shown as disabled
			item.SetState( 2 )
			
	# show action + object only if the focused action is supported by the focused object
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
	
func Show( verbs ):
	print( verbs )
	set_process( true )
	for item in get_children():
		print( item )
		item.visible = true
		item.get_node( "Area2D" ).monitorable = true
		
	for item in get_children():
		if not verbs.has( item.actionName ):
			#item.SetState( 2 )
			print( item.actionName + " is disabled" )
	enabledVerbs = 	verbs		
	visible = true
	
func Hide():
	set_process( false )	
	for item in get_children():
		item.visible = false
		item.get_node( "Area2D" ).monitorable = false		
	visible = false