extends Cell
class_name WallCell
#cell that cant be pushed

func _ready():
	super()
	cell_type = Data.WALL_CELL
	unpushable = true
