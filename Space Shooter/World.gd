extends Node

var score = 0 setget set_score

onready var scoreLabel = $ScoreLabel

func set_score(value):
	score = value
	scoreLabel.text = "Score =" + str(score)

#func _on_Enemy_score_up(): replaced with setget
#	self.score += 10
