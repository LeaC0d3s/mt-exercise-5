#! /bin/bash

scripts=`dirname "$0"`
base=$scripts/..

models=$base/models
configs=$base/configs

mkdir -p $models

num_threads=4

# measure time

SECONDS=0

logs=$base/logs

#model_name=transformer_config_wordlevel
model_name=transformer_config_2000_bpe
#model_name=transformer_config_4000_bpe
mkdir -p models
mkdir -p $logs

mkdir -p $logs/$model_name

OMP_NUM_THREADS=$num_threads python -m joeynmt train $configs/$model_name.yaml > $logs/$model_name/out 2> $logs/$model_name/err

echo "time taken:"
echo "$SECONDS seconds"
