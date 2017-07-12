extends Node2D

var seed_types = []
var plant_preload = preload("res://scenes/objects/Plant.tscn")
var proto_plant_frames = preload("res://scenes/objects/ProtoPlantSpriteFrames.tres")
var proto_seedbag = preload("res://asset/naraessets/Prototypes/seedpacket yellow.png")
var pink_plant_frames = preload("res://scenes/objects/PinkPlantSpriteFrames.tres")
var pink_seedbag = preload("res://asset/naraessets/Prototypes/seedpacket pink.png")
var yellow_plant_frames = preload("res://scenes/objects/YellowPlantSpriteFrames.tres")
var yellow_seedbag = preload("res://asset/naraessets/Prototypes/seedpacket yellow.png")


func _ready():
	var proto_plant = plant_preload.instance().init_plant("Proto Plant", proto_seedbag, proto_plant_frames)
	proto_plant.set_scale(Vector2(0.25, 0.25))
	seed_types.append(proto_plant)
	seed_types.append(plant_preload.instance().init_plant("Pink Plant", pink_seedbag, pink_plant_frames))
	seed_types.append(plant_preload.instance().init_plant("Yellow Plant", yellow_seedbag, yellow_plant_frames))
	
	var position = 100
	for plant in seed_types:
		#print(plant.get_plant_name())
		var plant_seed_packet = TextureButton.new()
		plant_seed_packet.set_normal_texture(plant.get_plant_seedbag())
		plant_seed_packet.set_pos(Vector2(position, 0))
		position += 50
		
		plant_seed_packet.connect("pressed", self, "_seed_packet_pressed", [plant])
		add_child(plant_seed_packet)

func _seed_packet_pressed(var pressed_packet):
	get_tree().get_root().get_node("GardenJam").set_selection(pressed_packet)