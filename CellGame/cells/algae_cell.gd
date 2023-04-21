extends Cell
class_name AlgaeCell


func _ready():
	super()
	cell_type = Data.ALGAE_CELL
	flimsy = true
	Data.connect("changing", _on_changing)
	
	
func _on_changing():
	if nucleus is Nucleus:
		nucleus.energy += 1
	else:
		push_error("algae cell " + name + " instansiated without nucleus")
		pass
		
		
func shatter(): #function called on flimsy cells to remove them
	var fade_tween = create_tween()
	fade_tween.tween_property(self, "material:shader_parameter/alpha" , 0.0, (Data.change_interval - 0.6))
	$FreeTimer.wait_time = Data.change_interval
	$FreeTimer.start()


func _on_free_timer_timeout():
	queue_free()
