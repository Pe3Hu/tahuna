extends Polygon2D


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	set_polygon(parent.arr.vertex)
	update_color()


func update_color() -> void:
	var max_h = 360.0
	var size = Global.num.size.continent
	var h = float(parent.num.index) / (size.row * size.col * Global.num.size.terres.n)
	var s = 0.25
	var v = 1
	var color_ = Color.from_hsv(h,s,v)
	set_color(color_)
