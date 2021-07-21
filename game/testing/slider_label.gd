extends Label

func _process(delta):
	text = "Theta: " + str($theta_slider.value) + "\n\n" + "Phi: " + str($phi_slider.value)
