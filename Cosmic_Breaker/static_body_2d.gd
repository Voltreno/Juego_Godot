extends StaticBody2D

func destruir() -> void:
	print("¡Bloque destruido!")
	
	# Imprimimos cuántos bloques quedan en el grupo antes de destruirse
	var total_bloques = get_tree().get_nodes_in_group("bloques").size()
	print("Bloques totales en el grupo antes de borrar este: ", total_bloques)
	
	if total_bloques <= 1:
		print("¡Era el último bloque! Cambiando a victoria...")
		get_tree().change_scene_to_file("res://victoria.tscn")
		
	queue_free()
