extends ColorRect

const inventory = preload("res://inventory/Inventory.tres")

func can_drop_data(position, data):
	return data is Dictionary and data.has("item")

func drop_data(position, data):
	inventory.set_item(data.item_idx, data.item)
