extends Node

#столб pilier 
class Pilier:
	var obj = {}
	var vec = {}
	var dict = {}
	var scene = {}


	func _init(input_):
		vec.grid = input_.grid
		obj.continent = input_.continent
		dict.neighbor = {}
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.pilier.instantiate()
		obj.continent.scene.myself.get_node("Pilier").add_child(scene.myself)
		scene.myself.set_parent(self)


	func set_terrain() -> void:
		pass


#граница frontière
class Frontière:
	var arr = {}
	var obj = {}
	var word = {}
	var scene = {}


	func _init(input_):
		obj.continent = input_.continent
		arr.pilier = input_.piliers
		arr.terres = []
		word.terrain = null
		set_pilier_as_neighbors()
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.frontière.instantiate()
		obj.continent.scene.myself.get_node("Frontière").add_child(scene.myself)
		scene.myself.set_parent(self)


	func set_pilier_as_neighbors() -> void:
		var directions = []
		var direction = arr.pilier.front().vec.grid - arr.pilier.back().vec.grid
		directions.append(direction)
		direction = arr.pilier.back().vec.grid - arr.pilier.front().vec.grid
		directions.append(direction)
		arr.pilier.front().dict.neighbor[arr.pilier.back()] = directions.front()
		arr.pilier.back().dict.neighbor[arr.pilier.front()] = directions.front()


	func set_terrain() -> void:
		if word.terrain == null:
			for terres in arr.terres:
				if terres.word.terrain != null:
					word.terrain = terres.word.terrain
					scene.myself.update_color_by_terrain()


#земельный участок terres
class Terres:
	var arr = {}
	var num = {}
	var obj = {}
	var word = {}
	var scene = {}


	func _init(input_):
		num.index = Global.num.index.terres
		Global.num.index.terres += 1
		obj.domaine = input_.domaine
		obj.frontière = input_.frontière
		obj.frontière.arr.terres.append(self) 
		word.terrain = null
		init_scene()


	func init_scene() -> void:
		scene.myself = Global.scene.terres.instantiate()
		obj.domaine.scene.myself.get_node("Terres").add_child(scene.myself)
		scene.myself.set_parent(self)


	func set_terrain(terrain_: int) -> void:
		if terrain_ == 0:
			word.terrain = "mountain"
		else:
			word.terrain = "jungle"
		
		scene.myself.update_color_by_terrain()
		obj.frontière.set_terrain()



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
		set_piliers()
		init_terres()


	func init_scene() -> void:
		scene.myself = Global.scene.domaine.instantiate()
		obj.continent.scene.myself.get_node("Domaine").add_child(scene.myself)
		scene.myself.set_parent(self)


	func set_piliers() -> void:
		dict.pilier = {}
		
		for _i in Global.dict.neighbor.zero.size():
			var direction = Global.dict.neighbor.zero[_i]
			var grid = vec.grid + direction
			var pilier = obj.continent.arr.pilier[grid.y][grid.x]
			var index_windrose = _i * 2
			var windrose = Global.arr.windrose[index_windrose]
			dict.pilier[pilier] = windrose


	func init_terres() -> void:
		dict.terres = {}
		
		for _i in dict.pilier.keys().size():
			var input = {}
			input.domaine = self
			var _j = (_i + 1) % dict.pilier.keys().size()
			var indexs = [_i, _j]
			var piliers = []
			
			for index in indexs:
				var pilier = dict.pilier.keys()[index]
				piliers.append(pilier)
			
			input.frontière = obj.continent.dict.frontière[piliers.front()][piliers.back()]
			var terres = Classes_1.Terres.new(input)
			var index_windrose = _i * 2 + 1
			dict.terres[terres] = Global.arr.windrose[index_windrose]


	func set_terrain() -> void:
		var terrains = Global.get_random_element(Global.dict.terrain.index)
		
		for _i in dict.terres.keys().size():
			var terres = dict.terres.keys()[_i]
			terres.set_terrain(terrains[_i])
