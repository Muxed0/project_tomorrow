extends Label

func _process(delta):
	text = str($zeta_slider.value) + "   " + str($v_slider.value) + "\n\nZeta   V"
