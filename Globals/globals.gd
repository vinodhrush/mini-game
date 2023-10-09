extends Node

signal health_change

var ammo_amount = 150
var health = 100:
	get:
		return health
	set(value):
		health = value
		health_change.emit()
