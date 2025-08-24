@tool
extends GaeaNodeResource
class_name GaeaNodeRulesPlacer
## Places [param material] on every world cell that follows [param rules] based on [param reference_data].
## [img]res://addons/gaea/assets/cross.svg[/img] means data DOESN'T have a cell there,
## [img]res://addons/gaea/assets/check.svg[/img] means the opposite.
##
## For every cell in the generation area, it checks that it follows [param rules]. If it does,
## it places [param material] in that cell.[br]
## The outlined cell is the origin. Every other cell around it is in an offset from said cell.
## You can also think about it as the outlined cell having an offset of [code](0,0)[/code].[br]
## For every offset:[br]
## - If the editor has no icon, that offset has no rule. It is ignored.[br]
##     - If the offset is marked as [img]res://addons/gaea/assets/check.svg[/img], that offset has to have a corresponding cell in [param reference_data] to qualify as "following the rules".[br]
##     - If the offset is marked as [img]res://addons/gaea/assets/cross.svg[/img], it's the opposite.[br]
## If a cell doesn't follow all the rules for each offset, it won't qualify. Otherwise, the outputted [param map]
## will have [param material] there.


func _get_title() -> String:
	return "RulesPlacer"


func _get_description() -> String:
	return "Places [param material] on every world cell that follows [param rules] based
on [param reference_data].\n[img]res://addons/gaea/assets/cross.svg[/img] means data DOESN'T have a cell there,\
 [img]res://addons/gaea/assets/check.svg[/img] means the opposite."


func _get_arguments_list() -> Array[StringName]:
	return [&"reference_data", &"material", &"rules"]


func _get_argument_type(arg_name: StringName) -> GaeaValue.Type:
	match arg_name:
		&"reference_data": return GaeaValue.Type.DATA
		&"material": return GaeaValue.Type.MATERIAL
		&"rules": return GaeaValue.Type.RULES
	return super(arg_name)


func _get_output_ports_list() -> Array[StringName]:
	return [&"map"]


func _get_output_port_type(_output_name: StringName) -> GaeaValue.Type:
	return GaeaValue.Type.MAP


func _get_required_arguments() -> Array[StringName]:
	return [&"reference_data", &"material"]


func _get_data(_output_port: StringName, area: AABB, graph: GaeaGraph) -> Dictionary[Vector3i, GaeaMaterial]:
	var grid_data: Dictionary = _get_arg(&"reference_data", area, graph)
	var material: GaeaMaterial = _get_arg(&"material", area, graph)
	var rng := define_rng(graph)
	var grid: Dictionary[Vector3i, GaeaMaterial]

	var rules: Dictionary = _get_arg(&"rules", area, graph)

	material = material.prepare_sample(rng)
	if not is_instance_valid(material):
		material = _get_arg(&"material", area, graph)
		_log_error(
			"Recursive limit reached (%d): Invalid material provided at %s" % [GaeaMaterial.RECURSIVE_LIMIT, material.resource_path],
			graph,
			graph.resources.find(self)
		)
		return grid

	for x in _get_axis_range(Vector3i.AXIS_X, area):
		for y in _get_axis_range(Vector3i.AXIS_Y, area):
			for z in _get_axis_range(Vector3i.AXIS_Z, area):
				var place: bool = true
				var cell: Vector3i = Vector3i(x, y, z)
				for offset: Vector2i in rules:
					var offset_3d: Vector3i = Vector3i(offset.x, offset.y, 0)
					if _is_point_outside_area(area, cell + offset_3d):
						place = false
						break

					if (grid_data.get(cell + offset_3d) != null) != rules.get(offset):
						place = false
						break
				if place:
					grid.set(cell, material.execute_sample(rng, grid_data.get(cell, 0.0)))

	return grid
