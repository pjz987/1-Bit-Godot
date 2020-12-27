extends Node

export (int) var G = 1

func gravity(m1, m2, r):
	return G * ((m1 * m2) / pow(r, 2))
