extends "res://templates/scenes/Scene_Base.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
#onready var Game = get_node("/root/Game" )
#onready var Cursor = preload( "res://templates/scenes/Cursor_Crosshair.tscn" ).instance()
var path = []



func _ready():
	#ShowInfoBar( false )
	SetInfoText( "Scene 1" )
	$Objects/Player.SetNavigation2D( $Backgrounds/Navigation2D )
	#print( "[Scene_Test_1] _ready")
	#print( Game.GetAllVerbs() )
	#set_process_input( true )
	
	
func ActionHandler( objects ):
	print( "[ActionHandler]" )
	print( objects[0] )
	print( objects[1] )
	if objects[0] == "Look At" and objects[1] == "Simple Object":
		$Objects/Player.Say( "It is an interesting object", 0.01, Color( 1, 0, 0, 0.8 ), "res://resources/audio/Player_2.ogg" )
	elif objects[0] == "Look At" and objects[1] == "Key":
		$Objects/Player.Say( "某種有用的東東", 0.01, Color( 0, 0, 1, 0.8 ), "res://resources/audio/Player_3.ogg" )

	


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

		
func _draw():
	for p in path:
		draw_circle( p, 3, Color(1,0,0,1) )
		

