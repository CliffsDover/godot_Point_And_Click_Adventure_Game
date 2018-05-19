extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var focusedAction

func _ready():
	pass
	#connect( "signal_mouseEnteredActionMenuItem", self, "on_mouseEnteredActionMenuItem", [ actionName ] )
	

func _on_mouseEnteredActionMenuItem(actionName):
	print( "[_on_mouseEnteredActionMenuItem] " + actionName )
	focusedAction = actionName
	
	
func _on_mouseExitedActionMenuItem(actionName):
	print( "[_on_mouseExitedActionMenuItem]" + actionName )
	focusedAction = null
	
