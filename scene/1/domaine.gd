extends Node2D


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	position = parent.vec.grid
	
	if parent.obj.continent != null:
		position += parent.obj.continent.vec.offset
		visible = parent.flag.onscreen
		update_label()
	
	if parent.obj.palette != null:
		position += parent.obj.palette.vec.offset


func update_label() -> void:
	var size = Global.num.size.continent
	var index = size.col * parent.vec.grid.y + parent.vec.grid.x
	$Label.text = str(index)
