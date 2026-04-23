extends CharacterBody3D

@export_group("Movimento")
@export var speed: float = 12.0
@export var horizontal_limit: float = 2.0 # Limite de -2 a 2 no X
@export var smooth_weight: float = 0.15

@export_group("Visual")
@export var rotation_steer: float = 0.4
@export var mesh_node: Node3D # Arraste o modelo do barco para cá no Inspetor
@export var score_label :Label
@export var vida_label :Label

@onready var timer: Timer = $Timer
@onready var camera = get_viewport().get_camera_3d()
@onready var lixo_coletado = 0
@onready var vida = 5

var vida_atual

func _ready() -> void:
	score_label.text = "Lixo: " + str(lixo_coletado)
	vida_label.text = "Vida: " + str(GameManager.vida)

func _physics_process(_delta: float) -> void:
	# 1. Pegar posição 3D do mouse (no plano Z do barco)
	var mouse_pos_2d = get_viewport().get_mouse_position()
	var z_depth = abs(camera.global_position.z - global_position.z)
	var mouse_pos_3d = camera.project_position(mouse_pos_2d, z_depth)
	
	var target_vel_x = 0.0
	var target_rot_z = 0.0
	
	# 2. Lógica Relativa (Problema 2 resolvido)
	# Comparamos se o mouse_3d.x está à frente ou atrás do global_position.x do barco
	var threshold = 0.2 # Pequena margem para evitar trepidação
	
	if mouse_pos_3d.x > global_position.x + threshold:
		target_vel_x = speed
		target_rot_z = -rotation_steer
	elif mouse_pos_3d.x < global_position.x - threshold:
		target_vel_x = -speed
		target_rot_z = rotation_steer
	else:
		target_vel_x = 0.0
		target_rot_z = 0.0
		
	# 3. Limite Horizontal (Problema 1 resolvido)
	# Se estiver no limite e tentando ir além, zeramos a velocidade
	if (global_position.x >= horizontal_limit and target_vel_x > 0) or \
	   (global_position.x <= -horizontal_limit and target_vel_x < 0):
		target_vel_x = 0.0
		target_rot_z = 0.0

	# 4. Aplicação Suave
	velocity.x = lerp(velocity.x, target_vel_x, smooth_weight)
	
	# Rotacionar apenas o visual (mesh) fica mais profissional que o body todo
	if mesh_node:
		mesh_node.rotation.z = lerp_angle(mesh_node.rotation.z, target_rot_z, 0.1)
	else:
		rotation.z = lerp_angle(rotation.z, target_rot_z, 0.1)
	
	move_and_slide()
	
	# 5. Clamp de segurança para garantir que ele não "vaze" o limite por causa do lerp
	global_position.x = clamp(global_position.x, -horizontal_limit, horizontal_limit)

func _input(event: InputEvent) -> void:
	if(Input.is_action_just_pressed("ui_accept")):
		casco_reforcado()
	
func _on_area_3d_area_entered(area: Area3D) -> void:
	if area is Trash:
		area.coletar()
		lixo_coletado += 1
		update_score(lixo_coletado)

		
func casco_reforcado():
	vida_atual = GameManager.vida
	GameManager.vida += 5
	update_health(GameManager.vida)
	timer.start()

func _on_timer_timeout() -> void:
	GameManager.vida = vida_atual
	update_health(GameManager.vida)

func update_health(value):
	vida_label.text = "Vida: " + str(value)
	
func update_score(value):
	score_label.text = "Lixo: " + str(value)


func _on_magnet_area_area_entered(area: Area3D) -> void:
	if area is Trash:
		area.alvo_ima = self 
		
func _on_magnet_area_area_exited(area: Area3D) -> void:
	if area is Trash:
		area.alvo_ima = null
