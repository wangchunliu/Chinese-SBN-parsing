#!/bin/bash


OUT_DIR=~/ZH-SBN/SBN_parsing_openmt_changed/data/"${1:-sbn-silver-zh}"
DATA=~/ZH-SBN/data/data_raw/
DATA_DIR=~/ZH-SBN/data/data_for_model/
PYTHON=~/ZH-SBN/data/
mkdir -p ${OUT_DIR}

cut -f5 ${DATA}/train.en.zh > ${DATA_DIR}/train.zh.tok 
cut -f5 ${DATA}/dev.en.zh > ${DATA_DIR}/dev.zh.tok
cut -f5 ${DATA}/test.en.zh > ${DATA_DIR}/test.zh.tok

python ${PYTHON}/3.get_zh_name_sbn.py --input_sbn ${DATA}/dev.sbn --input_text ${DATA}/dev.en.zh --input_giza ${DATA}/z2e.A3.final.dev
python ${PYTHON}/3.get_zh_name_sbn.py --input_sbn ${DATA}/test.sbn --input_text ${DATA}/test.en.zh --input_giza ${DATA}/z2e.A3.final.test
python ${PYTHON}/3.get_zh_name_sbn.py --input_sbn ${DATA}/train.sbn --input_text ${DATA}/train.en.zh --input_giza ${DATA}/z2e.A3.final.train

cp  ${DATA}/train.sbn.zh.seq ${DATA_DIR}
cp  ${DATA}/dev.sbn.zh.seq  ${DATA_DIR}
cp  ${DATA}/test.sbn.zh.seq  ${DATA_DIR}

python ${PYTHON}4.preprocess_sbn_quota.py  ${DATA_DIR}/train.sbn.zh.seq ${DATA_DIR}/train.sbn.zh.seq.model
python ${PYTHON}4.preprocess_sbn_quota.py  ${DATA_DIR}/dev.sbn.zh.seq ${DATA_DIR}/dev.sbn.zh.seq.model
python ${PYTHON}4.preprocess_sbn_quota.py  ${DATA_DIR}/test.sbn.zh.seq ${DATA_DIR}/test.sbn.zh.seq.model


python ../preprocess.py \
    -seed 123 \
    -data_type text\
    -train_src ${DATA_DIR}/train.zh.tok \
    -train_tgt ${DATA_DIR}/train.sbn.zh.seq.model \
    -valid_src ${DATA_DIR}/dev.zh.tok \
    -valid_tgt ${DATA_DIR}/dev.sbn.zh.seq.model \
    -save_data ${OUT_DIR}/sbn \
    -src_words_min_frequency 1 \
    -tgt_words_min_frequency 1 \
    -src_seq_length 1000 \
    -tgt_seq_length 1000\
    -dynamic_dict

    


