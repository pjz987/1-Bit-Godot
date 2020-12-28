extends Resource
class_name Physics

export (float) var G = 0.01
#export (int) var G = 1

func newtonian_gravity(body1, body2):
	var m1 = body1.MASS
	var m2 = body2.MASS
	var r = pythagorean_theorem(body1, body2)
	return G * ((m1 * m2) / pow(r, 2))

func pythagorean_theorem(body1, body2):
	var x_offset = body1.global_position.x - body2.global_position.x
	var y_offset = body1.global_position.y - body2.global_position.y
	return sqrt(pow(x_offset, 2) + pow(y_offset, 2))
	
