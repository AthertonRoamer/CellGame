extends Node
signal register

enum {BLANK_CELL, MOVER_CELL, BOMB_CELL}

var cell_size = 64

# this dictionary will contain vector2s mapped to cell nodes
# it will be the authority for cell positions and will be referenced by the cell evalulator
var current_layout : Dictionary

var change_interval := 2

func global_cell_register():
	emit_signal("register")
