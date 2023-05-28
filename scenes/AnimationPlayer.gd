extends AnimationPlayer

func _on_start():
	# Set the fixed scale for the sprite during the jumping animation
	var character = get_parent()
	var sprite = character.sprite
	var original_scale = sprite.scale
	sprite.scale = original_scale

	# Start the animation
	play("jumping")
