extends Node2D

var plant_name
var plant_frames = AnimatedSprite.new()

func _ready():
	pass

func init_plant(var name, var frames):
	plant_name = name
	plant_frames.set_sprite_frames(frames)
	add_child(plant_frames)
	return self

func get_plant_name():
	return plant_name

func get_current_stage():
	return plant_frames.get_frame()

func get_max_stage():
	return plant_frames.get_sprite_frames().get_frame_count("default")

func is_grown():
	return get_current_stage() == get_max_stage()-1

func grow():
	plant_frames.set_frame(plant_frames.get_frame()+1)
