extends Node

onready var cursor_passive = preload("res://asset/naraessets/glovecursor passive.png")
onready var cursor_active = preload("res://asset/naraessets/glovecursor active.png")
onready var plant = preload("res://scenes/objects/Plant.tscn")
onready var proto_plant_frames = preload("res://scenes/objects/ProtoPlantSpriteFrames.tres")

const PLOT_WIDTH = 3
const PLOT_HEIGHT = 3

var plot_width_per
var plot_height_per

var plot = []

func _ready():
	set_process_input(true)
	
	# calculate plot grid dimensions
	var sprite_node = get_node("Sprite")
	var sprite_texture = sprite_node.get_texture()
	var sprite_width = sprite_texture.get_width() * sprite_node.get_scale().x
	var sprite_height = sprite_texture.get_height() * sprite_node.get_scale().y
	plot_width_per = sprite_width / PLOT_WIDTH
	plot_height_per = sprite_height / PLOT_HEIGHT
	get_node("../Camera2D").set_pos(Vector2(250,325))
	get_node("../Ambiance").set_volume(1.5)
	get_node("../BGM").set_volume(0.7)
	
	# change cursor
	#var resized_passive = cursor_passive.get_data().resized(50,50)
	#cursor_passive.create_from_image(resized_passive)
	#var resized_active = cursor_active.get_data().resized(50,50)
	#cursor_active.create_from_image(resized_active)
	Input.set_custom_mouse_cursor(cursor_passive)
	
	# init plot array/grid
	for x in range(PLOT_WIDTH):
		plot.append([])
		for y in range(PLOT_HEIGHT):
			plot[x].append(null)
	

func _input(var ev):
	_decide_mouse_cursor(ev)
	if (ev.type == InputEvent.MOUSE_BUTTON && ev.pressed):
		# calculate coordinate of click
		var plot_click_x = ev.pos.x - get_pos().x
		var plot_click_y = ev.pos.y - get_pos().y
		plot_click_x = floor(plot_click_x / plot_width_per)
		plot_click_y = floor(plot_click_y / plot_height_per)
		
		if (plot_click_x < PLOT_WIDTH && plot_click_y < PLOT_HEIGHT 
			&& plot_click_x >= 0 && plot_click_y >= 0):
			_poke_plot(plot_click_x, plot_click_y)
	

func _poke_plot(var x, var y):
	if (plot[x][y] == null):
		#plot[x][y] = proto_plant.instance()
		plot[x][y] = plant.instance().init_plant("Proto Plant", proto_plant_frames)
		plot[x][y].set_scale(Vector2(0.25, 0.25))
		var centered_position = Vector2(
			(x+0.5)*plot_width_per, 
			(y+0.5)*plot_height_per)
		plot[x][y].set_pos(centered_position)
		add_child(plot[x][y])
		get_node("../SamplePlayer").play("sfx_doink_2")
		#print(str(x)+", "+str(y))
	else:
		if (plot[x][y].is_grown()):
			#print("rip")
			plot[x][y].queue_free()
			plot[x][y] = null
			get_node("../SamplePlayer").play("sfx_veggierip_2")
		else:
			plot[x][y].grow()

func _decide_mouse_cursor(var ev):
	if (ev.type == InputEvent.MOUSE_BUTTON && ev.pressed):
		Input.set_custom_mouse_cursor(cursor_active)
	else:
		Input.set_custom_mouse_cursor(cursor_passive)

