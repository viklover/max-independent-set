extends Control

class_name Point

signal mouse_hover(point: Point)
signal create_child(point: Point)

@onready
var sprites = {
	'base': preload("res://assets/point/pictures/base.png"),
	'hover': preload("res://assets/point/pictures/hover.png"),
	'selected': preload("res://assets/point/pictures/selected.png")
}

const OFFSET = 48

var sprite: Sprite2D

func _ready():
	sprite = get_node("Sprite")
	

func set_state(state: String):
	sprite.texture = sprites[state]

func _on_mouse_entered():
	mouse_hover.emit(self)

func _on_mouse_exited():
	mouse_hover.emit(null)

func _on_gui_input(event: InputEventMouse):

	if event.is_action('ui_mouse_left'):	
		
		if event.is_pressed():
			set_state('hover')
		else:
			create_child.emit(self.position + event.position, self)
			set_state('base')


