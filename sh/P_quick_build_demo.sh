#!/bin/bash
echo 请输入参考的项目名
read refer
#echo $refer
refer1=${refer//-/_}
refer2=${refer//_/-}
#echo $refer1
#echo $refer2

echo 请输入要生成的项目名
read target
#echo $target
target1=${target//-/_}
target2=${target//_/-}
#echo $target1
#echo $target2
isUIcfg=$(grep "$refer1:" ui.cfg | wc -l)
echo $isUIcfg

if [ $isUIcfg == 1 ]      #目标行是否存在
then
echo 'refer exist in uicfg' 
sed -i "/^[^#].*/s/^/#/" ui.cfg   #可以拆解成/^[^#].*/和s/^/#/  补全uicfg的#
uitmp1=$(grep "$refer1:" ui.cfg)
uitmp2=$(grep "$refer1:" ui.cfg|sed "s/$refer1/$target1/"|sed "s/^#//")
echo $uitmp1
echo $uitmp2
sed -i "/$uitmp1/a $uitmp2" ui.cfg  #参考行后添加目标行
echo 'ui.cfg'>filepath.txt

if test -f "application/include/$refer2.h"; then #头文件和projectcfg
echo 'refer exist in include'
cp application/include/$refer2.h application/include/$target2.h
sed -i "s/$refer2/$target2/g" application/include/$target2.h
sed -i "s/$refer1/$target1/g" application/include/$target2.h 
echo "application/include/$target2.h" >> filepath.txt

#sed  "s/ / /" application/include/$target2.h 


project="#elif defined($target1)\n#include \"$target2.h\""  # {\"}才能把"当成文本
sed -i "/$refer2.h/a $project"  application/include/ProjectCfg.h # {/xx/a  xxxx}  a是在内容后插入xxxx
echo "application/include/ProjectCfg.h" >> filepath.txt



if test -d "application/config/maxmade/$refer1"; then #if-f为常规文件 if-d为文件夹
echo 'refer exist in config'
cp -r application/config/maxmade/$refer1 application/config/maxmade/$target1
sed -i "s/$refer1/$target1/g" application/config/maxmade/$target1/platform/version_info.txt
sed -i "s/$refer2/$target2/g" application/config/maxmade/$target1/platform/version_info.txt

sed -i "s/$refer1/$target1/g" application/config/maxmade/$target1/platform/defconfig
echo "application/config/maxmade/$target1" >> filepath.txt




UIdir=$(find application/reference_ui -type d -name $refer1)
UIdir1=$(find application/reference_ui -type d -name $refer1|sed "s/$refer1/$target1/")
isUIdir=$(find application/reference_ui -type d -name $refer1| wc -l)
if [ $isUIdir -ge 1  ]     # -ge大于等于  -le 小于等于 
then
echo "refer exist in UIdir $UIdir1"
#cp -r $UIdir $UIdir1
find application/reference_ui -type d -name "$refer1"|sed "s/$refer1//"|xargs -i cp -r {}/$refer1 {}/$target1
find application/reference_ui -type d -name "$target1" >> filepath.txt
#find application/reference_ui2 -type d -name "AV_1297W_93"|sed "s/AV_1297W_93//"|xargs -i cp -r {}/AV_1297W_93 {}/AV_1297W_931




else
echo "failed to find refer in 4UI";exit
fi

echo "greping pls wait"
grep "defined($refer1)" -rl application/reference_ui2 >> filepath.txt
sed -i "s/defined($refer1)/defined($refer1)||defined($target1)/g" `grep "defined($refer1)" -rl application/reference_ui`

sed -i "s/defined\s*(\s*$refer1\s*)/defined($refer1)||defined($target1)/g" `grep "defined\s*(\s*$refer1\s*)" -rl application/reference_ui`
#sed -i "s/defined\s*(\s*AV_1337WF_93\s*)/defined(AV_1337WF_93)||defined(AV_1377W_93)/g" `grep "defined\s*(\s*AV_1337WF_93\s*)" -rl application/reference_ui2`

#sed -i "s/defined(AV_1297_65H)||defined(AV_1297_65H1)/defined(AV_1297_65H)||defined(AV_1297_65H1)||defined(AV_1297_65H1)/g" `grep -rl "defined(AV_1297_65H)||defined(AV_1297_65H1)" application/`

echo "job done"


else
echo "failed to find refer in 3config";exit
fi
else
echo "failed to find refer in 2include";exit
fi
else
echo "failed to find refer in 1ui.cfg";exit
fi


