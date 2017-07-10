extends Node2D

var seed_types = []
var plant_preload = preload("res://scenes/objects/Plant.tscn")
var proto_plant_frames = preload("res://scenes/objects/ProtoPlantSpriteFrames.tres")
var pink_plant_frames = preload("res://scenes/objects/PinkPlantSpriteFrames.tres")
var yellow_plant_frames = preload("res://scenes/objects/YellowPlantSpriteFrames.tres")


func _ready():
	var proto_plant = plant_preload.instance().init_plant("Proto Plant", proto_plant_frames)
	proto_plant.set_scale(Vector2(0.25, 0.25))
	seed_types.append(proto_plant)
	seed_types.append(plant_preload.instance().init_plant("Pink Plant", pink_plant_frames))
	seed_types.append(plant_preload.instance().init_plant("Yellow Plant", yellow_plant_frames))
	
	var position = 100
	for plant in seed_types:
		print(plant.get_plant_name())
		var plant_seed_packet = TextureButton.new()
		plant_seed_packet.set_normal_texture(preload("res://asset/naraessets/seedpacket pink.png"))
		plant_seed_packet.set_pos(Vector2(position, 0))
		position += 50
		
		plant_seed_packet.connect("pressed", self, "_seed_packet_pressed", [plant])
		add_child(plant_seed_packet)

func _seed_packet_pressed(var pressed_packet):
	print (pressed_packet.get_plant_name())