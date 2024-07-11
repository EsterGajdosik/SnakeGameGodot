extends Node2D

class_name Game

var snake
var berry

func _ready():
	snake = Snake.new()
	add_child(snake)
	berry = Berry.new()
	add_child(berry)
	set_process(true)
	reset()

func reset():
	snake.reset()
	berry.reset_position()
	set_process(true)
	queue_redraw()

func _process(delta):
	snake.move()
	check_collisions()
	queue_redraw()

func check_collisions():
	if snake.body[0] == berry.berry_position:
		print("Berry collected!")
		snake.grow()
		berry.reset_position()
		queue_redraw()
	if is_collision_with_walls(snake.body[0]):
		print("Collision with wall detected")
		game_over()
	if is_collision_with_self():
		print("Collision with self detected")
		game_over()

func is_collision_with_walls(pos):
	print("Checking wall collision for position: ", pos)
	return pos.x < 0 or pos.x >= 32 or pos.y < 0 or pos.y >= 16

func is_collision_with_self():
	for i in range(1, snake.body.size()):
		if snake.body[0] == snake.body[i]:
			print("Collision with self at segment: ", i)
			return true
	return false

func game_over():
	snake.set_process(false)
	set_process(false)
	print("Game Over! Score: %d" % (snake.body.size() - 3))
	get_tree().quit()

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.keycode:
				KEY_UP:
					snake.update_direction(Vector2.UP)
				KEY_DOWN:
					snake.update_direction(Vector2.DOWN)
				KEY_LEFT:
					snake.update_direction(Vector2.LEFT)
				KEY_RIGHT:
					snake.update_direction(Vector2.RIGHT)

func _draw():
	pass
