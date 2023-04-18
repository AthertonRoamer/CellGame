extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ChangeTimer.wait_time = Data.change_interval
	$ChangeTimer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func evaluate_cells():
	#evaluate mover cells
	var past_layout := Data.current_layout.duplicate() #dictionarys are always passed by reference so must use duplicate()
	for cell_pos in past_layout:
		var cell = past_layout[cell_pos]
		if cell is MoverCell:
			#add logic to see if cell can move here
			
			#compute strength and weight
			var strength := 1
			var weight := 0
			var strength_behind := 1
#			var strength_ahead := 0
			#look backward
			var past_space = cell_pos - cell.mover_direction
			while(past_layout.has(past_space) and past_layout[past_space] is MoverCell):
				strength += 1
				strength_behind += 1
				past_space -= cell.mover_direction
			#look forward
			var next_space = cell_pos + cell.mover_direction
			var end_strength = false
			while(past_layout.has(next_space) and past_layout[next_space] is Cell):
				if past_layout[next_space] is MoverCell and past_layout[next_space].mover_direction == cell.mover_direction and !end_strength:
					strength += 1
#					strength_ahead += 1
				else:
					end_strength = true
					weight += 1
					if weight > strength and end_strength:
						break
				next_space += cell.mover_direction
			#reset looking forward
			next_space = cell_pos + cell.mover_direction * strength
			if weight <= strength:
				if past_layout.has(next_space) and past_layout[next_space] is Cell and weight >= strength_behind:
					past_layout[next_space].push(cell.mover_direction)
				cell.move()


func _on_change_timer_timeout():
	evaluate_cells()
