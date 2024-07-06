extends Camera2D

func _ready():
    make_current()

func _process(delta):
    var player_nodes = get_tree().get_nodes_in_group("player")
    if player_nodes.size() > 0:
        var player = player_nodes[0] as Node2D
        print(player.global_position)
        global_position = player.global_position
        