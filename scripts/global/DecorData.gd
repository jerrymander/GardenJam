extends Node

const DECOR_FILEPATH = "res://data/decor.json"

var decor_dictionary = {}

func _ready():
	decor_dictionary.parse_json(_read_data_file())
	#print(decor_dictionary)

func _read_data_file():
	var file = File.new()
	file.open(DECOR_FILEPATH, file.READ)
	var decor_json = file.get_as_text()
	file.close()
	return decor_json

func get_decor_names():
	return decor_dictionary.keys()

func get_decor_count():
	return decor_dictionary.size()

func get_decor_sprite(var decor_name):
	return load(decor_dictionary[decor_name]["decor_png_path"])

func get_decor_sprite_scale(var decor_name):
	if (decor_dictionary[decor_name].has("icon_scale")):
		return decor_dictionary[decor_name]["icon_scale"]
	else:
		return 1

#func get_seed_packet_texture(var plant_name):
#	return load(plant_dictionary[plant_name]["seedbag_png_path"])

#func get_grow_time(var plant_name):
#	return plant_dictionary[plant_name]["grow_time"]