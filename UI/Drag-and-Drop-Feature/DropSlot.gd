######################################################################################
#
#                    DropSlot Script
#
#   - This script should teach how to make a SLOT that takes a draggable item -
#
#                        1/9/2026
#
#####################################################################################
extends Control
# This script makes a Control node ACCEPT drops

func _ready():
	# PASS means this node can detect drag-over
	mouse_filter = Control.MOUSE_FILTER_PASS
	print("[DropSlot] Ready on:", name)

func _can_drop_data(_at_position: Vector2, data) -> bool:
	# Godot calls this WHILE dragging over the slot
	print("[DropSlot] Checking data:", data)

	# Only accept items that match what we expect
	return data == "item"

func _drop_data(_at_position: Vector2, _data) -> void:
	# Godot calls this when the mouse is released
	print("✅ [DropSlot] Item dropped successfully!")
