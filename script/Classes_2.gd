extends MarginContainer


#палитра palette
class Palette:
	var arr = {}
	var obj = {}
	var vec = {}
	var dict = {}
	var scene = {}


	func _init(input_: Dictionary):
		vec.offset = Vector2.ONE * 0.5 * Global.num.size.domaine.d
		obj.monde = input_.monde
		init_scene()
		init_piliers()
		init_domaine()
		roll_terrain()


	func init_scene() -> void:
		scene.myself = Global.scene.palette.instantiate()
		scene.myself.set_parent(self)
		obj.monde.scene.myself.get_node("HBox").add_child(scene.myself)


	func init_piliers() -> void:
		arr.pilier = []
		var n = 2
		
		for _i in n:
			arr.pilier.append([])
			
			for _j in n:
				var input = {}
				input.grid = Vector2(_j, _i)
				input.continent = null
				input.palette = self
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
							input.palette = self
							input.continent = null
							input.piliers = [pilier, neighbor_pilier] 
							var frontière = Classes_1.Frontière.new(input)
							
							if !dict.frontière.has(pilier):
								dict.frontière[pilier] = {}
							
							if !dict.frontière.has(neighbor_pilier):
								dict.frontière[neighbor_pilier] = {}
							
							dict.frontière[pilier][neighbor_pilier] = frontière
							dict.frontière[neighbor_pilier][pilier] = frontière
		
#		for pilier in dict.frontière:
#			if dict.frontière.has(pilier):
#				for neighbor_pilier in dict.frontière[pilier]:
#					var frontière = dict.frontière[pilier][neighbor_pilier]
#					print(frontière, frontière.arr.pilier)
		#print(arr.pilier)


	func init_domaine() -> void:
		var input = {}
		input.palette = self
		input.grid = Vector2()
		input.continent = null
		obj.domaine = Classes_1.Domaine.new(input)


	func roll_terrain() -> void:
		#var grid_center = Vector2(Global.num.size.continent.row / 2, Global.num.size.continent.col / 2)
		#var center_domaine = arr.domaine[grid_center.y][grid_center.x]
		obj.domaine.set_terrain()


