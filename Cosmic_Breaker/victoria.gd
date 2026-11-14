extends Control

# Asegúrate de ajustar esta ruta si tu botón está dentro de un VBoxContainer u otro nodo
@onready var btn_menu: Button = $btn_menu 

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	btn_menu.pressed.connect(_on_btn_menu_pressed)

func _on_btn_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://Menú_principal.tscn")
