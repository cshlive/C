#!/bin/bash

if [ $1 == "avm" ]; then
    if [ $2 == "1" ]; then
        #打开AVM调试开关，可通过U盘运行AVM程序进行调试
        echo "AVM Debug On"
        sed -i 's/U_DISK_DEBUG/U_DISK_DEBUG true \/\//g' application/reference_ui/spLauncher/plugins/module/mmautoavmmodule/include/avmprotocol.h
        sed -i 's/CONFIG_GLB_GMNCFG_ENABLE_FAST_REVERSE_CTRL/CONFIG_GLB_GMNCFG_ENABLE_AVM/g' rootfs/gen_init_rc.mk
    elif [ $2 == "0" ]; then
        #关闭AVM调试开关
        echo "AVM Debug Off"
        git checkout application/reference_ui/spLauncher/plugins/module/mmautoavmmodule/include/avmprotocol.h
        git checkout rootfs/gen_init_rc.mk
    fi
else

    if [ $1 == "1" ]; then
        # 打开8368P所有log开关
        echo "open log debug"
        sed -i -e 's/UART_OUTPUT=.*/UART_OUTPUT=y/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/KLOG_OUTPUT=.*/KLOG_OUTPUT=y/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/KLOG_LEVEL=.*/KLOG_LEVEL=7/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/ALOG_OUTPUT=.*/ALOG_OUTPUT=y/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/ALOG_LEVEL=.*/ALOG_LEVEL=v/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        cp -rf linux/sdk/out/system/etc/log_service/log_default.cfg application/reference_ui/etc/log/log_default.cfg
    #    cp -rf linux/sdk/out/system/etc/log_service/log_default.cfg linux/sdk/out/.systemout/etc/log_service/log_default.cfg
        sed -i -e 's/db_level=.*/db_level=15/g' linux/sdk/bt_release/sphe900/etc/TL.INI
        sed -i -e 's/\"debugMode\":.*,/\"debugMode\": true,/g' linux/sdk/bt_release/RG440/etc/btDefSetting.json
        sed -i -e 's/CONFIG_RTW_LOG_LEVEL = .*/CONFIG_RTW_LOG_LEVEL = 4/g' linux/sdk/wifi/drivers/rtl8821cs/Makefile
    elif [ $1 == "2" ]; then
        #如果是查AP层问题没必要开上面这么高的打印
        echo "open AP log, level d"
        sed -i -e 's/UART_OUTPUT=.*/UART_OUTPUT=y/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/KLOG_OUTPUT=.*/KLOG_OUTPUT=n/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/KLOG_LEVEL=.*/KLOG_LEVEL=1/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/ALOG_OUTPUT=.*/ALOG_OUTPUT=y/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/ALOG_LEVEL=.*/ALOG_LEVEL=d/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        cp -rf linux/sdk/out/system/etc/log_service/log_default.cfg application/reference_ui/etc/log/log_default.cfg
        sed -i -e 's/db_level=.*/db_level=0/g' linux/sdk/bt_release/sphe900/etc/TL.INI
        sed -i -e 's/\"debugMode\":.*,/\"debugMode\": false,/g' linux/sdk/bt_release/RG440/etc/btDefSetting.json
        sed -i -e 's/CONFIG_RTW_LOG_LEVEL = .*/CONFIG_RTW_LOG_LEVEL = 3/g' linux/sdk/wifi/drivers/rtl8821cs/Makefile
    else
        # 关闭或调低8368P所有log开关
        echo "close log debug"
        sed -i -e 's/UART_OUTPUT=.*/UART_OUTPUT=n/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/KLOG_OUTPUT=.*/KLOG_OUTPUT=n/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/KLOG_LEVEL=.*/KLOG_LEVEL=4/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/ALOG_OUTPUT=.*/ALOG_OUTPUT=n/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        sed -i -e 's/ALOG_LEVEL=.*/ALOG_LEVEL=d/g' linux/sdk/out/system/etc/log_service/log_default.cfg
        cp -rf linux/sdk/out/system/etc/log_service/log_default.cfg application/reference_ui/etc/log/log_default.cfg
    #    cp -rf linux/sdk/out/system/etc/log_service/log_default.cfg linux/sdk/out/.systemout/etc/log_service/log_default.cfg
        sed -i -e 's/db_level=.*/db_level=0/g' linux/sdk/bt_release/sphe900/etc/TL.INI
        sed -i -e 's/\"debugMode\":.*,/\"debugMode\": false,/g' linux/sdk/bt_release/RG440/etc/btDefSetting.json
        sed -i -e 's/CONFIG_RTW_LOG_LEVEL = .*/CONFIG_RTW_LOG_LEVEL = 3/g' linux/sdk/wifi/drivers/rtl8821cs/Makefile
    fi
fi
