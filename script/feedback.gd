class_name Feedback
extends Panel

@onready var feedbackImage: TextureRect = %TextureRect

const correct_answer = preload("uid://j3nux2qgyx61")
const wrong_answer = preload("uid://w3jvmc44k6ao")

func _ready() -> void:
	self.hide()

func show_wrong() -> void:
	self.show()
	feedbackImage.texture = wrong_answer
	utils.fade_in(feedbackImage, 0.2)
	
func show_correct() -> void:
	self.show()
	feedbackImage.texture = correct_answer
	utils.fade_in(feedbackImage, 0.2)
	
