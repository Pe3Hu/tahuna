extends Node


#континент continent
class Continent:
	var arr = {}
	var num = {}
	var obj = {}
	var dict = {}
	var scene = {}


	func _init(input_):
		num.domaine = {}
		num.domaine.reserve = Global.num.index.domaine
		obj.monde = input_.monde
		init_scene()
		init_piliers()
		init_domaines()
		roll_terrain()


	func init_scene() -> void:
		scene.myself = Global.scene.continent.instantiate()
		scene.myself.set_parent(self)
		obj.monde.scene.myself.get_node("HBox").add_child(scene.myself)


	func init_piliers() -> void:
		arr.pilier = []
		
		for _i in Global.num.size.continent.row + 1:
			arr.pilier.append([])
			
			for _j in Global.num.size.continent.col + 1:
				var input = {}
				input.grid = Vector2(_j, _i)
				input.continent = self
				var pilier = Classes_1.Pilier.new(input)
				arr.pilier[_i].append(pilier)
		
		init_pilier_neighbors()


	func init_pilier_neighbors() -> void:
		dict.frontière = {}
		
		for piliers in arr.pilier:
			for pilier in piliers:
				for direction in Global.dict.neighbor.linear2:
					var grid = pilier.vec.grid + direction
					
					if Global.check_array_has_grid(arr.pilier, grid):
						var neighbor_pilier = arr.pilier[grid.y][grid.x]
						
						if !neighbor_pilier.dict.neighbor.has(pilier):
							var input = {}
							input.continent = self
							input.piliers = [pilier, neighbor_pilier] 
							var frontière = Classes_1.Frontière.new(input)
							
							if !dict.frontière.has(pilier):
								dict.frontière[pilier] = {}
							
							if !dict.frontière.has(neighbor_pilier):
								dict.frontière[neighbor_pilier] = {}
							
							dict.frontière[pilier][neighbor_pilier] = frontière
							dict.frontière[neighbor_pilier][pilier] = frontière


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


	func roll_terrain() -> void:
		var grid_center = Vector2(Global.num.size.continent.row / 2, Global.num.size.continent.col / 2)
		var center_domaine = arr.domaine[grid_center.y][grid_center.x]
		center_domaine.set_terrain()

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
