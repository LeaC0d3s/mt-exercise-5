# MT Exercise 5: Byte Pair Encoding, Beam Search

This repo is just a collection of scripts showing how to install [JoeyNMT](https://github.com/joeynmt/joeynmt), download
data and train & evaluate models.

# Requirements

- This only works on a Unix-like system, with bash.
- Python 3 must be installed on your system, i.e. the command `python3` must be available
- Make sure virtualenv is installed on your system. To install, e.g.

    `pip install virtualenv`

# Steps

Clone this repository in the desired place:

    git clone https://github.com/LeaC0d3s/mt-exercise-5.git

Create a new virtualenv that uses Python 3. Please make sure to run this command outside of any virtual Python environment:

    ./scripts/make_virtualenv.sh

**Important**: Then activate the env by executing the `source` command that is output by the shell script above.

Download and install required software:

    ./scripts/download_install_packages.sh

Download data:

    ./scripts/download_iwslt_2017_data.sh

## Subsample training data and Tokenize all Data (Translation direction de-en)

    ./scripts/tokenize_data.sh
    
### Preprocessing BPE with vocab: 2000 and vocab: 4000

    ./scripts/preprocess_2000_bpe.sh
    
    ./scripts/preprocess_4000_bpe.sh

Train a model: (open script and select manually which model_name variable you want to train on: _wordlevel, _2000_bpe or _4000_bpe) Then let it run:

    ./scripts/train.sh

The training process can be interrupted at any time, and the best checkpoint will always be saved.

Evaluate a trained model with:

    ./scripts/evaluate_wordlevel.sh
    
    ./scripts/evaluate_2000_bpe.sh
    
    ./scripts/evaluate_4000_bpe.sh
    

# Task 3: Compare BLEU score and Beam Size variation on Best Model
- My best model with a BLEU score of `23.6` was the 4000 vocab bpe model

To compare 10 different Beam Sizes and compute a Bar-Chart with the results, run:

    ./scripts/evaluate_beam_bleu_plot.sh
    
It takes around 1.4h to run this evaluation script (its not very efficient but It works :))
