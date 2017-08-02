extends Control

const INVEN_WIDTH = 3
const INVEN_HEIGHT = 3
const PAGE_SIZE = INVEN_WIDTH * INVEN_HEIGHT

#onready var furniture_lib = preload("res://scenes/objects/Furnitures.tscn").instance()
onready var decor_data = get_node("/root/DecorData")
onready var sprite = get_node("Sprite")

var inventory = []
var inven_map = {}
var inventory_size
var slots = []
var page_viewing

var display_loc

func _ready():
	#add_child(furniture_lib)
	font.set_font_data(f_pacifico)
	
	for x in range (INVEN_HEIGHT):
		slots.append([])
		for y in range (INVEN_WIDTH):
			slots[x].append(null)
	page_viewing = 1
	check_nav_buttons()
	draw_slots()

func draw_slots():
	var start_index = (page_viewing-1) * PAGE_SIZE
	inventory_size = inventory.size()
	if (inventory_size == 0):
		pass
	else:
		for x in range (start_index, min(inventory_size, start_index+8)):
			var page_x = (x-start_index) % INVEN_WIDTH
			var page_y = int(floor((x-start_index) / INVEN_HEIGHT))
			print("Inventory.gd] ", page_x, ", ", page_y)
			update_slot(page_x, page_y)

func update_slot(x,y):
	var inv_index = int((page_viewing-1)*9 + y*3 + x)
	var decor_name = inventory[inv_index][0]
	var decor_count = inventory[inv_index][1]
	#update texture and make icon
	var normal_texture = decor_data.get_decor_sprite(decor_name)
	var texture_scale = decor_data.get_decor_sprite_scale(decor_name)
	slots[x][y] = TextureButton.new()
	slots[x][y].set_normal_texture(normal_texture)
	print("Inventory.gd] ", slots[x][y])
	slots[x][y].set("params/scale", Vector2(texture_scale, texture_scale))
	display_loc = sprite.get_child(inv_index % 9).get_pos()
	slots[x][y].set_pos(display_loc)
	add_child(slots[x][y])
	#update number of items in slot
	var count_label = Label.new()
	count_label.set_text(str(decor_count))
	count_label.set("custom_colors/font_color", Color(200,100,100))
	#count_label.add_font_override("font", load("res://asset/fonts/Pacifico/Pacifico.fnt"))
	slots[x][y].add_child(count_label)

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
	add_item("Lettuce Hammock", 1)
	print("Hammock clicked.")

func _on_AddLamp_pressed():
	add_item("Banana Lamp", 1)
	print("Lamp clicked.")

func _on_RightButton_pressed():
	clear_slots()
	page_viewing += 1
	get_node("Page").set_text(str(page_viewing))
	check_nav_buttons()
	#print("[Inventory.gd] Now viewing page: ", page_viewing)
	draw_slots()

func _on_LeftButton_pressed():
	clear_slots()
	page_viewing -= 1
	get_node("Page").set_text(str(page_viewing))
	check_nav_buttons()
	#print("[Inventory.gd] Now viewing page: ", page_viewing)
	draw_slots()

func _on_Refresh_pressed():
	clear_slots()
	draw_slots()
	map_inventory()
	#print ("[Inventory.gd] ", inventory)
	#print ("[Inventory.gd] ", inven_map)
