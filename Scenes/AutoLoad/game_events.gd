extends Node

signal exp_vial_collected(number: float)

func emit_exp_vial_collected(number: float):
    print("Emitted with value of " + str(number))
    exp_vial_collected.emit(number)
