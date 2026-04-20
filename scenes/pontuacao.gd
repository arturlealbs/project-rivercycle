extends Label

var lixo_coletado = 0


func _on_trash_collected(area: Area3D) -> void:
	lixo_coletado += 1
	text = lixo_coletado
	print("Teste")
