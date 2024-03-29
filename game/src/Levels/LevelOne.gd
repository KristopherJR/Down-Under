extends Node2D

signal cave_exited(spawn_at)

var max_air: = 150.0
var air_timer: = max_air #air timer set to 2:30 minutes (150 seconds)
var inverse_air_timer: = 0.0

var playing_time_up_music: = false


func _ready() -> void:
	$AudioStreamPlayer.play(0.0) #play the song at the start of the level
	_connect_coins()
	_connect_ores()
	_connect_gems()
	$PlayerHUD/CoinHUD/CoinCounter/value_label.text = String(GlobalLevelData.coin_total)
	
func _connect_coins():
	var coins = get_tree().get_nodes_in_group("coins")
	for coin in coins:
		coin.connect("picked_up", self, "_on_coin_pickup")
		
func _on_coin_pickup():
	GlobalLevelData.coin_total += 1
	
	$PlayerHUD/CoinHUD/CoinCounter/value_label.text = String(GlobalLevelData.coin_total)
	
func _connect_ores():
	var ores = get_tree().get_nodes_in_group("ores")
	for ore in ores:
		ore.connect("ore_break", self, "_on_ore_break")	
	
func _on_ore_break():
	GlobalLevelData.coin_total += 10
	$PlayerHUD/CoinHUD/CoinCounter/value_label.text = String(GlobalLevelData.coin_total)
	$OreBreakEffect.play(0.0)

func _connect_gems():
	var gems = get_tree().get_nodes_in_group("gems")
	for gem in gems:
		gem.connect("gem_collected", self, "_on_gem_collect")	
	
func _on_gem_collect():
	$GemCollectSFX.play(0.0)

func _calculate_time_string() -> String:
	var minutes = air_timer / 60
	var seconds = fmod(air_timer, 60)
	
	var time_string:= "%02d:%02d" % [minutes,seconds] #formatting the String
	
	return  time_string

func _calculate_oxygen_percentage():
	var percentage: = int((air_timer / max_air) * 100)
	var inverse_percentage: = int((inverse_air_timer / max_air) * 100)
	$PlayerHUD/OxygenHUD/ProgressBar.value = percentage
	
	var red_color_increment = 67 + (inverse_percentage * 1.83)
	var green_color_decrement = (percentage * 2.5) + 25
	
	var new_color: = Color8(red_color_increment,green_color_decrement,19,255)
	if percentage < 15 && playing_time_up_music == false:
		playing_time_up_music = true
		$AudioStreamPlayer.stop()
		$TimeRunningOutMusic.play(0.0)
		
	get_node("PlayerHUD").shift_color(new_color)
	
func _update_heart_HUD():
	if $Player.health == 3.0:
		$PlayerHUD/HealthHUD/HeartIcon3.texture = load("res://du_assets/textures/health_icon/heart_full.png")
	if $Player.health == 2.5:
		$PlayerHUD/HealthHUD/HeartIcon3.texture = load("res://du_assets/textures/health_icon/heart_half.png")
	if $Player.health == 2.0:
		$PlayerHUD/HealthHUD/HeartIcon3.texture = load("res://du_assets/textures/health_icon/heart_empty.png")
	if $Player.health == 1.5:
		$PlayerHUD/HealthHUD/HeartIcon2.texture = load("res://du_assets/textures/health_icon/heart_half.png")
	if $Player.health == 1.0:
		$PlayerHUD/HealthHUD/HeartIcon2.texture = load("res://du_assets/textures/health_icon/heart_empty.png")
	if $Player.health == 0.5:
		$PlayerHUD/HealthHUD/HeartIcon1.texture = load("res://du_assets/textures/health_icon/heart_half.png")
	if $Player.health == 0.0:
		$PlayerHUD/HealthHUD/HeartIcon1.texture = load("res://du_assets/textures/health_icon/heart_empty.png")
	
func _physics_process(delta: float) -> void:
	if air_timer > 0:
		air_timer -= delta
		inverse_air_timer += delta
		$PlayerHUD/OxygenHUD/TimeLeftLabel.text = _calculate_time_string()
		_calculate_oxygen_percentage()
	if air_timer <= 0:
		get_node("Player").queue_free() #kill the player when they run out of time
		get_tree().change_scene("res://src/Screens/GameOverScreen.tscn")
		GlobalLevelData.coin_total = 0
		
	_update_heart_HUD()

func _on_AudioStreamPlayer_finished() -> void:
	if playing_time_up_music == false:
		$AudioStreamPlayer.play(0.0) #loops the song when it's finished

func _on_MusicFadeArea_body_entered(_body: Node) -> void:
	$AnimationPlayer.play("music_fade_in")
	GlobalLevelData.spawn_location = Vector2(1621.298,1050.185)
	GlobalLevelData.temp_flip = true


func _on_TimeRunningOutMusic_finished() -> void:
	if playing_time_up_music == true:
		$AudioStreamPlayer.play(0.0) #loops the song when it's finished
