extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

export (String) var objectName
export (String) var objectDescription
export(int, FLAGS, "Look", "Use", "Take" ) var verb = 0


func _ready():
	print( verb )
	getAvailableVerbs()

func getAvailableVerbs():
	var allVerbs = [ "Look", "Use", "Take", "Talk", "Open", "Close" ]
	var verbs = []
	for v in range( allVerbs.size() ):
		if verb & ( 1 << v ):
			print( allVerbs[v] )
			verbs.append( allVerbs[v] )
			
	return verbs

	
	 