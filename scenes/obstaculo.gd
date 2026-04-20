extends Area3D

static var velocidade_obstaculo = 4
static var velocidade_lixo = 4
static var nova_posicao = 0
@export var aumento_velocidade = 0.3
@export var posicao_inical = -70
@export var is_trash := false
# Called when the node enters the scene tree for the first time.

func get_new_available_position():
	var possivel_posicao = randf_range(-2, 2)
	while(abs(possivel_posicao - nova_posicao) < 1):
		possivel_posicao = randf_range(-2, 2)
	nova_posicao = possivel_posicao
	return nova_posicao

func _ready() -> void:
	position.x = get_new_available_position()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.z = position.z + velocidade_obstaculo * delta
	if (position.z > 5):
		if is_trash:
			velocidade_lixo = velocidade_lixo + aumento_velocidade
		else:
			velocidade_obstaculo = velocidade_obstaculo + aumento_velocidade
		position.z = posicao_inical
		position.x = get_new_available_position()
		
