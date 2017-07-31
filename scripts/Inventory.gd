extends Control

const INVEN_WIDTH = 3
const INVEN_HEIGHT = 3
const PAGE_SIZE = INVEN_WIDTH * INVEN_HEIGHT

onready var furniture_lib = preload("res://scenes/objects/Furnitures.tscn").instance()

onready var sprite = get_node("Sprite")
var inventory = []
var inven_map = {}
var inventory_size
var slots = []
var page_viewing

var display_loc

func _ready():
	add_child(furniture_lib)
	
	for x in range (INVEN_HEIGHT):
		slots.append([])
		for y in range (INVEN_WIDTH):
			slots[x].append(null)
	check_nav_buttons()
	page_viewing = 1
	draw_slots()

func draw_slots():
	var start_index = (page_viewing-1) * PAGE_SIZE
	inventory_size = inventory.size()
	if (inventory_size == 0):
		pass
	else:
		for x in range (start_index, min(inventory_size, start_index+8)):
			var page_x = (x-start_index) % PAGE_SIZE
			var page_y = floor((x-start_index) / PAGE_SIZE)
			var furniture_name = inventory[x][0]
			var furniture_id = furniture_lib.get_furn_id(furniture_name)
			slots[page_x][page_y] = furniture_lib.get_furn_sprite(furniture_name)
			display_loc = sprite.get_child(x % 9).get_pos()
			slots[page_x][page_y].set_pos(display_loc)
			add_child(slots[page_x][page_y])

func clear_slots():
	for x in range (INVEN_WIDTH):
		for y in range (INVEN_HEIGHT):
			if slots[x][y] != null:
				slots[x][y].queue_free()
				slots[x][y] = null

func get_item(id):
	return inventory[id][0]

func map_inventory():
	for i in range(inventory.size()):
		inven_map[inventory[i][0]] = i

func add_item(name, count):
	inventory_size = inventory.size()
	if inven_map.has(name):
		inventory[inven_map[name]][1] += count
	else:
		inven_map[name] = inventory.size()
		inventory.append([name, 1])

func remove_item(name, count):
	var furn_id = inven_map[name]
	if (inventory[furn_id][1] > count):
		inventory[furn_id][1] -= count
	else:
		inventory[furn_id].remove()

func check_nav_buttons():
	if (page_viewing == 1):
		get_node("LeftButton").set_disabled(true)
	else:
		get_node("LeftButton").set_disabled(false)
		get_node("RightButton").set_disabled(false)

func _on_AddHammock_pressed():
	add_item("LettuceHammock", 1)
	print("Hammock clicked.")

func _on_AddLamp_pressed():
	add_item("BananaLamp", 1)
	print("Lamp clicked.")

func _on_RightButton_pressed():
	clear_slots()
	page_viewing += 1
	check_nav_buttons()
	print("Now viewing page: ", page_viewing)
	draw_slots()

func _on_LeftButton_pressed():
	clear_slots()
	page_viewing -= 1
	check_nav_buttons()
	print("Now viewing page: ", page_viewing)
	draw_slots()

func _on_Refresh_pressed():
	clear_slots()
	draw_slots()
	map_inventory()
	print (inventory)
	print (inven_map)
