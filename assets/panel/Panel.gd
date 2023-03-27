extends Control

@onready
var prefab_point = preload("res://assets/point/Point.tscn")

var points_list: Array[Point] = []
var points: Dictionary = {}

var hovered_point: Point = null
var selected_point: Point = null


func _process(delta):
	queue_redraw()

func _draw():
	
	var offset = Vector2(Point.OFFSET, Point.OFFSET)
	
	for parent in points:
		for child in points[parent]:
			draw_line(
				parent.position + offset, 
				child.position + offset, 
				Color.GREEN, 5.0)

func set_hovered_point(point: Point):
	hovered_point = point

func create_point(position, parent_point: Point = null):
	print('create point: ', position)
	
	var point: Point = prefab_point.instantiate()
	point.connect("mouse_hover", Callable(self, "set_hovered_point"))
	point.connect("create_child", Callable(self, "create_point"))
	point.position = Vector2(position)

	points[point] = []
	points_list.append(point)
	
	add_child(point)
	
	if parent_point != null:
		parent_point.set_state('base')
		points[parent_point].append(point)
		print('with parent - ', parent_point)
		
		self.draw_line(Vector2.ZERO, Vector2(500, 500), Color.GREEN, 5.0)


func _on_gui_input(event: InputEventMouse):
	
	if event.is_pressed():
		
		if event.is_action('ui_mouse_left'):
			
			if hovered_point == null:
				create_point(event.position)
			else:
				selected_point = hovered_point
				selected_point.set_state('hovered')
				print('set selected point: ', selected_point)

	else:
		
		if event.is_action('ui_mouse_left'):
			
			if selected_point != null and hovered_point == null:
				create_point(event.position, selected_point)
			
			selected_point = null


func _on_find_button_pressed():
	pass

func _on_clear_button_pressed():
	
	for point in points:
		remove_child(point)
	
	points.clear()
