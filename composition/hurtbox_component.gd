class_name HurtboxComponent extends Area2D

signal hit(hitbox: HitboxComponent)

func _on_area_entered(area: Area2D) -> void:
	var hitbox := area as HitboxComponent
	if hitbox == null: return

	hit.emit.call_deferred(hitbox)
	hitbox.inform_hit(self)
