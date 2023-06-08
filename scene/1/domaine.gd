extends Node2D


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	var grid = parent.vec.grid + Vector2.ONE * 0.5
	position = grid * Global.num.size.domaine.d
	visible = parent.flag.onscreen
	update_label()


func update_label() -> void:
	var reserve = parent.obj.continent.num.domaine.reserve
	var size = Global.num.size.continent
	var index = size.col * parent.vec.grid.y + parent.vec.grid.x
	$Label.text = str(index)
