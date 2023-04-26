extends Cell
#extends file cell.gd
class_name MoverCell

#mover direction:   right: 1 in x axis  left: -1 in x axis  down: 1 in y axis  up: -1 in y axis
@export
var mover_direction := Vector2(1, 0)


func _ready():
	super() #calls ready function of cell.gd
	cell_type = Data.MOVER_CELL
	#orient sprite to match mover direction
	match mover_direction:
		Vector2(1, 0):
			rotation_degrees = 180
		Vector2(-1, 0):
			rotation_degrees = 0
		Vector2(0, 1):
			rotation_degrees = 270
		_: #should be Vector2(0, -1)
			rotation_degrees = 90
			if mover_direction != Vector2(0, -1):
				mover_direction = Vector2(0, -1)
				push_error("Mover cell has invalid direction - set direction to up")
				
				
func move() -> void:
	change_position(cell_position + mover_direction)
	print(name + " moved")



