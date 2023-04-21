extends Cell
class_name Nucleus

var player_name : String = ""
var player_id : int
var energy : int = 0

func _ready():
	super()
	cell_type = Data.NUCLEUS
	player_id = Data.players.size()
	Data.players.append(self)
	unpushable = true
