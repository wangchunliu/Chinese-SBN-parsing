#!/bin/bash


GPU_ID=0
MODELS_DIR="/home/p289796/ZH-SBN/SBN_parsing_openmt_changed/model/sbn-silver-en"
INPUT_DATA=/home/p289796/ZH-SBN/data/data_for_model


OUT_DIR=${MODELS_DIR}/preds/
MODEL=${MODELS_DIR}/best.pt

REF_FILE=${INPUT_DATA}/test.zh-en.trans.tok
TARG_FILE=${INPUT_DATA}/test.sbn.zh.seq.model


mkdir -p ${OUT_DIR}
for fname in ${MODELS_DIR}/*model*; do
    f=${fname##*/}
    echo $f
    python ../translate.py \
	-data_type text \
        -model ${fname} \
        -src ${REF_FILE} \
        -tgt ${TARG_FILE} \
        -output ${OUT_DIR}/{$f}.pred.txt \
        -beam_size 5 \
        -batch_size 1 \
        -gpu ${GPU_ID} \
        -replace_unk \
        -max_length 500 > log.txt
done

python /home/p289796/ZH-SBN/data/4.postprocess_sbn_quota.py   ${OUT_DIR}/{$f}.pred.txt  ${OUT_DIR}/trans.sbn.output 
cp ${OUT_DIR}/trans.sbn.output /home/p289796/SBN-evaluation/1.evaluation-tool-overall/model_output/
# source ~/.bashrc
#cd /home/p289796/SBN-evaluation/1.evaluation-tool-overall/
#sh run.sh
