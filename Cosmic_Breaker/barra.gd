extends StaticBody2D
@export var velocidad: float = 600.0

@export var altura_y: float = 580.0

@onready var sprite_2d: Sprite2D = $Sprite2D

var velocidad_actual: float = 0.0

func _physics_process(delta: float) -> void: 
	var direccion := 0.0 
	
	if Input.is_key_pressed(KEY_A) or Input.is_action_pressed("ui_left"):
			direccion -= 1.0
	if Input.is_key_pressed(KEY_D) or Input.is_action_pressed("ui_right"):
			direccion += 1.0
		
	if direccion != 0:
		velocidad_actual = direccion * velocidad
	else:
		velocidad_actual = move_toward(velocidad_actual, 0, velocidad * delta * 10)


	position.x += velocidad_actual * delta
	position.y = altura_y
	
	if sprite_2d and sprite_2d.texture:
			var ancho_barra = sprite_2d.texture.get_width() * sprite_2d.scale.x
			var mitad_barra = ancho_barra / 2.0
			
			var ancho_pantalla = get_viewport_rect().size.x
			
			position.x = clamp(position.x, mitad_barra, ancho_pantalla - mitad_barra)
