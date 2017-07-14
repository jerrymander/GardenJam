extends Node2D

var plant_name
var plant_seedbag
var plant_init_time
var plant_grow_time
var plant_frames = AnimatedSprite.new()

func _ready():
	pass

func init_plant(var name, var plant_data):
	plant_init_time = OS.get_unix_time()
	plant_name = name
	plant_grow_time = int(plant_data.get_grow_time(name))
	plant_frames.set_sprite_frames(plant_data.get_plant_sprite_frames(name))
	
	var sprite_scale = plant_data.get_plant_sprite_scale(name)
	set_scale(Vector2(sprite_scale, sprite_scale))
	
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
