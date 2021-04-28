extends Node

const SlotClass = preload("res://src/Inventory/Slot.gd")
const ItemClass = preload("res://src/Items/Item.gd")
const NUM_INVENTORY_SLOTS = 20

var inventory = {
	0: ["Red Gem", 2], # slot_index: [item_name, irem_quantity] 
	2: ["Pink Gem", 1], # slot_index: [item_name, irem_quantity]
	4: ["Orange Gem", 3], # slot_index: [item_name, irem_quantity]
	6: ["Health", 1], # slot_index: [item_name, irem_quantity] 
	8: ["Blue Gem", 3], # slot_index: [item_name, irem_quantity] 
	10: ["Half Health", 2] # slot_index: [item_name, irem_quantity]
}

func add_item(item_name, item_quantity):
	for item in inventory:
		if inventory[item][0] == item_name:
			var stack_size = int(JsonData.item_data[item_name]["StackSize"])
			var able_to_add = stack_size - inventory[item][1]
			if able_to_add >= item_quantity:
				inventory[item][1] += item_quantity
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				return
			else:
				inventory[item][1] += able_to_add
				update_slot_visual(item, inventory[item][0], inventory[item][1])
				item_quantity = item_quantity - able_to_add
	
	# Item doesn't exist in inventory yet so add it to an empty slot
	for i in range(NUM_INVENTORY_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [item_name, item_quantity]
			update_slot_visual(i, inventory[i][0], inventory[i][1])
			return 

func update_slot_visual(slot_index, item_name, new_quantity):
	var slot = get_tree().root.get_node("/root/LevelOne/InventoryScreen/InventoryInterface/Inventory/GridContainer/Slot" + str(slot_index + 1))
	
	if slot.item != null:
		slot.item.set_item(item_name, new_quantity)
	else:
		slot.initialize_item(item_name, new_quantity)

func remove_item(slot: SlotClass):
	inventory.erase(slot.slot_index)

func add_item_to_empty_slot(item: ItemClass, slot: SlotClass):
	inventory[slot.slot_index] = [item.item_name, item.item_quantity]


func add_item_quantity(slot:SlotClass, quantity_to_add: int):
	inventory[slot.slot_index][1] += quantity_to_add
