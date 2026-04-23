extends Node3D

@export var posicao_inicial := -10.0
@export var distancia_entre_objetos := 10.0
@export var is_trash := false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var posicao_inicial := -5
	for child in get_children():
		child.position.z = posicao_inicial
		posicao_inicial -= distancia_entre_objetos
