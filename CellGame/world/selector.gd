extends Sprite2D

var p : Vector2

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
	
func _process(_delta):
	p = get_global_mouse_position()
	p = p.snapped(Vector2(Data.cell_size, Data.cell_size))
	set_position(p)
