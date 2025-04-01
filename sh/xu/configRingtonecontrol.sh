#!/bin/bash
#  尝试 通过脚本配置 实现 蓝牙通话 和 铃声控制分离
#  仅适用于项目配置名称一一对应的项目头文件, 如: AV_1435W_11对应AV-1435W-11.h，不对应的请自行修改 #



# 搞点黄色
COLOR_YELLOW="\033[0;1;33;40m"
COLOR_ORIGIN="\033[33m"

# 蓝牙配置文件的路径
JSON_FILE="./linux/sdk/bt_release/RG440/etc/btDefSetting.json"

# 项目名称传参
PRODUCT_NAME="$1"

# 判空
if [ -z "$PRODUCT_NAME" ]; then
  echo -e "项目名称格式不对!!!" "\n"
  exit 1
fi

# 对应的项目头文件
HEADER_FILE=$(echo "$PRODUCT_NAME" | sed 's/_/-/g').h

# 项目头文件路径
HEADER_FILE_PATH="./application/include/$HEADER_FILE"

# 检查路径
if [ ! -f "$HEADER_FILE_PATH" ]; then
  echo -e "Not found!!! $HEADER_FILE_PATH" "\n"
  exit 1
fi
# 检查是否存在未注释的宏定义
if [ -f "$HEADER_FILE_PATH" ]; then
     if grep -q '^[^/]*#define[[:space:]]*BT_DISSOCIATE_PHONE_AND_RINGTONE_CONTROL' "$HEADER_FILE_PATH"; then
           #修改配置
	    sed -i 's/"playPhoneBell": true/"playPhoneBell": false/g' "$JSON_FILE"
            echo '项目头文件    ' $HEADER_FILE_PATH
	    echo "已修改 $JSON_FILE 中的 playPhoneBell 设置"
            exit 1
     fi
fi
exit 1

