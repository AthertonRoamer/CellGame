extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$ChangeTimer.wait_time = Data.change_interval
	$ChangeTimer.start()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func evaluate_cells():
	#call global cell register on data in between every phase
	
	#evaluate mover cells
	#phase: mover cells going up
	var past_layout := Data.current_layout.duplicate() #dictionarys are always passed by reference so must use duplicate()
	for cell_pos in past_layout:
		evaluate_mover_cell(cell_pos, past_layout, Vector2.UP)
	Data.global_cell_register()
	
	#phase: mover cells going down
	past_layout = Data.current_layout.duplicate() #dictionarys are always passed by reference so must use duplicate()
	for cell_pos in past_layout:
		evaluate_mover_cell(cell_pos, past_layout, Vector2.DOWN)
	Data.global_cell_register()
	
	#phase: mover cells going right
	past_layout = Data.current_layout.duplicate() #dictionarys are always passed by reference so must use duplicate()
	for cell_pos in past_layout:
		evaluate_mover_cell(cell_pos, past_layout, Vector2.RIGHT)
	Data.global_cell_register()
	
	#phase: mover cells going left
	past_layout = Data.current_layout.duplicate() #dictionarys are always passed by reference so must use duplicate()
	for cell_pos in past_layout:
		evaluate_mover_cell(cell_pos, past_layout, Vector2.LEFT)
	Data.global_cell_register()


func evaluate_mover_cell(cell_pos : Vector2, past_layout : Dictionary, mover_direction : Vector2):
	var cell = past_layout[cell_pos]
	if cell is MoverCell and cell.mover_direction == mover_direction:
		#logic to see if cell can move here
		#compute strength and weight
		var strength := 1
		var weight := 0
		var strength_behind := 1
		var stocked := 0
		var cell_to_break : Cell
#		var strength_ahead := 0
		#look backward
		var past_space = cell_pos - cell.mover_direction
		while(past_layout.has(past_space) and past_layout[past_space] is MoverCell and past_layout[past_space].mover_direction == cell.mover_direction):
			strength += 1
			strength_behind += 1
			past_space -= cell.mover_direction
		#look forward
		var next_space = cell_pos + cell.mover_direction
		var end_strength = false
		while(past_layout.has(next_space) and past_layout[next_space] is Cell):
			if past_layout[next_space] is MoverCell and past_layout[next_space].mover_direction == cell.mover_direction:
				if end_strength:
					stocked += 1
				else:
					strength += 1
#					strength_ahead += 1
			elif past_layout[next_space].unpushable: #cells that cannot be pushed
				end_strength = true
				weight = strength + 1
				break
			elif past_layout[next_space].flimsy: #cells that are destroyed on pushing
				cell_to_break = past_layout[next_space]
				break
			else:
				end_strength = true
				if stocked > 0:
					stocked -= 1
				else:
					weight += 1
				if weight > strength and end_strength:
					break
			next_space += cell.mover_direction
		#reset looking forward
		next_space = cell_pos + cell.mover_direction * strength
		#preform final check based on accumulated data and move/push if applicable
		if weight <= strength:
			if past_layout.has(next_space) and past_layout[next_space] is Cell and weight >= strength_behind:
				past_layout[next_space].push(cell.mover_direction)
			if cell_to_break != null:
				cell_to_break.shatter()
			cell.move()


func _on_change_timer_timeout():
	Data.alert_changing()
	evaluate_cells()
