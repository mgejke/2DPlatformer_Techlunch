extends Node

signal shake(duration, frequency, amplitude, priority)

func shake(duration: float = 0.2, frequency: float = 15, amplitude: float = 16, priority: int = 0):
	emit_signal("shake", duration, frequency, amplitude, priority)
