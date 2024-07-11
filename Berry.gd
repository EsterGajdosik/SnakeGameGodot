extends Node2D

class_name Berry

var berry_position = Vector2()

func _ready():
	randomize()
	reset_position()

func reset_position():
	berry_position = Vector2(randi() % 32, randi() % 16)
	print("Berry position reset to: ", berry_position)
	queue_redraw()

func _draw():
	draw_rect(Rect2(berry_position * 10, Vector2(10, 10)), Color(1, 0, 0))
