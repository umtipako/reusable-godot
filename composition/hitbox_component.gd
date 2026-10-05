class_name HitboxComponent extends Area2D

@export var damage: int = 1

signal hit_landed(target: HurtboxComponent)

func inform_hit(target: HurtboxComponent) -> void:
	hit_landed.emit(target)
