extends Node


#континент continent
class Continent:
	var arr = {}
	var num = {}
	var obj = {}
	var scene = {}


	func _init(input_):
		num.domaine = {}
		num.domaine.reserve = Global.num.index.domaine
		obj.monde = input_.monde
		init_scene()
		init_domaines()


	func init_scene() -> void:
		scene.myself = Global.scene.continent.instantiate()
		scene.myself.set_parent(self)
		obj.monde.scene.myself.get_node("HBox").add_child(scene.myself)


	func init_domaines() -> void:
		arr.domaine = []
		
		for _i in Global.num.size.continent.row:
			arr.domaine.append([])
			
			for _j in Global.num.size.continent.col:
				var input = {}
				input.grid = Vector2(_j, _i)
				input.continent = self
				var domaine = Classes_1.Domaine.new(input)
				arr.domaine[_i].append(domaine)
		
		init_domaine_neighbors()


	func init_domaine_neighbors() -> void:
		for domaines in arr.domaine:
			for domaine in domaines:
				for direction in Global.dict.neighbor.linear2:
					var grid = domaine.vec.grid + direction
					
					if Global.check_array_has_grid(arr.domaine, grid):
						var neighbor = arr.domaine[grid.y][grid.x]
						domaine.dict.neighbor[neighbor] = direction


#мир monde
class Monde:
	var arr = {}
	var obj = {}
	var scene = {}


	func _init():
		init_scene()
		init_continent()


	func init_scene() -> void:
		scene.myself = Global.scene.monde.instantiate()
		scene.myself.set_parent(self)
		Global.node.game.get_node("Layer0").add_child(scene.myself)


	func init_continent() -> void:
		var input = {}
		input.monde = self
		obj.continent = Classes_0.Continent.new(input)
