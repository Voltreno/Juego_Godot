extends CharacterBody2D
@export var velocidad: float = 550.0

var direccion: Vector2 = Vector2.ZERO

# Contador para llevar la cuenta de cuántas veces ha caído la pelota
var caidas: int = 0

@onready var posicion_inicial: Vector2 = global_position
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
		posicion_inicial = global_position
		resetear_bola()
		
func _physics_process(delta: float) -> void:
		velocity = direccion * velocidad
		var colision = move_and_collide(velocity * delta)
		
		if colision:
			var collider = colision.get_collider()
			
			# IMPRIME QUÉ ESTÁ TOCANDO LA BOLA
			print("La bola chocó contra: ", collider.name, " | ¿Es de la clase?: ", collider.get_class())
			
			if collider and collider.is_in_group("bloques"):
				print("-> ¡El objeto está en el grupo 'bloques'!")
				if collider.has_method("destruir"):
					print("-> ¡Tiene la función destruir(), ejecutando...")
					collider.destruir()
				else:
					print("-> ERROR: El bloque NO tiene la función 'destruir'")
			else:
				print("-> El objeto chocó, pero NO pertenece al grupo 'bloques'")
			
			direccion = direccion.bounce(colision.get_normal())
		
		# Cálculo correcto del radio de la bola usando el sprite o región
		var radio_bola = 16.0
		if sprite_2d and sprite_2d.texture:
			var ancho_sprite = sprite_2d.texture.get_width() * sprite_2d.scale.x
			if sprite_2d.region_enabled:
				ancho_sprite = sprite_2d.region_rect.size.x * sprite_2d.scale.x
			radio_bola = ancho_sprite / 2.0
		
		var ancho_pantalla_actual = get_viewport_rect().size.x
		var alto_pantalla_actual = get_viewport_rect().size.y
		
		if position.x <= radio_bola:
				position.x = radio_bola
				direccion.x *= -1.0	
		elif position.x >= ancho_pantalla_actual - radio_bola:
				position.x = ancho_pantalla_actual - radio_bola
				direccion.x *= -1.0	
		if position.y <= radio_bola:
				position.y = radio_bola
				direccion.y *= -1.0	
				
		# Detección de caída al fondo de la pantalla
		if position.y >= alto_pantalla_actual + 30:
			registrar_caida()

func registrar_caida() -> void:
		caidas += 1
		print("¡Pelota caída! Caídas acumuladas: ", caidas)
		
		if caidas >= 3:
			print("¡Derrota! La pelota ha caído 3 veces. Cambiando a derrota...")
			get_tree().change_scene_to_file("res://derrota.tscn")
		else:
			resetear_bola()

func resetear_bola() -> void:
		global_position = posicion_inicial
		direccion = Vector2(1, -1).normalized()
		print("¡Reseteando posición de la bola...")
			
	
