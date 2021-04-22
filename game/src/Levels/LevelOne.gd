extends Node2D

var max_air: = 12.0
var air_timer: = max_air #air timer set to 2 minutes (120 seconds)
var inverse_air_timer: = 0.0

var coin_score: = 0

func _ready() -> void:
	$AudioStreamPlayer.play(0.0) #play the song at the start of the level
	connect_coins()
	
func connect_coins():
	var coins = get_tree().get_nodes_in_group("coins")
	for coin in coins:
		coin.connect("picked_up", self, "_on_coin_pickup")
		
func _on_coin_pickup():
	coin_score += 1
	$PlayerHUD/CoinHUD/CoinCounter/value_label.text = String(coin_score)
	
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
	
	get_node("PlayerHUD").shift_color(new_color)
	
	
func _physics_process(delta: float) -> void:
	if air_timer > 0:
		air_timer -= delta
		inverse_air_timer += delta
		$PlayerHUD/OxygenHUD/TimeLeftLabel.text = _calculate_time_string()
		_calculate_oxygen_percentage()
	if air_timer <= 0:
		get_node("Player").queue_free() #kill the player when they run out of time
		get_tree().change_scene("res://src/Screens/GameOverScreen.tscn")

func _on_AudioStreamPlayer_finished() -> void:
	$AudioStreamPlayer.play(0.0) #loops the song when it's finished

func _on_MusicFadeArea_body_entered(_body: Node) -> void:
	$AnimationPlayer.play("music_fade_in")
