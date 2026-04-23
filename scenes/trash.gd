class_name Trash
extends ScrollableItem

var alvo_ima: Node3D = null
@onready var mesh: MeshInstance3D = $MeshInstance3D

func _process(delta: float) -> void:
	if alvo_ima:
		# Lógica de Ímã: Move em direção ao player no X e Y
		global_position = global_position.lerp(alvo_ima.global_position, 0.07)
	
	# Chama o movimento básico (Z) da classe pai
	super._process(delta)

func coletar():
	GameManager.lixo_coletado += 1
	GameManager.aumentar_dificuldade(0.1)
	alvo_ima = null
	hide() 
	# Aqui você poderia dar play em um som ou partícula
