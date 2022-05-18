extends Node


var state = 0
var switch_to_b = false
var switch_to_c = false
var switch_to_a = false
var switch_to_d = false
var mutate = false
var score = 0
var bestscore = 0
var first = true
var new = false
var dev = false


func _process(delta):
	if mutate:
		mutate = false
		state += 1
		
		if state== 3:
			switch_to_d = true
		if state == 1:
			switch_to_b = true
		if state == 2:
			switch_to_c = true
		if state == 0:
			switch_to_a = true
	if state > 3:
		state = 0
