extends Camera2D

var amplitude = 0
var priority = 0
var frequency = 0
var shaking:= false

func _ready():
	Events.connect("shake", self, "start")

func start(duration_: float = 0.2, frequency_: float = 15, amplitude_:float = 16, priority_ = 0):
	if (priority >= self.priority):
		priority = amplitude_
		amplitude = amplitude_
		frequency = 1.0 / frequency_
		shaking = true
		_new_shake()
		
		yield(get_tree().create_timer(duration_), "timeout")
		_reset()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)

	var shake_tween = create_tween()
	shake_tween.tween_property(self, "offset", rand, self.frequency)
	yield(shake_tween, "finished")
	if shaking:
		_new_shake()

func _reset():
	shaking = false
	var reset_tween = create_tween()
	reset_tween.tween_property(self, "offset", Vector2.ZERO, self.frequency*2)
	priority = 0
