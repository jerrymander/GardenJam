extends Node

func get_furniture(name):
	return get_node(name).duplicate()