extends GridContainer

var inventory = preload("res://inventory/Inventory.tres")

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
