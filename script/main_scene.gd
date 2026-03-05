class_name MainScene
extends Control

@onready var grid_container: GridContainer = %GridContainer
@onready var feedback: Feedback = %Feedback

var buttons: Array[Button]
var chocolate_count: int
var streak_count: int

var correct_tiles: Dictionary[int, bool] = {} # Tile index -> Clicked flag
var tiles_icon: Dictionary = {}
var click_count: int = 0

	
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

var wrong_icon = preload("res://assets/stickers/image-x-2.png")

func reset_game() -> void:
	chocolate_count = 4
	streak_count = 0

func reset_round() -> void:
	click_count = 0
	tiles_icon = {}
	assign_icons()
	enable_buttons()
	
func reset_grid() -> void:
	for index in buttons.size():
		buttons[index].icon = null
		
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for child in grid_container.get_children():
		if child is Button:
			buttons.append(child)
	
	for i in buttons.size():
		buttons[i].pressed.connect(on_button_pressed.bind(i))
		
	reset_game()
	reset_grid()
	reset_round()

func get_icon_indexes() -> Dictionary[int, bool]:
	var indexes_of_icons: Dictionary[int, bool] = {}
	
	while indexes_of_icons.size() < chocolate_count:
		var random_index = randi_range(0, buttons.size() -1)
		indexes_of_icons.set(random_index, false)
		
	return indexes_of_icons

func assign_icons() -> void:
	correct_tiles = get_icon_indexes()
	
	for index in correct_tiles:
		var icon = get_random_icon()
		fade_in(index, icon)
		tiles_icon.set(index, icon)
	
	await utils.timeout(1)
	
	for index in correct_tiles:
		fade_out(index)
	
func on_button_pressed(index: int) -> void:
	buttons[index].disabled = true
	
	if not correct_tiles.has(index):
		feedback.show_wrong()
		await utils.timeout(0.4)
		feedback.hide()
		reset_grid()
		reset_round()
	
	else:
		# Correct click
		correct_tiles.set(index, true)
		click_count += 1
		fade_in(index, tiles_icon.get(index))
		
		if click_count == correct_tiles.size():
			# Round win
			feedback.show_correct()
			await utils.timeout(0.2)
			reset_grid()
			reset_round()
			feedback.hide()
			
		
func get_random_icon():
	return icon_textures[randi() % icon_textures.size()]
	
func fade_in(index: int, icon: Variant):
	buttons[index].icon = icon
	utils.fade_in(buttons[index], 0.2)
	
	return buttons[index].icon
	
func fade_out(index: int) -> void:
	var clicked = correct_tiles.get(index)
	if not clicked:
		buttons[index].icon = null
	
func enable_buttons() -> void:
	for button in buttons:
		button.disabled = false
	
	
