#!/bin/bash
#  尝试 通过脚本配置 实现 自动替换公共部分的/linux/sdk/out/system/etc/audio/dsp底下的bin文件，针对部分项目原车麦克风增益偏大,降低高速行驶时的底噪音
#  仅适用于项目配置名称一一对应的项目头文件, 如: AV_1435W_11对应AV-1435W-11.h，不对应的请自行修改 #



# 搞点黄色
COLOR_YELLOW="\033[0;1;33;40m"
COLOR_ORIGIN="\033[33m"



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
     if grep -q '^[^/]*#define[[:space:]]*AUTO_REPLACE_DSP_FILES' "$HEADER_FILE_PATH"; then
#修改配置
# 获取当前工作目录的绝对路径
CURRENT_DIR=$(pwd)

# 定义源目录和目标目录的绝对路径
SOURCE_DIR="$CURRENT_DIR/linux/sdk/out/system/etc/audio/dsp_Reduce_noise"
TARGET_DIR="$CURRENT_DIR/linux/sdk/out/system/etc/audio/dsp"

# 输出调试信息
echo "Current directory: $CURRENT_DIR"
echo "Source directory: $SOURCE_DIR"
echo "Target directory: $TARGET_DIR"

# 确保源目录存在
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory $SOURCE_DIR does not exist."
    exit 1
fi

# 确保目标目录存在
if [ ! -d "$TARGET_DIR" ]; then
    echo "Target directory $TARGET_DIR does not exist."
    exit 1
fi

# 确保目标目录有写权限
if [ ! -w "$TARGET_DIR" ]; then
    echo "No write permission for target directory $TARGET_DIR."
    exit 1
fi
# 执行文件替换操作
	cp -rf "$SOURCE_DIR"/* "$TARGET_DIR/"
	if [ $? -eq 0 ]; then
    	echo "Files replaced successfully."
	else
    	echo "File replacement failed."
	fi
        echo '项目头文件    ' $HEADER_FILE_PATH
        exit 1
    fi
fi
exit 1

