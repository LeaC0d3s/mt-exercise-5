#! /bin/env/python

import argparse
import random

parser = argparse.ArgumentParser(description='## CORPUS Subsampler ##')
parser.add_argument('-src', help='sorce language corpus to shuffle and sample', required=True)
parser.add_argument('-tgt', help='target language corpus to shuffle and sample', required=True)

args = parser.parse_args()

src = open(args.src, 'r')
tgt = open(args.tgt, 'r')

srcData = src.readlines()
tgtData = tgt.readlines()

random.seed(7)  # same seed for both files (to save the alignment)
random.shuffle(srcData)

# only keep first 100'000 sentences from the shuffled source corpus
srcData = srcData[0:100000]
random.seed(7)  # same seed for both files (to save the alignment)
random.shuffle(tgtData)
# only keep first 100'000 sentences from the shuffled target corpus
tgtData = tgtData[0:100000]



with open("scripts/../data/train.de-en_sub.de", 'w') as f1:
    f1.writelines(srcData)
with open("scripts/../data/train.de-en_sub.en", 'w') as f2:
    f2.writelines(tgtData)

src.close()
tgt.close()