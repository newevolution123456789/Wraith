extends CharacterBody2D




const SPEED = 130.0
const JUMP_VELOCITY = -300.0
var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health =  100
var player_alive  = true
@onready var score: Label = $"../Score"
@onready var keys_label: Label = %Keys_label
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D



var key_counter = 0
func _physics_process(delta: float) -> void:
	enemy_attack()
	
	if health <= 0:
		player_alive = false
		get_tree().reload_current_scene()
		health  = 0
		print("player has been killed")
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
 
func set_key(new_key_count: int) -> void:
	key_counter = new_key_count
	keys_label.text = "Key Count: " + str(key_counter)
	move_and_slide()
 

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("key"):
		set_key(key_counter + 1)
		print(key_counter)

func player():
	pass


func _on_player_hitbox_body_entered(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = true

func _on_player_hitbox_body_exited(body: Node2D) -> void:
	if body.has_method("enemy"):
		enemy_in_attack_range = false
		
		
func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown == true:
		health  = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)	


func _on_attack_cooldown_timeout() -> void:
	enemy_attack_cooldown = true


func _on_restart_pressed() -> void:
	pass # Replace with function body.
