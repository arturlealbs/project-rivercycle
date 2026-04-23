class_name ScrollableItem
extends Area3D

@export var posicao_inicial_z = -70.0
@export var limite_z = 5.0


func _ready() -> void:
	position.x = randf_range(-4, 4)

func _process(delta: float) -> void:
	position.z += GameManager.velocidade_global * delta
	
	if position.z > limite_z:
		resetar_item()

func resetar_item():
	position.z = posicao_inicial_z
	position.x = randf_range(-4, 4)
	show()
