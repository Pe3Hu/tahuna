extends Node


func _ready() -> void:
	Global.obj.monde = Classes_0.Monde.new()
	#datas.sort_custom(func(a, b): return a.value < b.value)
	##012


func _input(event) -> void:
	if event is InputEventKey:
		match event.keycode:
			KEY_A:
				pass


func _process(delta_) -> void:
	$FPS.text = str(Engine.get_frames_per_second())
