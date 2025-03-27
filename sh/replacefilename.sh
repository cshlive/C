#!/bin/bash

# 提示用户输入参考项目名和目标项目名
echo "请输入参考的项目名"
read refer
echo "请输入要生成的项目名"
read target

# 遍历当前目录及子目录中的所有文件
find . -type f | while read file; do
    # 检查文件名中是否包含参考项目名
    if [[ "$file" == *"$refer"* ]]; then
        # 生成新的文件名，将参考项目名替换为目标项目名
        newfile=$(echo "$file" | sed "s/$refer/$target/g")
        echo "Renaming $file to $newfile"
        # 重命名文件
        mv "$file" "$newfile"
    fi
done

echo "所有文件已重命名。"

