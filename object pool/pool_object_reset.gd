## Simple abstract PoolObjectReset resource to extend from
## and give custom resets to objects before reuse.

@abstract
class_name PoolObjectReset
extends Resource

@abstract
func reset(obj: Node) -> void
