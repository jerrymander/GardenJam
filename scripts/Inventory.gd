extends Node2D

const INVEN_WIDTH = 3
const INVEN_HEIGHT = 3

var inventory = []



func _ready():
	pass

func _display_inven():
	pass

func _add_to_inven(item):
	if inventory.has(item):
		var loc = inventory.find(item)
		inventory [loc][1] += 1
	else:
		inventory.append(item)
