#!/bin/bash


OUT_DIR=~/ZH-SBN/SBN_parsing_openmt_changed/data/"${1:-sbn-silver-en}"
PYTHON=~/ZH-SBN/data/
DATA=~/ZH-SBN/data/data_raw
DATA_DIR=~/ZH-SBN/data/data_for_model
mkdir -p ${OUT_DIR}

cut -f3 ${DATA}/train.en.zh > ${DATA_DIR}/train.en.tok 
cut -f3 ${DATA}/dev.en.zh > ${DATA_DIR}/dev.en.tok
cut -f3 ${DATA}/test.en.zh > ${DATA_DIR}/test.en.tok
cp  ${DATA}/train.sbn.seq  ${DATA_DIR}/train.sbn.seq.en
cp  ${DATA}/dev.sbn.seq  ${DATA_DIR}/dev.sbn.seq.en
cp  ${DATA}/test.sbn.seq  ${DATA_DIR}/test.sbn.seq.en

python ${PYTHON}4.preprocess_sbn_quota.py  ${DATA_DIR}/train.sbn.seq.en ${DATA_DIR}/train.sbn.seq.en.model
python ${PYTHON}4.preprocess_sbn_quota.py  ${DATA_DIR}/dev.sbn.seq.en ${DATA_DIR}/dev.sbn.seq.en.model
python ${PYTHON}4.preprocess_sbn_quota.py  ${DATA_DIR}/test.sbn.seq.en ${DATA_DIR}/test.sbn.seq.en.model


python ../preprocess.py \
    -seed 123 \
    -data_type text\
    -train_src ${DATA_DIR}/train.en.tok\
    -train_tgt ${DATA_DIR}/train.sbn.seq.en.model \
    -valid_src ${DATA_DIR}/dev.en.tok \
    -valid_tgt ${DATA_DIR}/dev.sbn.seq.en.model \
    -save_data ${OUT_DIR}/sbn \
    -src_words_min_frequency 1 \
    -tgt_words_min_frequency 1 \
    -src_seq_length 1000 \
    -tgt_seq_length 1000\
    -dynamic_dict

    


