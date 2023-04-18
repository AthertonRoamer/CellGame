extends Control
var world_scene = load("res://world.tscn")



func _on_button_pressed():
	get_tree().change_scene_to_packed(world_scene)
