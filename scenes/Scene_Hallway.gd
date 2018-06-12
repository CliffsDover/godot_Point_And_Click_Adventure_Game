extends "res://templates/scenes/Scene_Base.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var path = []

func _ready():
	SetInfoText( "Hallway" )
	$Objects/Player.SetNavigation2D( $Backgrounds/Navigation2D )

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func ActionHandler( objects ):
	print( "[ActionHandler]" )
	print( objects[0] )
	print( objects[1].objectName )
	if objects[0] == "Walk To":
		$Objects/Player.WalkTo( objects[1].position )
	
func ObjectHandler( object1, object2 ):
	if object1.name == "Player" and object2.name == "DoorToQuarters":
		print( "Entering quarters" )
		get_tree().change_scene( "res://scenes/Scene_Test_1.tscn" )
	
func CursorClickedAt( pos ):
	#print( "[CursorClickedAt]" )
	#print( pos )
	#updatePath( $Objects/Player.position, get_global_mouse_position() )
	$Objects/Player.WalkTo( pos )

	
func updatePath( startPos, endPos ):
	path = $Backgrounds/Navigation2D.get_simple_path( startPos, endPos, true )
	if path.size() > 0:
		update()	
		


func _process(delta):
	if path.size() >= 1:
		#print( "-------" )
		#print( $Objects/Player.position )
		#print( path[0] )
		
		var d = $Objects/Player.position.distance_to( path[0] )
		if d > 2:
			$Objects/Player.position = $Objects/Player.position.linear_interpolate( path[0], ( 200 * delta ) / d )
			$Objects/Player/RayCast2D.look_at( path[0] )
			#print( $Objects/Player/RayCast2D.get_angle_to( Vector2(1,0) ) ) 
		else:
			path.remove( 0 ) 
