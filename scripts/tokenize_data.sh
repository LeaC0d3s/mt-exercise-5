#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

data=$base/data

mkdir -p $data/tokenized

#shuffle and sample first 100'000 sentences (random sample)
python $base/scripts/sub_training_data.py -src $data/train.de-en.de -tgt $data/train.de-en.en


# tokenize test, train and dev set of word level:

pip install sacremoses

# tokenize the german data:
cat $data/train.de-en_sub.de | python $base/scripts/tok_preprocess.py  --tokenize --lang "de" > \
    $data/tokenized/train.de-en.de

cat $data/test.de-en.de | python $base/scripts/tok_preprocess.py  --tokenize --lang "de" > \
    $data/tokenized/test.de-en.de

cat $data/dev.de-en.de | python $base/scripts/tok_preprocess.py  --tokenize --lang "de" > \
    $data/tokenized/dev.de-en.de

# tokenize the english data:
cat $data/train.de-en_sub.en | python $base/scripts/tok_preprocess.py  --tokenize --lang "en" > \
    $data/tokenized/train.de-en.en

cat $data/test.de-en.en | python $base/scripts/tok_preprocess.py  --tokenize --lang "en" > \
    $data/tokenized/test.de-en.en

cat $data/dev.de-en.en | python $base/scripts/tok_preprocess.py  --tokenize --lang "en" > \
    $data/tokenized/dev.de-en.en