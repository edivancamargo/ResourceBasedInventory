extends Resource
class_name Inventory

export(Array, Resource) var items = [null,null,null,null,null,null,null,null,null]

var drag_data = null

signal items_changed(indexes)

func set_item(item_idx: int, item: Resource) -> Resource:
	var previous_item = items[item_idx]
	items[item_idx] = item
	# check if we couldn't send the item here instead of the index...
	emit_signal("items_changed", [item_idx])
	return previous_item

func swap_items(item_idx: int, target_idx: int) -> void:
	var targetItem = items[target_idx]
	var item = items[item_idx]
	items[target_idx] = item
	items[item_idx] = targetItem
	emit_signal("items_changed", [item_idx, target_idx])

func remove_item(item_idx: int) -> Resource:
	var previous_item = items[item_idx]
	items[item_idx] = null
	# check if we couldn't send the item here instead of the index...
	emit_signal("items_changed", [item_idx])
	return previous_item
