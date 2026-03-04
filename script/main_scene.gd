class_name MainScene
extends Control

@onready var grid_container: GridContainer = %GridContainer

var buttons: Array[Node]
var chocolate_count: int
var streak_count: int
var correct_tiles: Dictionary[int, bool] = {}

var icon_textures = [
	preload("res://assets/stickers/bueno.png"),
	preload("res://assets/stickers/ferrero.png"),
	preload("res://assets/stickers/kinder2.png"),
	preload("res://assets/stickers/kinder3.png"),
	preload("res://assets/stickers/kinder.png"),
	preload("res://assets/stickers/nutella.png"),
	preload("res://assets/stickers/raffaello.png")
]

var dummy_textures = [
	preload("res://assets/stickers/image-x.png"),
	preload("res://assets/stickers/image-x-1.png"),
	preload("res://assets/stickers/image-x-2.png")
]

func reset() -> void:
	chocolate_count = 4
	streak_count = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()
	buttons = grid_container.get_children()
	
	for i in buttons.size():
		buttons[i].pressed.connect(on_button_pressed.bind(i))

	assign_icons()

func get_icon_indexes() -> Dictionary[int, bool]:
	var indexes_of_icons: Dictionary[int, bool] = {}
	
	while indexes_of_icons.size() < chocolate_count:
		var random_index = randi_range(0, buttons.size() -1)
		indexes_of_icons.set(random_index, true)
		
	return indexes_of_icons

func assign_icons() -> void:
	
	correct_tiles = get_icon_indexes()
	
	for index in correct_tiles:
		buttons[index].icon = icon_textures[randi() % icon_textures.size()]
		
func on_button_pressed(index: int) -> void:
	print("clicked ", index)
	
