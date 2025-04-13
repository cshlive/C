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
FLASH_CFG=
APPLE_IC=
PRODUCT_COMMON_FLAGS=

MAXMADE_CFG_DIR="application/config/maxmade/"
PLATFORM_CFG_DES_DIR="build/platform_cfg/4RlsCode_8368_P_ivi_cluster_demov1.0_cfg/"
ETC_DIR="linux/sdk/out/system/"
ETC_APP_DIR="application/reference_ui/"
APP_LANGUAGE_DIR="application/reference_ui/spLauncher/sysset/src/lang/"
MULTI_CAM="ecos/lib/"

#APP_DEFAULT_FONT_NAME="default.ttf"
APP_MODEL_FONT_DIR="fonts/"
APP_FONT_DIR="application/reference_ui/fonts/"
APP_MODEL_AVM_DIR="avm/"
APP_AVM_DIR="application/reference_ui/avm/"

#和做的工作就是把cpaa的key键作用打开
CPAA_CONFIG_DIR="cpaaautoconfig/"
CPAA_CONFIG_SH="openCpKeyFunc.sh"
OPEN="1"
CLOSE="0"


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
		FLASH_CFG=${arr[4]}
		APPLE_IC=${arr[5]}
		IFS=$OLD_IFS

		UI_MACRO_COUNT=$((UI_MACRO_COUNT + 1))

		echo ""
		echo -e "\n" $COLOR_GREEN "----------------------------------------------" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "product name: $PRODUCT_NAME" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "UI name: $UI_NAME" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "PANEL Type: $PANEL_TYPE" $COLOR_ORIGIN "\n"
		echo -e "\n" $COLOR_GREEN "----------------------------------------------" $COLOR_ORIGIN "\n"
		echo ""

		echo -e "export UI_NAME="$UI_NAME"\nexport PRODUCT_NAME="$PRODUCT_NAME"\nexport PANEL_TYPE="$PANEL_TYPE"\nexport MEMCFG_TYPE="$MEMCFG_TYPE"\nexport FLASH_CFG="$FLASH_CFG"\nexport PRODUCT_COMMON_FLAGS= -D"$UI_NAME" -D"$PRODUCT_NAME" -D"$PANEL_TYPE" -D"$MEMCFG_TYPE" -D"$FLASH_CFG > $UI_TEMP_CONFIG_FILE

#        HEAD_FILEX=`echo "${PRODUCT_NAME}" | sed 's/_/-/g'`
#        HEAD_FILE=$HEAD_FILEX.h
#        if [ -f application/include/${HEAD_FILE} ]; then
#            cp -rf application/include/${HEAD_FILE} application/include/header-for-build.h
#        else
#            echo "application/include/${HEAD_FILE} does not exist"
#        fi

		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/defconfig ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/defconfig exists."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/*  ${PLATFORM_CFG_DES_DIR}
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/platform/defconfig does not exist."
			cp -rf ${MAXMADE_CFG_DIR}default/platform/*  ${PLATFORM_CFG_DES_DIR}
		fi

#		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_DEFAULT_FONT_NAME} ]; then
#			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_DEFAULT_FONT_NAME} exist."
#			rm ${APP_FONT_DIR}*
#			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_DEFAULT_FONT_NAME} ${APP_FONT_DIR}
#		else
#			rm ${APP_FONT_DIR}*
#			git checkout ${APP_FONT_DIR}
#			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_DEFAULT_FONT_NAME} don't exist."
#		fi

#font customer
		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_FONT_DIR} ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_FONT_DIR} exist."
                        rm ${APP_FONT_DIR}*
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_FONT_DIR}/* ${APP_FONT_DIR}
		else
			rm ${APP_FONT_DIR}*
			git checkout ${APP_FONT_DIR}
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_FONT_DIR} don't exist."
		fi

                if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_AVM_DIR} ]; then
                        echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_AVM_DIR} exist."
                        rm -rf ${APP_AVM_DIR}*
                        if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_AVM_DIR}/lib/libavm.so ]; then
                            echo "libavm.so exist"
                        else
                            git checkout ${APP_AVM_DIR}
                        fi
                        cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_AVM_DIR}/* ${APP_AVM_DIR}
                else
                        rm -rf ${APP_AVM_DIR}*
                        git checkout ${APP_AVM_DIR}
                        echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${APP_MODEL_AVM_DIR} don't exist."
                fi

        if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${MEMCFG_TYPE}/xboot.img ]; then
            cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${MEMCFG_TYPE}/xboot.img build/release/xboot.img
        else
            echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/${MEMCFG_TYPE}/xboot.img does not exist."
        fi

        if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/isp.sh ]; then
            cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/isp.sh build/platform_cfg/4RlsCode_8368_P_ivi_cluster_demov1.0_cfg/isp.sh
        else
            if [ "$FLASH_CFG" == "FLASH_512M" ]; then
                cp -rf build/platform_cfg/4RlsCode_8368_P_ivi_cluster_demov1.0_cfg/isp_512M_flash.sh build/platform_cfg/4RlsCode_8368_P_ivi_cluster_demov1.0_cfg/isp.sh
            else
                cp -rf build/platform_cfg/4RlsCode_8368_P_ivi_cluster_demov1.0_cfg/isp_256M_flash.sh build/platform_cfg/4RlsCode_8368_P_ivi_cluster_demov1.0_cfg/isp.sh
            fi
        fi

		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc exist."
#            rm -rf ${ETC_APP_DIR}/etc
            echo "auto change cp key value  to true"
#            ./${CPAA_CONFIG_DIR}${CPAA_CONFIG_SH}  ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc ${OPEN}
#            cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc ${ETC_DIR}
            cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc ${ETC_APP_DIR}
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/etc don't exist."
            cp -rf ${MAXMADE_CFG_DIR}default/etc ${ETC_APP_DIR}
		fi

		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/audio_hw_conf.xml ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/audio_hw_conf.xml exists."
			cp -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/audio_hw_conf.xml  linux/sdk/out/system/etc/as_server/audio_hw_conf.xml
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/audio_hw_conf.xml does not exist."
		fi

#		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.h264 ]; then
#			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.h264 exists."
#			cp -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.h264  application/anim_logo/animation_logo.h264
#		else
#			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/animation_logo.h264 does not exist."
#		fi


		APPLICATION_TOOL_PMGROUP="application/tools/runtime_cfg_generator/pmGROUP/"
		if [ -f ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/3_demo ]; then
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/3_demo exists."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/3_demo  ${APPLICATION_TOOL_PMGROUP}
		else
			echo "${MAXMADE_CFG_DIR}${PRODUCT_NAME}/3_demo does not exist."	
			git checkout ${APPLICATION_TOOL_PMGROUP}3_demo

		fi
############      config default Local BT Name      ############

        echo -e "\n" "            " "\033[33m" "=======>  Auto config ${PRODUCT_NAME} BT Name ......" $COLOR_ORIGIN "\n"
        ./configDefaultBTName.sh ${PRODUCT_NAME}
        sleep 2
############      config default Local BT Name      ############

#语言配置	
		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/language ]; then
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/language exist."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/language/* ${APP_LANGUAGE_DIR}
		else
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/language don't exist."
#			cp -rf ${MAXMADE_CFG_DIR}default/* ${APP_LANGUAGE_DIR}
		fi

		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/beepsound ]; then
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/beepsound exist."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/beepsound/* ${ETC_APP_DIR}/sounds
		else
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/beepsound don't exist."
			git checkout ${APP_FONT_DIR}/sounds
		fi

#YUV码流的存储方式
#UYVY
		if [ -d ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/multi_cam ]; then
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/multi_cam exist."
			cp -rf ${MAXMADE_CFG_DIR}${PRODUCT_NAME}/multi_cam/* ${MULTI_CAM}
		else
#YUYV
			echo "${ACCESSORY_CFG_SRC_DIR}${PRODUCT_NAME}/multi_cam don't exist."
			git checkout ${MULTI_CAM}libmulti_cam.a
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

