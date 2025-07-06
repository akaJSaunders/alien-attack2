extends Control

@onready var score = $Score
@onready var lives = $LivesLeft

func set_score_label(new_score):
	score.text = "Score: " + str(new_score)
	
func set_lives_left_label(new_lives_left):
	lives.text = str(new_lives_left)
