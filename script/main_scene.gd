class_name MainScene
extends Control

@onready var button_1: Button = %Button
@onready var button_2: Button = %Button2
@onready var button_3: Button = %Button3
@onready var button_4: Button = %Button4
@onready var button_5: Button = %Button5
@onready var button_6: Button = %Button6
@onready var button_7: Button = %Button7
@onready var button_8: Button = %Button8
@onready var button_9: Button = %Button9
@onready var button_10: Button = %Button10
@onready var button_11: Button = %Button11
@onready var button_12: Button = %Button12
@onready var button_13: Button = %Button13
@onready var button_14: Button = %Button14
@onready var button_15: Button = %Button15
@onready var button_16: Button = %Button16

@onready var grid_container_1_4: HBoxContainer = %"GridContainer1-4"
@onready var grid_container_5_8: HBoxContainer = %"GridContainer5-8"
@onready var grid_container_9_12: HBoxContainer = %"GridContainer9-12"
@onready var grid_container_13_16: HBoxContainer = %"GridContainer13-16"


var buttons: Array[Button]
var chocolate_count: int
var streak_count: int

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
	buttons = [
		button_1,
		button_2,
		button_3,
		button_4,
		button_5,
		button_6,
		button_7,
		button_8,
		button_9,
		button_10,
		button_11,
		button_12,
		button_13,
		button_14,
		button_15,
		button_16
	]
		
	assign_icons()

func get_indexes() -> Dictionary[int, bool]:
	var indexes: Dictionary[int, bool] = {}
	
	while indexes.size() < chocolate_count:
		var random_index = randi_range(0, buttons.size() -1)
		indexes.set(random_index, true)
		
	return indexes

func assign_icons() -> void:
	for index in get_indexes():
		buttons[index].icon = icon_textures[randi() % icon_textures.size()]
	
