extends Node2D

onready var plant_data = get_node("/root/PlantData")

func _ready():
	var position = 100
	for plant_name in plant_data.get_plant_names():
		var plant_seed_packet = TextureButton.new()
		var normal_texture = plant_data.get_seed_packet_texture(plant_name)
		plant_seed_packet.set_normal_texture(normal_texture)
		plant_seed_packet.set_pos(Vector2(position, 0))
		position += 50
		
		plant_seed_packet.connect("pressed", self, "_seed_packet_pressed", [plant_name])
		add_child(plant_seed_packet)

func _seed_packet_pressed(var pressed_packet):
	get_tree().get_root().get_node("GardenJam").set_selected_seed_packet(pressed_packet)