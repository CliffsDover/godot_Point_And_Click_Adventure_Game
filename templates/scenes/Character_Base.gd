extends "res://templates/scenes/Object_Base.gd"

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var path = []
var nav2D = null

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func SetNavigation2D( navigation2D ):
	nav2D = navigation2D

func WalkTo( pos ):
	UpdatePath( self.position, pos)	


func UpdatePath( startPos, endPos ):
	path = nav2D.get_simple_path( startPos, endPos, true )

		
func _process(delta):
	if path.size() >= 1:
		#print( "-------" )
		#print( $Objects/Player.position )
		#print( path[0] )
		
		var d = self.position.distance_to( path[0] )
		if d > 2:
			self.position = self.position.linear_interpolate( path[0], ( 200 * delta ) / d )
			$RayCast2D.look_at( path[0] )
			#print( $Objects/Player/RayCast2D.get_angle_to( Vector2(1,0) ) ) 
		else:
			path.remove( 0 ) 
	

