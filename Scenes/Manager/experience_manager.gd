extends Node

var current_experience = 0

func _ready():
    GameEvents.exp_vial_collected.connect(on_experience_vial_collected)

func increment_experience(number: float):
    current_experience += number
    print("Experience: ", current_experience)
    
func on_experience_vial_collected(number: float):
    print("Signal received")
    increment_experience(number)
    