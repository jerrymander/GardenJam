extends Node2D

var furniture_name
var furniture_size = Vector2(0,0)

func _ready():
	pass

func init_furniture(name, data):
	furniture_name = name
	furniture_size = Vector2(1,1)

