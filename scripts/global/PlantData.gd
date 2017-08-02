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

#picking furniture to grow into/select
func get_plant_common_decor(var plant_name):
	var decor_list = plant_dictionary[plant_name]["grows_into_common"]
	print("[PlantData.gd] ", decor_list)
	var rng = randi() % decor_list.size()
	return decor_list[rng]

func get_plant_rare_decor(var plant_name):
	var decor_list = plant_dictionary[plant_name]["grows_into_rare"]
	print("[PlantData.gd] ", decor_list)
	var rng = randi() % decor_list.size()
	return decor_list[rng]

func get_plant_random_decor(var plant_name):
	var rnjesus = randi()
	if (rnjesus % 10 == 0 && plant_dictionary[plant_name].has("grows_into_rare")):
		return get_plant_rare_decor(plant_name)
	else:
		return get_plant_common_decor(plant_name)

func get_plant_decor_list(var plant_name):
	var decor_list = []
	for x in range (plant_dictionary[plant_name]["grows_into_common"].size()):
		decor_list.append(plant_dictionary[plant_name]["grows_into_common"][x])
	for y in range (plant_dictionary[plant_name]["grows_into_rare"].size()):
		decor_list.append(plant_dictionary[plant_name]["grows_into_rare"][y])
	return decor_list