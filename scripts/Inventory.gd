extends Node2D

const INVEN_WIDTH = 3
const INVEN_HEIGHT = 3
const PAGE_SIZE = INVEN_WIDTH * INVEN_HEIGHT

onready var furniture_lib = preload("res://scenes/objects/Furnitures.tscn").instance()

onready var sprite = get_node("Sprite")
var inventory = []
var inventory_size
var page = []
var page_viewing

var display_loc

func _ready():
	for x in range (INVEN_HEIGHT):
		page.append([])
		for y in range (INVEN_WIDTH):
			page[x].append(null)
	check_nav_buttons()
	page_viewing = 1
	display_inven(page_viewing)

func display_inven(page):
	var start_index = (page-1) * PAGE_SIZE
	inventory_size = inventory.size()
	if (inventory_size == 0):
		pass
	else:
		for x in range (start_index, min(inventory_size, start_index+8)):
			var page_x = (x-start_index) % PAGE_SIZE
			var page_y = floor((x-start_index) / PAGE_SIZE)
			page[page_x][page_y] = inventory[x][0]
			display_loc = sprite.get_child(x % 9).get_pos()
			page[page_x][page_y].set_pos(display_loc)
			add_child(page[page_x][page_y])

func clear_inven():
	if page[0][0] != null:
		for x in range (INVEN_WIDTH):
			for y in range (INVEN_HEIGHT):
				page[x][y].queue_free()

func get_item(id):
	remove_item(id)
	if (inventory[id][1] == 0):
		inventory[id].remove()
	return inventory[id][0]

func add_item(item):
	inventory_size = inventory.size()
	var furniture_item = furniture_lib.get_furniture(item)
	for x in range (inventory_size):
		if inventory[x].has(furniture_item):
			inventory[x][1] += 1
		else:
			inventory.append([furniture_item, 1])
	if (inventory_size == 0):
		inventory.append([furniture_item, 1])

func remove_item(id):
	inventory[id][1] -= 1
	if (inventory[id][1] == 0):
		inventory[id].remove()

func check_nav_buttons():
	if (page_viewing == 1):
		get_node("LeftButton").set_disabled(true)
	else:
		get_node("LeftButton").set_disabled(false)
		get_node("RightButton").set_disabled(false)

func _on_AddHammock_pressed():
	add_item("LettuceHammock")
	print("Hammock clicked.")

func _on_AddLamp_pressed():
	add_item("BananaLamp")
	print("Lamp clicked.")

func _on_RightButton_pressed():
	clear_inven()
	page_viewing += 1
	check_nav_buttons()
	print("Now viewing page: ", page_viewing)
	display_inven(page_viewing)

func _on_LeftButton_pressed():
	clear_inven()
	page_viewing -= 1
	check_nav_buttons()
	print("Now viewing page: ", page_viewing)
	display_inven(page_viewing)

func _on_Refresh_pressed():
	clear_inven()
	display_inven(page_viewing)
	print (inventory)
