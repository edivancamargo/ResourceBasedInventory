extends GridContainer

const inventory = preload("res://inventory/Inventory.tres")

func _ready() -> void:
	inventory.connect("items_changed", self, "on_items_changed")
	update_inventory_display()

func update_inventory_display() -> void:
	for item_idx in inventory.items.size():
		update_inventory_slot_display(item_idx)

func update_inventory_slot_display(item_idx) -> void:
	var inventorySlotDisplay = get_child(item_idx)
	var item = inventory.items[item_idx]
	inventorySlotDisplay.display_item(item)

func on_items_changed(item_indexes: Array):
	for item_idx in item_indexes:
		update_inventory_slot_display(item_idx)

func _unhandled_input(event):
	var releasingItem = event.is_action_released("ui_left_mouse") and inventory.drag_data is Dictionary

	if releasingItem:
		inventory.set_item(inventory.drag_data.item_idx, inventory.drag_data.item)
