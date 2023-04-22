extends Node2D
@export
var line_color : Color = Color.WHITE


@export
var line_width : float = 1

var offset = Vector2i(32, 32)

func _draw():
	line_color.a8 = 255
	var win_size = DisplayServer.screen_get_size()
#	win_size += Data.cell_size * 2
	#draw upright lines
	var this_x = offset.x
	var end_y = win_size.y + Data.cell_size + offset.y
	var start_y = offset.y - Data.cell_size
	while(this_x < win_size.x):
		draw_line(Vector2(this_x, start_y), Vector2(this_x, end_y), line_color, line_width)
		this_x += Data.cell_size
		
	#draw horizontal lines
	var this_y = offset.y
	var end_x = win_size.x + Data.cell_size + offset.x
	var start_x = offset.x - Data.cell_size
	while(this_y < win_size.y):
		draw_line(Vector2(start_x, this_y), Vector2(end_x, this_y), line_color, line_width)
		this_y += Data.cell_size
