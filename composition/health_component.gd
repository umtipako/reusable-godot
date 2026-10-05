class_name HealthComponent
extends Node

@export var MAX_HEALTH: int = 1
var health: int 

signal damaged 
signal healed
signal died

func _ready() -> void:
	health = MAX_HEALTH

func damage(h: int = 1) -> void:
	health = max(health - h, 0)
	damaged.emit()
	if health <= 0:
		died.emit()

func heal(h: int = 1) -> void:
	health = min(health + h, MAX_HEALTH)
	
	healed.emit()
