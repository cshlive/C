#!/bin/bash

COLOR_ORIGIN="\033[0m"
COLOR_RED="\033[0;1;31;40m"
COLOR_GREEN="\033[0;1;32;40m"

UI_CONFIG_FILE="ui.cfg"
UI_TEMP_CONFIG_FILE=".uiconfig"
UI_NAME=
PRODUCT_NAME=
PANEL_TYPE=
MEMCFG_TYPE=
APPLE_IC=
PRODUCT_COMMON_FLAGS=

MAXMADE_CFG_DIR="application/config/maxmade/"
PLATFORM_CFG_DES_DIR="build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/"
ETC_DIR="linux/sdk/out/system/"
ETC_APP_DIR="application/reference_ui2/"
APP_LANGUAGE_DIR="application/reference_ui2/spLauncher/sysset/src/lang/"
FONT_DIR_PATH="application/reference_ui2/fonts/"

#和做的工作就是把cpaa的key键作用打开
CPAA_CONFIG_DIR="cpaaautoconfig/"
CPAA_CONFIG_SH="openCpKeyFunc.sh"
OPEN="1"
CLOSE="0"

#多路HFP配置
MULTIPLE_DIR='multiplehfpconfig/mul2.sh'


UI_MACRO_COUNT=0
if [ -f $UI_CONFIG_FILE ]; then
	while read LINE
	do
	{
		LEN=${#LINE}
		if [ $LEN -gt 0 ]; then         #字符串长度大于0

		if [[ $LINE != *"#"* ]]; then   #排除有#号的行

		OLD_IFS=$IFS
		IFS=":"
		arr=($LINE)
		PRODUCT_NAME=${arr[0]}
		UI_NAME=${arr[1]}
		PANEL_TYPE=${arr[2]}
		MEMCFG_TYPE=${arr[3]}
		APPLE_IC=${arr[4]}
		IFS=$OLD_IFS

		UI_MACRO_COUNT=$((UI_MACRO_COUNT + 1))

		echo ""
		echo -e "\n" $COLOR_GREEN "----------------------------------------------" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "product name: $PRODUCT_NAME" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "UI name: $UI_NAME" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "PANEL Type: $PANEL_TYPE" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "----------------------------------------------" $COLOR_ORIGIN "\n"
		echo ""

		echo -e "export UI_NAME="$UI_NAME"\nexport PRODUCT_NAME="$PRODUCT_NAME"\nexport PANEL_TYPE="$PANEL_TYPE"\nexport MEMCFG_TYPE="$MEMCFG_TYPE"\nexport PRODUCT_COMMON_FLAGS= -D"$UI_NAME" -D"$PRODUCT_NAME" -D"$PANEL_TYPE" -D"$MEMCFG_TYPE > $UI_TEMP_CONFIG_FILE

		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/defconfig ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/defconfig exists."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/*  ${PLATFORM_CFG_DES_DIR}
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/defconfig does not exist."
			cp -rf ${MAXMADE_CFG_DIR}default/platform/*  ${PLATFORM_CFG_DES_DIR}
		fi

		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc exist."
            rm -rf ${ETC_APP_DIR}/etc
                        echo "auto change cp key value  to true"
                        ./${CPAA_CONFIG_DIR}${CPAA_CONFIG_SH}  ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc ${OPEN}
                        cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc ${ETC_APP_DIR}
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc don't exist."
                        cp -rf ${MAXMADE_CFG_DIR}default/etc ${ETC_APP_DIR}
		fi

##############################  Config Media LICENSE #########
##############################  Xiangj 2023.11.01    #########
CONFIG_FILE="${MAXMADE_CFG_DIR}${PRODUCT_NAME}/app_config"
TEXT_TO_FIND="ENABLE_CLOSE_MEDIA_LICENSE=1"
# 进入项目配置文件检查是否需要关闭LICENSE
		if [ -f "$CONFIG_FILE" ]; then
		    # 使用grep命令来搜索文本
		    if grep -q "$TEXT_TO_FIND" "$CONFIG_FILE"; then
			echo "                     =======>" $COLOR_GREEN "Found '$TEXT_TO_FIND' in $CONFIG_FILE" $COLOR_GREEN "\n"
			#执行替换命令
			echo $COLOR_GREEN "Copying files from ecos/close_license/customer/sunplus/gemini_disc/" $COLOR_GREEN "\n"
			cp -r ecos/close_license/customer/sunplus/gemini_disc/* ecos/customer/sunplus/gemini_disc/

			echo "                     =======>" $COLOR_GREEN "Copying files from ecos/close_license/lib/" $COLOR_GREEN "\n"
			cp -r ecos/close_license/lib/* ecos/lib/
        		echo "                     =======>" $COLOR_GREEN "Copying files to build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/release/ecos/lib/" $COLOR_GREEN "\n"
        		cp -r ecos/close_license/lib/* build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/release/ecos/lib/
        
        		echo "                     =======>" $COLOR_GREEN "Copying files to build/multi_config_release/build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/release/ecos/lib/" $COLOR_GREEN "\n"
        		cp -r ecos/close_license/lib/* build/multi_config_release/build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/release/ecos/lib/
		    else
			echo "                     =======>" $COLOR_RED "Did not find '$TEXT_TO_FIND' in $CONFIG_FILE" $COLOR_RED "\n"
		    fi
		else
			echo "                     =======>" $COLOR_RED "File $CONFIG_FILE does not exist" $COLOR_RED "\n"
		fi
###############################################################

############      config default Local BT Name      ############

        echo -e "\n" "            " "\033[33m" "=======>  Auto config ${PRODUCT_NAME} BT Name ......" $COLOR_ORIGIN "\n"
        ./configDefaultBTName.sh ${PRODUCT_NAME}
        sleep 2
############      config default Local BT Name      ############

############      config playPhoneBell      ############
        echo -e "\n" "            " "\033[33m" "=======>  Do   Ringtonecontrol.sh ......"  "\n"
        ./configRingtonecontrol.sh ${PRODUCT_NAME}
	 echo -e "\n" "            " "\033[33m" "=======>  Finnish  Ringtonecontrol.sh ......"  "\n"
	sleep 2
############      config playPhoneBell      ############


############      config Multiple HFP      ############
############        Tam 2022.06.24         ############
        echo -e "\033[33m" $COLOR_ORIGIN
        #echo -e "\n" "                              " "\033[33m" "=======>  Auto config Multiple HFP ......"$COLOR_ORIGIN "\n"
        #./${MULTIPLE_DIR}  ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/app_config
        #sleep 1
############      config Multiple HFP      ############

###############################################################

		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.bin ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.bin exists."
		#	cp -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.bin  application/animation_logo.bin
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.bin does not exist."
		fi


		APPLICATION_TOOL_PMGROUP="application/tools/runtime_cfg_generator/pmGROUP/"
		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/ITU/3_demo ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/ITU/3_demo exists."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/ITU/3_demo  ${APPLICATION_TOOL_PMGROUP}
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/ITU/3_demo does not exist."	
			cp -rf ${MAXMADE_CFG_DIR}default/3_demo		${APPLICATION_TOOL_PMGROUP}
		fi
#语言配置	
		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/language ]; then
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/language exist."
			git checkout ${APP_LANGUAGE_DIR}
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/language/* ${APP_LANGUAGE_DIR}
		else
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/language don't exist."
			git checkout ${APP_LANGUAGE_DIR}
			#cp -rf ${MAXMADE_CFG_DIR}default/language/* ${APP_LANGUAGE_DIR}
		fi

                if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/beepsound ]; then
                        echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/beepsound exist."
                        cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/beepsound/* ${ETC_APP_DIR}/sound
                else
                        echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/beepsound don't exist."
                        git checkout ${APP_FONT_DIR}/sound
                fi

        if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/isp.sh ]; then
            echo "512M flash"
            cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/isp.sh build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/isp.sh
        else
            git checkout build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/isp.sh
        fi

		rm -rf ${FONT_DIR_PATH}*
		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/fonts ]; then
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/fonts exist."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/fonts/* ${FONT_DIR_PATH}
		else
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/language don't exist."
			cp -rf ${MAXMADE_CFG_DIR}default/fonts/* ${FONT_DIR_PATH}
		fi

#		if [ "$APPLE_IC" == "30" ]; then
#			echo "Apple IC : 3.0"
#			sed -i "s@iacp_addr=0x22@iacp_addr=0x20@" ./rootfs/gen_init_rc.mk
#		else
#			echo "Apple IC : 2.0C"
#			sed -i "s@iacp_addr=0x20@iacp_addr=0x22@" ./rootfs/gen_init_rc.mk
#		fi

		fi

		fi
	}
	done < $UI_CONFIG_FILE

	if ((UI_MACRO_COUNT > 1)) ; then
		echo -e "\n" $COLOR_RED " error: ui macro count > 1. " $COLOR_ORIGIN "\n"
		exit
	fi

else
	echo -e "\n" $COLOR_RED " ui.cfg does not exist. " $COLOR_ORIGIN "\n"
fi

