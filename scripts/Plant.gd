extends Node2D

var plant_name
var plant_seedbag
var plant_init_time
var plant_grow_time
var plant_frames = AnimatedSprite.new()

func _ready():
	pass

func init_plant(var name, var seedbag, var frames, var grow_time):
	plant_init_time = OS.get_unix_time()
	plant_name = name
	plant_seedbag = seedbag
	plant_grow_time = grow_time
	plant_frames.set_sprite_frames(frames)
	add_child(plant_frames)
	return self

func get_plant_init_time():
	return plant_init_time

func get_plant_grow_time():
	return plant_grow_time

func get_plant_name():
	return plant_name

func get_plant_seedbag():
	return plant_seedbag

func get_plant_frames():
	return plant_frames.get_sprite_frames()

func get_current_stage():
	return plant_frames.get_frame()

func get_max_stage():
	return plant_frames.get_sprite_frames().get_frame_count("default")

func is_grown():
	return get_current_stage() == get_max_stage()-1

func grow():
	plant_frames.set_frame(plant_frames.get_frame()+1)
