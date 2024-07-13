extends Node2D

@onready var label = $Label

func _ready():
    pass

func start(text: String):
    label.text = text
    var tween = create_tween()
    tween.set_parallel()

    # Tween the label's position - move up 16 pixels, slow, then move up 48 more pixels, fast
    tween.tween_property(self, "global_position", global_position + Vector2.UP * 16, 0.4) \
        .set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
    tween.tween_property(self, "scale", Vector2.ONE, 0.4).set_ease(Tween.EASE_OUT) \
        .set_trans(Tween.TRANS_ELASTIC)
    tween.chain()

    tween.tween_property(self, "global_position", global_position + Vector2.UP * 64, 0.3) \
        .set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
    tween.tween_property(self, "scale", Vector2.ZERO, 0.3).set_ease(Tween.EASE_IN) \
        .set_trans(Tween.TRANS_CUBIC)
    tween.chain()

    tween.tween_callback(queue_free)