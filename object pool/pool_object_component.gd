## Adds an interface to added node that makes it a part of the 
## global object pooling system.
## 
## It still needs to use these
## implementations through orchestrators/spawners etc.
## and instantiate accordingly.

class_name PoolObjectComponent extends Node

## Reset implementation for further usage. Null if not given.
@export var reset_implementation: PoolObjectReset = null
 
## To activate the object after getting it back from pool / 
## creating it for the first time.
func activate() -> void:
	var root := get_parent()
	root.process_mode = Node.PROCESS_MODE_INHERIT
	root.show()
	if reset_implementation: reset_implementation.reset.call_deferred(root)

## To deactivate the object after usage, instead of freeing it.
## Releases it to PoolManager for further usage later.
func deactivate() -> void:
	var root := get_parent()
	root.process_mode = Node.PROCESS_MODE_DISABLED
	root.hide()
	PoolManager.release(root)
