extends Node


var state = 0
var switch_to_flying = 0
var switch_to_swim = 0
var switch_to_run = 0
var switch_to_dive = 0
var mutate = 0
var score = 0
var bestscore = 0
var first = 1
var new = 0
var dev = 0


func _process(delta):
	if mutate == 1:
		mutate = 0
		state += 1
		
		if state== 3:
			switch_to_dive = 1
		if state == 1:
			switch_to_flying = 1
		if state == 2:
			switch_to_swim = 1
		if state == 0:
			switch_to_run = 1
	if state > 3:
		state = 0
