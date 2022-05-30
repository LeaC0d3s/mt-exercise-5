#! /bin/env/python


import matplotlib.pyplot as plt

import argparse


def plot_models(bleu, beam):


	# x-coordinates of left sides of bars
	left = range(len(beam))

	# heights of bars
	height = bleu

	# labels for bars
	tick_label = beam



	# plotting a bar chart
	plt.bar(left, height, tick_label = tick_label,
			width = 0.8, bottom=0)

	# naming the x-axis
	plt.xlabel('Beam-Size')
	# naming the y-axis
	plt.ylabel('BLEU-Score')
	# plot title
	plt.title('Relation between Beam-Size and BLEU score')

	# function to show the plot
	plt.savefig("beam_translations/Beam-Bleu-Plot.png")
	plt.show()

if __name__ == "__main__":
	parser = argparse.ArgumentParser(description='## BEAM-BLEU Plotter ##')
	parser.add_argument('--score_file', help='file with all the resulting Bleu scores', required=True)
	parser.add_argument('--beam_sizes', help='List of Beamsizes, in the same order the BLEU file was created', nargs="+", required=True)

	args = parser.parse_args()

	src = open(args.score_file, 'r')
	srcData = src.readlines()
	scores = []
	for score in srcData:
		score = score.strip('\n')
		if len(score) > 0:
			scores.append(float(score))


	#print(type(srcData))
	#print(scores)
	#print((type(args.beam_sizes)))
	#print(args.beam_sizes)

	plot_models(scores, args.beam_sizes)
