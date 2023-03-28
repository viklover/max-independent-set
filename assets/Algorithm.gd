extends Object

class_name Algorithm

static func get_neighbors_count(graph, node):
	return graph[node].size()

static func find(graph: Dictionary):
	var independent_set = []
	
	var tree = graph.duplicate(true)
	var nodes = tree.keys()

	while nodes.size() > 0:
		# выбираем вершину с максимальным количеством смежных вершин
		var max_node = -1
		var max_neighbors = -1
		for node in nodes:
			var neighbors_count = get_neighbors_count(tree, node)
			if neighbors_count > max_neighbors:
				max_node = node
				max_neighbors = neighbors_count
		independent_set.append(max_node)
		for node in tree[max_node]:
			if nodes.has(node):
				nodes.erase(node)
				for neighbor in tree[node]:
					if nodes.has(neighbor):
						tree[neighbor].erase(max_node)

		nodes.erase(max_node)

	return independent_set
