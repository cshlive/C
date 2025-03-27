#!/bin/bash

# 判断输入参数是否为1
if [ "$1" != "1" ]; then
    echo "Usage: ./replace_dsp.sh 1"
    exit 1
fi

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

