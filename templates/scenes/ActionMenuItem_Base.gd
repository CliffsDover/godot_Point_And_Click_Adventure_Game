extends Node2D

export (String) var actionName
export (float) var focusedScale = 1.0

signal signal_mouseEnteredActionMenuItem( actionName )
signal signal_mouseExitedActionMenuItem( actionName )

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	



func _on_Area2D_mouse_entered():
	return
	#print( "[signal_mouseEnteredActionMenuItem] " + actionName )
	#emit_signal( "signal_mouseEnteredActionMenuItem", actionName )
	get_parent()._on_mouseEnteredActionMenuItem( actionName )
	$AnimatedSprite.play( "focused" )
	$AnimatedSprite.scale = Vector2( focusedScale, focusedScale )


func _on_Area2D_mouse_exited():
	return
	#print( "[signal_mouseExitedActionMenuItem] " + actionName )
	#emit_signal( "signal_mouseExitedActionMenuItem", actionName )
	get_parent()._on_mouseExitedActionMenuItem( actionName )
	$AnimatedSprite.play( "default" )
	$AnimatedSprite.scale = Vector2( 1, 1 )

func SetState( state ):
	if 0 == state:
		$AnimatedSprite.play( "default" )
		$AnimatedSprite.scale = Vector2( 1, 1 )
	elif 1 == state:
		$AnimatedSprite.play( "focused" )
		$AnimatedSprite.scale = Vector2( focusedScale, focusedScale )