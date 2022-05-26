#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data
configs=$base/configs

translations=$base/translations

mkdir -p $translations

src=de
trg=en

# cloned from https://github.com/bricksdont/moses-scripts
MOSES=$base/tools/moses-scripts/scripts

num_threads=4
device=0

# measure time

SECONDS=0


model_name=transformer_config_4000_bpe

echo "###############################################################################"
echo "model_name $model_name"

translations_sub=$translations/$model_name

mkdir -p $translations_sub

CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python -m joeynmt translate $configs/$model_name.yaml < $data/tokenized/test.de-en.4000.bpe.$src > $translations_sub/test.de-en.4000.tokenized.$model_name.$trg

# undo BPE (not necessary because the translation configurations of JoeyNMT have as a default a de-BPE-ing step.


# undo tokenization

cat $translations_sub/test.de-en.4000.tokenized.$model_name.$trg | $MOSES/tokenizer/detokenizer.perl -l $trg > $translations_sub/test.de-en.4000.$model_name.$trg

# compute case-sensitive BLEU on detokenized data

cat $translations_sub/test.de-en.4000.$model_name.$trg | sacrebleu $data/test.de-en.$trg


echo "time taken:"
echo "$SECONDS seconds"
