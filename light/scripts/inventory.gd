extends Node2D


var inventory:= ["Flashlight1"]
var isInventoryOpen :=true
var shouldLockInventoryOpen := NOTIFICATION_WM_CLOSE_REQUEST

func _ready() -> void:
	refreshInventory()
	
func _physics_process(delta):
		pass
		
func _input(event):
	if Input.is_action_just_pressed("tab") &&shouldLockInventoryOpen:
		var tween = create_tween()
		shouldLockInventoryOpen = true
		if (isInventoryOpen):
			isInventoryOpen = false
			tween.tween_property(self, "position", position + Vector2(0, -64), 0.2)
		else:
			isInventoryOpen = true
			tween.tween_property(self, "position", position + Vector2(0, -64), 0.2)
		await get_tree().create_timer(.5).timeout
		
		shouldLockInventoryOpen = false
		
func _on_player_update_inventory(itemdId):
	inventory.push_back(itemdId)
	refreshInventory()
	
func refreshInventory():
	for item in inventory:
		var spaceBetweenItems = 50
		var node  = get_node_and_resource(item)
		var index = inventory.find(item)
		
		node[0] = Vector2((index) * spaceBetweenItems *10, 10)
	
