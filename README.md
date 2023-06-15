# Chinese-SBN-parsing
 - The code for the paper "Discourse Representation Structure Parsing for Chinese".
 - The data can be found in PMB's new release version, or you can download it from my [Google Drive](https://drive.google.com/drive/folders/1iLihDcpZ6zNPT6zjBz8T1A4VSxq6vM47?usp=sharing).
 - If you want to test models for comparison experiments, you can download them from [Google Drive](https://drive.google.com/drive/folders/15v5o2xvicJUUElZS-vr4SESTp0CCLMKq?usp=sharing).
 - The models are trained by OpenNMT, or you can use AllenNLP by using the code from [Rik's Github](https://github.com/RikVN/Neural_DRS).
 - 
# Usage

## Preprocess data
 -  First, you need to get the data, which you can download directly. Once you get the data including English text and Chinese text and DRS for English text, you need to use tokenizer HanLP and Moses to preprocess Chinese and English respectively.
 -  Second, you need to use GIZA++ to process English and Chinese text together and get the alignment file "z2e.A3.final", you need to use it to replace the Chinese named-entities with English named-entities in DRS, and then you can get DRS for Chinese.
 -  Third, you must process the clause format DRS to the sequential format used for neural models.
 -  Finally, you need to split the data into valid, test, and train data, remember that the valid set and test set are gold data, and training data includes gold data and silver data.
   
## Train the model
 - For the English parser, you can find the commands for training in file `silver_en_run`, and for Chinese `silver_zh_run`.
 - Note, the data file path for commands should be changed to the data file path where you put it.
```
# preprocess data
sh preproc_sbn_goldsilver.sh
# train the parser
sh train_sbn_seq_goldsilver.sh
# test the parser
sh predict_sbn_silver.sh
# or you can use the English parser to parse the English test translated from Chinese
sh predict_sbn_silver_trans.sh

## Evaluation
 - Once you get the sequential DRS data, you can use it to compare it with the gold DRS data.
 - Our evaluation tool is provided in [SBN-evaluation-tool](https://github.com/wangchunliu/SBN-evaluation-tool)
 
