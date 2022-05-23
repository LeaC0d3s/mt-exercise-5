#! /bin/env/python

import sys
import time
import argparse
import logging

from collections import Counter
from sacremoses import MosesTokenizer
from itertools import chain

#from nltk.tokenize import sent_tokenize
#import nltk
#nltk.download('punkt')


def parse_args():
    parser = argparse.ArgumentParser()

    parser.add_argument("--tokenize", action="store_true", help="Assume input strings are not tokenized yet.", required=False)
    parser.add_argument("--lang", type=str, help="Language code (important for --tokenize)", default="en", required=False)

    args = parser.parse_args()

    return args

def main():

    tic = time.time()

    args = parse_args()

    logging.basicConfig(level=logging.DEBUG)
    logging.debug(args)

    if args.tokenize:
        tokenizer = MosesTokenizer(lang=args.lang)


    lines = sys.stdin.readlines()

    all_tokens = []

    for line in lines:
        if args.tokenize:
            t = tokenizer.tokenize(line)
        else:
            t = line.split()
        all_tokens.append(t)

    # try to free up memory early

    for tokens in all_tokens:
        output_tokens = []
        for token in tokens:
            output_tokens.append(token)

        output_string = " ".join(output_tokens)
        sys.stdout.write(output_string + "\n")

    toc = time.time() - tic

    logging.debug("Time taken: %f seconds" % toc)

if __name__ == '__main__':
    main()
