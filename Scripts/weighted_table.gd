class_name WeightedTable

var items: Array[Dictionary] = []

func add_item(item, weight: int):
    items.append({"item": item,
        "weight": weight})

func pick_item():
    var total_weight = 0
    for item in items:
        total_weight += item["weight"]
    
    var random_number = randi() % total_weight
    var current_weight = 0
    for item in items:
        current_weight += item["weight"]
        if random_number < current_weight:
            return item["item"]
    
    return null

func get_weight(item):
    for i in range(items.size()):
        if items[i]["item"] == item:
            return items[i]["weight"]
    return 0

func update_weight(item, weight):
    for i in range(items.size()):
        if items[i]["item"] == item:
            items[i]["weight"] = weight
            return