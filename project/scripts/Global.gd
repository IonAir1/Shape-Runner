extends Node

var version = "1.9.4" #Game Version
var state = 0 #current game playing
var switch_to_b = false #signal to switch to game b
var switch_to_c = false #signal to switch to game c
var switch_to_a = false #signal to switch to game a
var switch_to_d = false #signal to switch to game d
var switch_to_e = false #signal to switch to game e
var switch_to_f = false #signal to switch to game f
var switch_to_g = false #signal to switch to game g
var mutate = false #is mutating
var score = 0 #score
var bestscore = 0 #highscore
var new = false # new player shape
var dev = false #is testing
var end = false #game end
var score_file = "user://score.save" #score save file
var settings_file = "user://settings.save" #settings save file
var guide = true #show guide
var sounds = true #sounds
var music = true #music
var graphics = true #fancy graphics
var death_fade = false #sound the death fade


func load_settings():
	var file = File.new()
	if file.file_exists(settings_file):
		file.open(settings_file, File.READ)
		var load_dict = file.get_var()
		sounds = load_dict["sounds"]
		music = load_dict["music"]
		guide = load_dict["guide"]
		graphics = load_dict["graphics"]
		file.close()
	else:
		sounds = true
		music = true
		guide = true
		graphics = true

func save_settings():
	var save_dict = {
	"sounds": sounds,
	"music" : music,
	"guide": guide,
	"graphics": graphics,
	}
	var file = File.new()
	file.open(settings_file, File.WRITE)
	file.store_var(save_dict)
	file.close()

func load_score():
	var file = File.new()
	if file.file_exists(score_file):
		file.open(score_file, File.READ)
		bestscore = file.get_var()
		file.close()
	else:
		bestscore = 0

func save_score():
	var file = File.new()
	file.open(score_file, File.WRITE)
	file.store_var(bestscore)
	file.close()

func _process(delta):
	if mutate: #signal all about mutation
		mutate = false
		state += 1
		if state == 6:
			switch_to_g = true
		if state == 5:
			switch_to_f = true
		if state == 4:
			switch_to_e = true
		if state == 3:
			switch_to_d = true
		if state == 1:
			switch_to_b = true
		if state == 2:
			switch_to_c = true
		if state == 0:
			switch_to_a = true
	if state > 6: #reset mutation cycle
		state = 0
