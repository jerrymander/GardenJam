extends Node

onready var sprite = get_node("AnimatedSprite")

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func get_current_stage():
	return sprite.get_frame()

func get_max_stage():
	return sprite.get_sprite_frames().get_frame_count("default")

func is_grown():
	return get_current_stage() == get_max_stage()-1

func grow():
	sprite.set_frame(sprite.get_frame()+1)
	