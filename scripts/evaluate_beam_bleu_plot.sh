#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
configs=$base/configs

translations=$base/beam_translations

mkdir -p $beam_translations

src=de
trg=en

# cloned from https://github.com/bricksdont/moses-scripts
MOSES=$base/tools/moses-scripts/scripts

num_threads=4
device=0

# measure time

SECONDS=0


model_name=transformer_config_4000_bpe
echo "" > $translations/beam_scores_new.txt



for beam in _b1 _b2 _b3 _b4 _b5 _b6 _b7 _b8 _b9 _b10 ; do
	echo "###############################################################################"
	echo "model_name $model_name$beam"
	mkdir -p $translations_sub
	CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/best_model/$model_name$beam.yaml < \
	$data/tokenized/test.de-en.4000.bpe.$src | $MOSES/tokenizer/detokenizer.perl -l $trg | sacrebleu $data/test.de-en.$trg -b >> $translations/beam_scores_new.txt

	echo "time taken:"
	echo "$SECONDS seconds"

done


python $base/scripts/plot_bleu_beam.py --score_file $translations/beam_scores_new.txt --beam_sizes "_b1" "_b2" "_b3" "_b4" "_b5" "_b6" "_b7" "_b8" "_b9" "_b10"



# compute case-sensitive BLEU on detokenized data

