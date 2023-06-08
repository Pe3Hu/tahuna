extends Node


#земельный участок terres
class Terres:
	var arr = {}
	var num = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		num.index = Global.num.index.terres
		Global.num.index.terres += 1
		arr.vertex = input_.vertexs
		obj.domaine = input_.domaine
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.terres.instantiate()
		obj.domaine.scene.myself.get_node("Terres").add_child(scene.myself)
		scene.myself.set_parent(self)


#область domaine
class Domaine:
	var num = {}
	var obj = {}
	var vec = {}
	var dict = {}
	var flag = {}
	var scene = {}


	func _init(input_):
		obj.continent = input_.continent
		vec.grid = input_.grid
		num.index = Global.num.index.domaine
		Global.num.index.domaine += 1
		dict.neighbor = {}
		flag.onscreen = true
		init_scene()
		init_terres()


	func init_scene() -> void:
		scene.myself = Global.scene.domaine.instantiate()
		obj.continent.scene.myself.get_node("Domaine").add_child(scene.myself)
		scene.myself.set_parent(self)


	func init_terres() -> void:
		dict.terres = {}
		var order = "odd"
		var r = Global.num.size.domaine.r
		var corners = Global.num.size.terres.n
		
		for _i in corners:
			var input = {}
			input.domaine = self
			var _j = (_i + 1) % Global.num.size.terres.n
			var indexs = [_i, _j]
			input.vertexs = []
			input.vertexs.append(Vector2())
			
			for index in indexs:
				var vertex = Global.dict.corner.vector[corners][order][index] * r
				input.vertexs.append(vertex)
			
			var terres = Classes_1.Terres.new(input)
			dict.terres[terres] = Global.arr.windrose[_i]
