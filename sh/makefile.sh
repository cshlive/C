#/usr/bin/bash
#cd /home/liaoyueping/git/8368-PCarSDK
#cd /home/liaoyueping/git/test/8368-PCarSDK
#cd /home/liaoyueping/8368-PCarSDK
#cd /home/liaoyueping/git/8368-U-QT
#gnome-terminal
#set env
date=`date +%Y%m%d%H%M%S`
#输入命令的时候输入两个参数，第一个参数选择平台，第二个参数选编译类型
#或者只用一个参数：
#pall：	编译	p	平台全部
#papp：	编译	p	平台应用
#uall：	编译	u	平台全部
#uapp：	编译	u	平台应用
#xuall：编译	xu	平台全部
#xuapp：编译	xu	平台应用
#call：	编译	c	平台全部
#capp：	编译	c	平台应用

#8368U-QT_all
#./mk8388cxx.sh 1 > /home/liaoyueping/files/makefile/makefile-all-${date}.txt && ./mk8388cxx.sh all >> /home/liaoyueping/files/makefile/makefile-all-${date}.txt
#8368U-QT_app
#./mk8388cxx.sh app > /home/liaoyueping/files/makefile/makefile-app-${date}.txt && ./mk8388cxx.sh rom >> /home/liaoyueping/files/makefile/makefile-app-${date}.txt

#git/8368-PCarSDK_all
#./mk8368P.sh 1 > /home/liaoyueping/files/makefile/makefile-all-${date}.txt && ./mk8368P.sh all >> /home/liaoyueping/files/makefile/makefile-all-${date}.txt
#git/8368-PCarSDK_app
#./mk8368P.sh app > /home/liaoyueping/files/makefile/makefile-app-${date}.txt && ./mk8368P.sh rom >> /home/liaoyueping/files/makefile/makefile-app-${date}.txt

if [ "${1}" == "pall" ]; then
	cd /home/liaoyueping/git/8368-PCarSDK
	./mk8368P.sh 1 > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8368P.sh all >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif [ "${1}" == "papp" ]; then
	cd /home/liaoyueping/git/8368-PCarSDK
	./mk8368P.sh app > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8368P.sh rom >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif [ "${1}" == "pall2" ]; then
	cd /home/liaoyueping/8368-PCarSDK
	./mk8368P.sh 1 > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8368P.sh all >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif [ "${1}" == "papp2" ]; then
	cd /home/liaoyueping/8368-PCarSDK
	./mk8368P.sh app > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8368P.sh rom >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif  [ "${1}" == "uall" ]; then
	cd /home/liaoyueping/git/8368-U-QT
	./mk8388cxx.sh 1 > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8388cxx.sh all >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif  [ "${1}" == "uapp" ]; then
	cd /home/liaoyueping/git/8368-U-QT
	./mk8388cxx.sh app > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8388cxx.sh rom >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif  [ "${1}" == "xuall" ]; then
	cd /home/liaoyueping/git/8368-XUCarSDK
	./mk8368P.sh 2 > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8368P.sh all >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif  [ "${1}" == "xuapp" ]; then
	cd /home/liaoyueping/git/8368-XUCarSDK
	./mk68xu.sh app > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk68xu.sh rom >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif  [ "${1}" == "call" ]; then
	cd /home/liaoyueping/git/Direct8388GitServer
	./mk8388cxx.sh 1 > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8388cxx.sh all >> /home/liaoyueping/files/makefile/makefile-${date}.txt
elif  [ "${1}" == "capp" ]; then
	cd /home/liaoyueping/git/Direct8388GitServer
	./mk8388cxx.sh app > /home/liaoyueping/files/makefile/makefile-${date}.txt && ./mk8388cxx.sh rom >> /home/liaoyueping/files/makefile/makefile-${date}.txt
fi

date1=`date +%Y%m%d%H%M%S`
echo $date  >> /home/liaoyueping/files/makefile/makefile-${date}.txt
echo $date1 >> /home/liaoyueping/files/makefile/makefile-${date}.txt

cd ./out
cp ISPBOOOT.BIN /home/liaoyueping/ispboot

echo "Build finish">>/home/liaoyueping/files/makefile/makefile-${date}.txt


#弹出提示，后续可以做一个提示：弹出是否编译成功
#弹出txt文件的后八行，确认是否编译成功

message=`sed -n '/Build finish/p' /home/liaoyueping/files/makefile/makefile-${date}.txt`
finsh=编译结束
echo $message
if  [ "${message}" == "   Build finish!!! see ./out/ISPBOOOT.BIN" ]; then
	notify-send $finsh 编译成功 
else
	notify-send $finsh 编译失败 
fi

#显示文件的后面五十行
cat -n /home/liaoyueping/files/makefile/makefile-${date}.txt | tail -n 52

sleep 1.5


