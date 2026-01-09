####################################################################
#
#                    DraggableItem Script
#
#   - This script should teach how to make a draggable item -
#
#                        1/9/2026
#
#####################################################################

extends Control
# This script turns a Control node into something you can DRAG

func _ready():
	# VERY IMPORTANT:
	# This tells Godot: "This node DOES want mouse input"
	mouse_filter = Control.MOUSE_FILTER_STOP

	# Debug so you know the script is alive
	print("[DraggableItem] Ready on:", name)

func _get_drag_data(at_position: Vector2):
	# Godot calls this AUTOMATICALLY when:
	# - Mouse is pressed
	# - Mouse moves enough to count as a drag
	print("🔥 [DraggableItem] Drag started")

	# Create a visual preview that follows the mouse
	var preview := duplicate()
	preview.modulate.a = 0.6  # make it slightly transparent
	set_drag_preview(preview)

	# This is the "data payload" sent to slots
	# Could be an object, dictionary, ID, etc.
	return "item"
