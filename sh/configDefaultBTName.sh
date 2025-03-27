#!/bin/bash
##  尝试对策RG440模块项目，工厂复位后手机断第一时间扫描的车机设备名称显示GOC-GBTS ##
##  仅适用于项目配置名称一一对应的项目头文件, 如: AV_1435W_11对应AV-1435W-11.h，不对应的请自行修改 ##



# 搞点黄色
COLOR_YELLOW="\033[0;1;33;40m"
COLOR_ORIGIN="\033[33m"

# 蓝牙配置文件的路径
JSON_FILE="linux/sdk/bt_release/RG440/etc/btDefSetting.json"

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
HEADER_FILE_PATH="application/include/$HEADER_FILE"

# 检查路径
if [ ! -f "$HEADER_FILE_PATH" ]; then
  echo -e "Not found!!! $HEADER_FILE_PATH" "\n"
  exit 1
fi

# 从头文件中提取宏定义 BT_NAME 的值
#BT_NAME=$(grep '#define BT_NAME' "$HEADER_FILE_PATH" | awk '{print $3}' | tr -d '"')
BT_NAME=$(grep '#define BT_NAME' "$HEADER_FILE_PATH" | sed -E 's/#define BT_NAME[[:space:]]+"(.*)"/\1/')


# 判断是否提取成功
if [ -z "$BT_NAME" ]; then
  echo "项目头文件没有!!! #define BT_NAME $BT_NAME" "\n"
  BT_NAME="CarMedia"
fi

echo -e "\n"$COLOR_ORIGIN"               ===>BT_NAME: $BT_NAME"$COLOR_ORIGIN"\n"
sleep 2

# 修改json文件中的"defaultLocalname"
if [ -f "$JSON_FILE" ]; then
  sed -i "s/\"defaultLocalname\": *\"[^\"]*\"/\"defaultLocalname\": \"$BT_NAME\"/" "$JSON_FILE"
  echo -e "\n"$COLOR_ORIGIN"               ===>Config $JSON_FILE ==> defaultLocalname: $BT_NAME"$COLOR_ORIGIN"\n"
sleep 2
else
  echo "Error!!! Not found $JSON_FILE"
  exit 1
fi

