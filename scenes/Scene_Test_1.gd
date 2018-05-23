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
	pass
	#print( "[Scene_Test_1] _ready")
	#print( Game.GetAllVerbs() )
	#set_process_input( true )
	
func ActionHandler( objects ):
	print( "[ActionHandler]" )
	print( objects[0] )
	print( objects[1] )


func CursorClickedAt( pos ):
	print( "[CursorClickedAt]" )
	print( pos )
	#updatePath( $Objects/Player.position, get_global_mouse_position() )

	
func updatePath( startPos, endPos ):
	#path = $Backgrounds/Navigation2D.get_simple_path( startPos, endPos, false )
	#if path.size() == 0:
	#update()	
	pass	


func _process(delta):
	if path.size() >= 1:
		print( "-------" )
		print( $Objects/Player.position )
		print( path[0] )
		
		var d = $Objects/Player.position.distance_to( path[0] )
		if d > 2:
			$Objects/Player.position = $Objects/Player.position.linear_interpolate( path[0], ( 200 * delta ) / d )
			$Objects/Player/RayCast2D.look_at( path[0] )
			print( $Objects/Player/RayCast2D.get_angle_to( Vector2(1,0) ) ) 
		else:
			path.remove( 0 ) 

		
func _draw():
	for p in path:
		draw_circle( p, 10, Color(1,0,0,1) )
		