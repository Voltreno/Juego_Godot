extends Node2D

func _process(delta: float) -> void:
	# Contamos cuántos nodos quedan en el grupo "bloques"
	var bloques_restantes = get_tree().get_nodes_in_group("bloque").size()
	
	# Si la cantidad llega a 0, cambiamos a la pantalla de victoria
	if bloques_restantes == 0:
		get_tree().change_scene_to_file("res://victoria.tscn")
