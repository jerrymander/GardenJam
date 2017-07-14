extends Node

const PLANT_FILEPATH = "res://data/plants.json"

var plant_dictionary = {}

func _ready():
	plant_dictionary.parse_json(_read_plant_file())
	#print(plant_dictionary)

func _read_plant_file():
	var file = File.new()
	file.open(PLANT_FILEPATH, file.READ)
	var plant_json = file.get_as_text()
	file.close()
	return plant_json

func get_plant_names():
	return plant_dictionary.keys()

func get_plant_sprite_frames(var plant_name):
	return load(plant_dictionary[plant_name]["plant_frames_tres_path"])

func get_plant_sprite_scale(var plant_name):
	if (plant_dictionary[plant_name].has("plant_sprite_scale")):
		return plant_dictionary[plant_name]["plant_sprite_scale"]
	else:
		return 1

func get_seed_packet_texture(var plant_name):
	return load(plant_dictionary[plant_name]["seedbag_png_path"])

func get_grow_time(var plant_name):
	return plant_dictionary[plant_name]["grow_time"]