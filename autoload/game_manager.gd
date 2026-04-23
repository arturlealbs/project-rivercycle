extends Node

var velocidade_global: float = 4.0
var lixo_coletado: int = 0
var vida: int = 3

func reset():
	velocidade_global= 4.0
	lixo_coletado = 0
	vida = 3

func aumentar_dificuldade(valor: float):
	velocidade_global += valor
