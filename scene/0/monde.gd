extends MarginContainer


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	#update_size()


func update_size() -> void:
	var x = Global.num.size.continent.col
	var y = Global.num.size.continent.row
	custom_minimum_size = Vector2(x, y) * Global.num.size.domaine.d
