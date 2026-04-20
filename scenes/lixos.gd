extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var posicao_inicial := -5
	for child in get_children():
		child.position.z = posicao_inicial
		posicao_inicial -= 5
		child.is_trash = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
