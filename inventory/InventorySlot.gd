extends CenterContainer

onready var itemTextureRect = $ItemTextureRect
const emptyInventorySlot = preload("res://assets/items/EmptyInventorySlot.png")
const inventory = preload("res://inventory/Inventory.tres")

func display_item(item: Item):
	if item is Item:
		itemTextureRect.texture = item.texture
	else:
		itemTextureRect.texture = emptyInventorySlot

func get_drag_data(position):
	var item_idx = get_index()
	var item = inventory.remove_item(item_idx)
	if item is Item:
		var data = {}
		data.item = item
		data.item_idx = item_idx
		
		var dragPreview = TextureRect.new()
		dragPreview.texture = item.texture
		set_drag_preview(dragPreview)
		return data
	
func can_drop_data(position, data):
	return data is Dictionary and data.has("item")

func drop_data(position, data):
	var my_item_idx = get_index()
	var my_item = inventory.items[my_item_idx]
	inventory.swap_items(my_item_idx, data.item_idx)
	inventory.set_item(my_item_idx, data.item)
