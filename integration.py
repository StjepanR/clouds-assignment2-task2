import math

def function(x):
	return abs(math.sin(x))

def compute(lower, upper, N):
	integral = 0
	step = (float(upper) - float(lower)) / N
	for i in range(N):
		xip12 = step * (float(i) + 0.5)
		di = function(xip12) * step

		integral += di

	return integral

def compute_all(lower, upper):
	N = [10, 100, 1000, 10000, 100000, 1000000]

	results = []

	for n in N:

		integral = compute(lower, upper, n)

		results.append(integral)

	return results