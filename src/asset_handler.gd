extends Node

# GCS - Growing Cycle Speed
# day - 600s
# carrot: 75s - 1200s
# onion: 150s - 900s
# pepper: 120s - 1440s
# potato: 100s - 700s
# salad: 150s - 1050s
# tomat: 60s - 1200s


var plants = {
	"carrot": {
		"src": load("res://assets/loader/plants/carrot/carrot.png"),
		"stages": 16,
		"gcs": 75
	},
	"onion": {
		"src": load("res://assets/loader/plants/onion/onion.png"),
		"stages": 6,
		"gcs": 150
	},
	"pepper": {
		"src": load("res://assets/loader/plants/pepper/pepper.png"),
		"stages": 12,
		"gcs": 120
	},
	"potato": {
		"src": load("res://assets/loader/plants/potato/potato.png"),
		"stages": 7,
		"gcs": 100
	},
	"salad": { 
		"src": load("res://assets/loader/plants/salad/salad.png"),
		"stages": 7,
		"gcs": 150
	},
	"tomat": {
		"src": load("res://assets/loader/plants/tomat/tomat.png"),
		"stages": 20,
		"gcs": 60
	}
}

func _ready():
	pass
