extends Node2D

export (String) var actionName
export (float) var focusedScale = 1.0


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func SetState( state ):
	if 0 == state:
		$AnimatedSprite.play( "Default" )
		$AnimatedSprite.scale = Vector2( 1, 1 )
	elif 1 == state:
		$AnimatedSprite.play( "Enabled" )
		$AnimatedSprite.scale = Vector2( focusedScale, focusedScale )
	elif 2 == state:
		$AnimatedSprite.play( "Disabled" )		