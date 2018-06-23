#!/bin/sh
python3 recorder.py
python3 preprocess3.py
for i in {0..2}
do
    python3 speech_commands_demo/label_wav.py --graph=Save/saved_notable/notable_graph.pb --labels=Save/saved_notable/speech_commands_train/conv_labels.txt --wav=audio_file/clip_voice${i}.wav 
done
value=`cat instruction.txt`
tput setaf 2; echo "$value"
