#!/bin/bash

DATASET=$1 ## test/dev

GPU_ID=0
MODELS_DIR="/home/p289796/ZH-SBN/SBN_parsing_openmt_changed/model/sbn-silver-zh"
INPUT_DATA=/home/p289796/ZH-SBN/data/data_for_model

OUT_DIR=${MODELS_DIR}/preds/
MODEL=${MODELS_DIR}/best.pt

REF_FILE=${INPUT_DATA}/${DATASET}.zh.tok
TARG_FILE=${INPUT_DATA}/${DATASET}.sbn.zh.seq.model


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
python ~/ZH-SBN/data/4.postprocess_sbn_quota.py   ${OUT_DIR}/{$f}.pred.txt  ${OUT_DIR}/zh.sbn.output.$DATASET
cp ${OUT_DIR}/zh.sbn.output.$DATASET /home/p289796/SBN-evaluation/1.evaluation-tool-overall/model_output/

#scp ${OUT_DIR}/zh.sbn.output p289796@colossus.hpc.rug.nl:/home/p289796/SBN-evaluation/1.evaluation-tool-overall/model_output/
#ssh p289796@colossus.hpc.rug.nl
# source ~/.bashrc
#cd /home/p289796/SBN-evaluation/1.evaluation-tool-overall/
#sh run.sh
