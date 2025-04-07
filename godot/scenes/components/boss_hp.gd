extends CenterContainer



@onready var name_label = %Name
@onready var hp_label = %Hp


func set_display(boss_name: String, boss_hp: int):
	name_label.text = boss_name
	hp_label.text = str(boss_hp)
	if boss_name == "Limbo":
		hp_label.text = str(boss_hp - 0.4)
