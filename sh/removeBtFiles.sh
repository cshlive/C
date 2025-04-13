#!/bin/bash
# current path is xxx
rlsRootPath=`pwd`
destPath=$rlsRootPath/linux/sdk/bt_release
ignoreFiles1=$destPath/Makefile  
ignoreFiles2=$destPath/BW121/readme.txt
ignoreFiles3=$destPath/RG440/changelog.txt
 
echo -e "removeFile.sh run in\n"
 
rm -rf $ignoreFiles1
rm -rf $ignoreFiles2
rm -rf $ignoreFiles3

function removeFile {
	for i in `ls $1`; do
		if [ -d $1/$i ]; then
			removeFile $1/$i
		else
			for j in `find $rlsRootPath -name $i`; do
				if [ "$1/$i" != "$j" ]; then
					echo $j
					rm -rf $j
				fi
			done
			echo -e "---- $1/$i removed done ----\n"
		fi
	done
}

removeFile $destPath

rm -rf $destPath

echo -e "removeFile.sh run out\n"
