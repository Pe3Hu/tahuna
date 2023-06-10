extends Polygon2D


var parent = null


func set_parent(parent_) -> void:
	parent = parent_
	set_vertexs()
	#update_color()


func set_vertexs() -> void:
	var vertexs = []
	vertexs.append(Vector2())
	
	for pilier in parent.obj.frontière.arr.pilier:
		var vertex = pilier.scene.myself.position - parent.obj.domaine.scene.myself.position
		vertexs.append(vertex)
	
	set_polygon(vertexs)


func update_color() -> void:
	var max_h = 360.0
	var size = Global.num.size.continent
	var h = float(parent.num.index) / (size.row * size.col * Global.num.size.terres.n)
	var s = 0.25
	var v = 1
	var color_ = Color.from_hsv(h,s,v)
	set_color(color_)


func update_color_by_terrain() -> void:
	var max_h = 360.0
	var s = 0.25
	var v = 1
	var h = 0
	
	match parent.word.terrain:
		"jungle":
			h = 210/max_h#120/max_h
		"mountain":
			h = 0/max_h#60/max_h
		null:
			return
	print(parent,parent.word.terrain)
	var color_ = Color.from_hsv(h,s,v)
	set_color(color_)
