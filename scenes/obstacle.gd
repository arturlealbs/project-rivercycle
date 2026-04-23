class_name Obstacle
extends ScrollableItem

@onready var break_particles: GPUParticles3D = $GPUParticles3D
@onready var mesh: MeshInstance3D = $MeshInstance3D

func _on_body_entered(body: Node3D) -> void:
	GameManager.vida -= 1
	#break_particles.emitting = true
	hide() 
	if GameManager.vida <= 0:
		GameManager.reset()
		get_tree().reload_current_scene()
	body.update_health(GameManager.vida)
