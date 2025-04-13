#!/bin/bash
folders=($(ls /media/chenshihao/))
echo -e "\n cp out/ISPBOOOT.BIN /media/chenshihao/$folders \n"
cp out/ISPBOOOT.BIN /media/chenshihao/$folders && umount /media/chenshihao/$folders

echo -e "\n umount /media/chenshihao/$folders \n"




