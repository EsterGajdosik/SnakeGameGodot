extends Node2D

class_name Snake

var direction = Vector2.RIGHT
var new_direction = Vector2.RIGHT
var body = []
var growth = 0

func _ready():
	set_process(true)
	reset()

func reset():
	direction = Vector2.RIGHT
	new_direction = Vector2.RIGHT
	body = [Vector2(10, 10), Vector2(9, 10), Vector2(8, 10)]
	growth = 0
	queue_redraw()

func grow():
	growth += 1

func update_direction(new_dir):
	if new_dir.dot(direction) == 0:
		new_direction = new_dir

func move():
	direction = new_direction
	var head = body[0] + direction

	if head.x < 0 or head.x >= 32 or head.y < 0 or head.y >= 16:
		print("Snake head is out of bounds! Position: ", head)
		return

	body.insert(0, head)
	if growth > 0:
		growth -= 1
	else:
		body.pop_back()
	queue_redraw()
	print("Snake moved to: ", body)

func _process(delta):
	move()

func _draw():
	for segment in body:
		draw_rect(Rect2(segment * 10, Vector2(10, 10)), Color(0, 1, 0))
