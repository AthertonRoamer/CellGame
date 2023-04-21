extends Sprite2D
class_name Cell
#this is the base cell class that all the variants of cells can inherit from
var cell_position : Vector2 #cell position indicates a "square" on the map, not a real position i.e. cell_position (1, 1) means position (64, 64)
var cell_type : int
var nucleus : Node # the nucleous that owns this cell
var tween

var unpushable := false # cell cannot be pushed if true
var flimsy := false # cell destroyed when pushed if true


func _ready():
	add_to_group("cell")
	position = position.snapped(Vector2(Data.cell_size, Data.cell_size))
	cell_position = position / Data.cell_size
	register_self()
	Data.connect("register", _on_global_register)


func _process(_delta):
#	position = position.snapped(Vector2(Data.cell_size, Data.cell_size))
#	cell_position = position / Data.cell_size
#	register_self()
	pass


func register_self() -> void:
	Data.current_layout[cell_position] = self



func change_position(new_cell_pos : Vector2) -> void: #new_cell_pos should be a cell position i.e. it indicates a "square" on the map not a real position
	Data.current_layout.erase(cell_position)
	cell_position = new_cell_pos
	#could use tween to move cell smoothly here
#	tween.tween_property(self, "modulate", Color.RED, 1)
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "position", (cell_position * Data.cell_size), (Data.change_interval - 0.5))
#	position = cell_position * Data.cell_size
	Data.current_layout[cell_position] = self
	
	
func push(direction : Vector2) -> void: #push is meant to be called to non-mover cells who are pushed
	change_position(cell_position + direction)
#	print(name + " was pushed in " + str(direction))


func _on_global_register():
	register_self()


func cleanup():
	Data.current_layout.erase(cell_position)
	
	
func _exit_tree():
	cleanup()

