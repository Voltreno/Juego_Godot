extends Control

@onready var check_vidas: CheckButton = $VBoxContainer/CheckVidas
@onready var slider_volumen: HSlider = $VBoxContainer/HSlider
@onready var btn_volver: Button = $VBoxContainer/BtnVolver

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	# Cargar los valores actuales guardados en Global al abrir la ventana
	check_vidas.button_pressed = Global.vidas_infinitas
	slider_volumen.value = Global.volumen_audio
	
	# Si tu CheckButton quieres que muestre un texto dinámico según el modo:
	actualizar_texto_vidas(Global.vidas_infinitas)
	
	# Conectamos las señales de los controles por código de forma limpia
	check_vidas.toggled.connect(_on_check_vidas_toggled)
	slider_volumen.value_changed.connect(_on_slider_volumen_value_changed)
	btn_volver.pressed.connect(_on_btn_volver_pressed)

# Cuando cambias el estado del CheckButton (infinitas / 3 vidas)
func _on_check_vidas_toggled(toggled_on: bool) -> void:
	Global.vidas_infinitas = toggled_on
	actualizar_texto_vidas(toggled_on)
	if toggled_on:
		print("Modo de vidas: Infinitas")
	else:
		print("Modo de vidas: 3 vidas")

func actualizar_texto_vidas(infinitas: bool) -> void:
	if infinitas:
		check_vidas.text = "Modo: Vidas Infinitas"
	else:
		check_vidas.text = "Modo: 3 Vidas"

# Cuando mueves la barra del volumen
func _on_slider_volumen_value_changed(value: float) -> void:
	Global.volumen_audio = value
	var bus_index = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

# Botón para regresar al menú principal
func _on_btn_volver_pressed() -> void:
	get_tree().change_scene_to_file("res://menu_principal.tscn")
