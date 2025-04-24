@tool
extends SubViewport

@export var sub_viewport: SubViewport
@export var navigation_region: NavigationRegion2D

func _process(delta):
	if not sub_viewport or not navigation_region:
		return

	var bounds = navigation_region.get_navigation_polygon().get_bounds()
	sub_viewport.size = bounds.size
