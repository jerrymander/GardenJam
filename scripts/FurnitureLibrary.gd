extends Node

onready var decor_data = get_node("/root/DecorData")

const ITEM_NAME = 0
const ITEM_SIZE = 1
const ITEM_STACKS = 2
const ITEM_SPRITE = 3

var furn_data = [
	{
		ITEM_NAME: "LettuceHammock",
		ITEM_SIZE: Vector2(2,1),
		ITEM_SPRITE: 0
	},
	{
		ITEM_NAME: "BananaLamp",
		ITEM_SIZE: Vector2(1,2),
		ITEM_SPRITE: 1
	},
	{
		ITEM_NAME: "ProtoFurniture",
		ITEM_SIZE: Vector2(1,1),
		ITEM_SPRITE: 2
	}
]

var furn_map = { }

func _ready():
	for i in range(furn_data.size()):
		furn_map[furn_data[i][ITEM_NAME]] = i
	print (furn_map)

func get_furn_id(n):
	return furn_map[n]

func get_furn_name(i):
	return furn_data[i][ITEM_NAME]

func get_furn_sprite(i):
	return get_node(i).duplicate()

