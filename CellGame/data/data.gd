extends Node
signal register
signal changing

enum {BLANK_CELL, MOVER_CELL, WALL_CELL, NUCLEUS, ALGAE_CELL, BOMB_CELL}

var cell_size = 64

# this dictionary will contain vector2s mapped to cell nodes
# it will be the authority for cell positions and will be referenced by the cell evalulator
var current_layout : Dictionary
var players := [] # array of all players nucleuses

var change_interval := 4

func alert_changing():
	emit_signal("changing")

func global_cell_register():
	emit_signal("register")
