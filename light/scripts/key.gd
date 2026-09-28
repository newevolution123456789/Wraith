extends Area2D

var key_score= 0

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	Autoscript.score += 1

	
 
