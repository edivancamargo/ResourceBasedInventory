extends CenterContainer

onready var itemTextureRect = $ItemTextureRect
onready var itemAmountLabel = $ItemTextureRect/ITemAmountLabel
const emptyInventorySlot = preload("res://assets/items/EmptyInventorySlot.png")
const inventory = preload("res://inventory/Inventory.tres")

func display_item(item: Item):
	if item is Item:
		itemTextureRect.texture = item.texture
		itemAmountLabel.text = str(item.amount)
	else:
		itemTextureRect.texture = emptyInventorySlot
		itemAmountLabel.text = ""

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
		inventory.drag_data = data
		return data
	
func can_drop_data(position, data):
	return data is Dictionary and data.has("item")

func drop_data(position, data):
	var my_item_idx = get_index()
	var my_item = inventory.items[my_item_idx]

	# stack items
	if my_item is Item and my_item.name == data.item.name:
		my_item.amount += data.item.amount
		inventory.emit_signal("items_changed", [my_item_idx])
	else:
		inventory.swap_items(my_item_idx, data.item_idx)
		inventory.set_item(my_item_idx, data.item)

	inventory.drag_data = null
