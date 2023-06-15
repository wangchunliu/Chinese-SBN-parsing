#!/bin/bash

GPUIDS="${1:-0}"
DATA_DIR="${2:-/home/p289796/ZH-SBN/SBN_parsing_openmt_changed/data/sbn-silver-en}"
OUT_DIR="${3:-/home/p289796/ZH-SBN/SBN_parsing_openmt_changed/model/sbn-silver-en}"
BATCH_SIZE="${4:-32}"
NUM_LAYERS="${5:-1}"

mkdir -p ${OUT_DIR}

python ../train.py \
    -data_type 'text' \
    -data ${DATA_DIR}/sbn \
    -save_model ${OUT_DIR}/sbn-model \
    -layers ${NUM_LAYERS} \
    -report_every 1000 \
    -train_steps 40001 \
    -valid_steps 10000 \
    -rnn_size 900 \
    -word_vec_size 450 \
    -encoder_type brnn \
    -decoder_type rnn \
    -batch_size ${BATCH_SIZE} \
    -max_generator_batches 50 \
    -learning_rate_decay 0.5 \
    -start_decay_steps 30000 \
    -save_checkpoint_steps 10000 \
    -decay_steps 2000 \
    -optim adam \
    -max_grad_norm 3 \
    -learning_rate 0.002 \
    -seed 123 \
    -dropout 0.2 \
    -keep_checkpoint 1\
    -gpu_ranks ${GPUIDS} \
    -copy_attn 
