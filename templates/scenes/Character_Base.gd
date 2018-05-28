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
var tie
var voices = {}
#onready var tie = get_node("TextInterfaceEngine")

func _ready():
	pass
	#tie.connect("input_enter", self, "_on_input_enter")
	#tie.connect("buff_end", self, "_on_buff_end")
	#tie.connect("state_change", self, "_on_state_change")
	#tie.connect("enter_break", self, "_on_enter_break")
	#tie.connect("resume_break", self, "_on_resume_break")
	#tie.connect("tag_buff", self, "_on_tag_buff")
	
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
		

func Say( text, speed, voiceFilePath = null):
	var tag = str( text.hash() )
	if voiceFilePath:
		print( tag )
		voices[ tag ] = voiceFilePath
		
	tie.buff_text( text, speed, tag )
	
	
func Silence( durationSec ):
	tie.buff_silence( durationSec )

func ClearDialogBox():
	tie.buff_clear()	

func BeginDialog( color ):
	if tie == null:		
		tie = owner.GetDialogBox( get_node( "." ).get_global_position() )
		tie.connect("input_enter", self, "_on_input_enter")
		tie.connect("buff_end", self, "_on_buff_end")
		tie.connect("state_change", self, "_on_state_change")
		tie.connect("enter_break", self, "_on_enter_break")
		tie.connect("resume_break", self, "_on_resume_break")
		tie.connect("tag_buff", self, "_on_tag_buff")
		tie.reset()
		tie.set_color( color )

	voices = {}
	print( tie )
	
func EndDialog():
	tie.set_state(tie.STATE_OUTPUT)
	
	
func _on_buff_end():
	print("Buff End")
	owner.RemoveDialogBox( tie )
	tie = null
	pass

func _on_state_change(i):
	print("New state: ", i)
	pass

func _on_enter_break():
	print("Enter Break")
	pass

func _on_resume_break():
	print("Resume Break")
	pass

func _on_tag_buff(s):
	print("Tag Buff ",s)
	if voices.has( s ):
		var stream = load( voices[ s ]  )
		stream.loop = false
		$AudioStreamPlayer.stream = stream
		$AudioStreamPlayer.play( 0 )
	pass