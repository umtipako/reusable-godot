## Object Pool implementation that's designed to use as a global PoolManager
## 
## Simply try to acquire a Node from a scene pool, it will instantiate it if 
## the pool is empty and populate the pool specific to that scene 
## when you release that node. Don't forget that pool is not populated until
## you release the acquired node.
##
## This implementation is for self-populating object pools that grow.
## For example: a 3 bullet pool would be enough for your gameplay at first,
## but if that changes with power-ups etc. you may need a 5 object pool later.
## Pool expands itself and becomes a 5 object pool and carries on like that.
## If that extra overhead is too much for you (ex. a specific mobile game)
## you can modify the code to support pre-existing pools or add pool specific
## clearing methods.

class_name Pool
extends Node

var _pools: Dictionary = {}  

func acquire(scene: PackedScene) -> Node:
	var arr: Array = _pools.get(scene, [])
	print(arr)
	var obj: Node = arr.pop_back() if not arr.is_empty() else scene.instantiate()
	obj.set_meta("pool_scene", scene)
	return obj

func release(obj: Node) -> void:
	if obj.get_parent():
		obj.get_parent().remove_child(obj)
	_pools.get_or_add(obj.get_meta("pool_scene"), []).push_back(obj)
	print(_pools.get(obj.get_meta("pool_scene")))

func clear_all() -> void:  
	for arr in _pools.values():
		for obj in arr:
			obj.free()
	_pools.clear()
