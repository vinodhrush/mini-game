extends CanvasLayer

@onready var shooting_label: Label = $BulletCounter/VBoxContainer/Label
@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

func _ready():
	Globals.connect("health_change", update_health_txt)
	update_ammo_text()
	health_bar.value = Globals.health

func update_ammo_text():
	shooting_label.text = str(Globals.ammo_amount)

func update_health_txt():
	health_bar.value = Globals.health
