extends "res://templates/scenes/Object_Base.gd"

enum FACING {
	EAST,
	NORTH_EAST,
	NORTH,
	NORTH_WEST,
	WEST,
	SOUTH_WEST,
	SOUTH,
	SOUTH_EAST,
}

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
	#look_at( path[0] )
	#print( "!!!" )
	if FACING.EAST == GetCurrentHeading( path[0] - get_node(".").global_position ):
		$Sprite/AnimationPlayer.play( "walk_right" )
	else:
		$Sprite/AnimationPlayer.play( "walk_left" )
		
func _process(delta):
	if path.size() >= 1:
		#print( "-------" )
		#print( $Objects/Player.position )
		#print( path[0] )
		
		var d = self.position.distance_to( path[0] )
		if d > 2:
			self.position = self.position.linear_interpolate( path[0], ( 200 * delta ) / d )
			#print( $Objects/Player/RayCast2D.get_angle_to( Vector2(1,0) ) ) 
		else:
			path.remove( 0 ) 
			if path.size() > 0:
				#look_at( path[0] )
				if FACING.EAST == GetCurrentHeading( path[0] - get_node(".").global_position ):
					if $Sprite/AnimationPlayer.current_animation != "walk_right":
						$Sprite/AnimationPlayer.play( "walk_right" )
				else:
					if $Sprite/AnimationPlayer.current_animation != "walk_left":
						$Sprite/AnimationPlayer.play( "walk_left" )
	else:
		if $Sprite/AnimationPlayer.current_animation == "walk_right":
			$Sprite/AnimationPlayer.play( "idle_right" )
		elif $Sprite/AnimationPlayer.current_animation == "walk_left":
			$Sprite/AnimationPlayer.play( "idle_left" )
	
func GetCurrentHeading( lookVector ):
	print( lookVector.normalized() ) 
	if lookVector.normalized().x >= 0:
		return FACING.EAST
	else:
		return FACING.WEST