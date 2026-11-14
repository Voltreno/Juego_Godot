extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Conectamos los botones usando los nombres exactos de tu árbol de nodos
	$VBoxContainer/BtnJugar.pressed.connect(_on_btn_jugar_pressed)
	$VBoxContainer/BtnSalir.pressed.connect(_on_btn_salir_pressed)

func _on_btn_jugar_pressed() -> void:
	# Cambia a tu escena del juego (verifica que el nombre del archivo .tscn coincida)
	get_tree().change_scene_to_file("res://main.tscn")

func _on_btn_salir_pressed() -> void:
	get_tree().quit()
	get_tree().quit()
