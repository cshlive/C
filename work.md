# 开发环境配置:
快捷键：
fn + > 到当前行尾
fn + < 到当前行首
ctrl + fn + > 整个文档的末尾
ctrl + fn + < 整个文档的头部    
ctrl + k,ctrl + f 格式化代码格式
tar -zxvf apple_carplay_service_5.tar.gz 解压

git:
 git reset 的混合模式（git reset --mixed commitId）或者是软模式（git reset --soft commitId）回退至上面记录的 commit id 的版本，使用这两种模式不会丢失你本地的修改
 git reset --hard + commitId 
 git fetch 从远端仓库拉取最新变更信息的命令。获取的信息并不直接反映在本地分支
 git pull 将所有的变更都反映到本地分支上 
 git rebase 这个命令会始终把你最新的修改放到最前头
从项目的维度考量，单人开发，希望提交记录整体简洁清晰，不关注操作顺序——rebase
从人的维度考量，多人开发，希望知道某人在某个时间干了什么以及先后顺序——merge
无论是个人单机开发，还是公司协作开发，只要没有特殊需求，用merge准没错！！！
git reset --soft HEAD^ 已经commit还没推到远程，回退
终止合并：
git merge --abort
git reset --merge
只是想拉取远程更新，并且不想处理合并冲突，可以考虑：
git stash        # 先保存本地修改
git pull         # 再次尝试拉取
git stash pop    # 应用本地修改（如有冲突仍需手动解决）
排除：**/8368P-rls/*/
按 Ctrl+Shift+P,打开setting.json 
复制
```
"files.exclude": {
        "**/.git"           :true,
        "**/.gitee"         :true,
        "8368P-rls/"            :true,
        "8368XU-rls/"             :true,
        "projects/"         :false,
    }
```
打印例子：
ALOGD(__FUNCTION__ << __LINE__ << "listsize:" << cpDatalist.size());
printf("[%s][%d] set AudioLowPass phase %d\n",__FUNCTION__,__LINE__,filter.phase);
printf("[%s][%d] calling_volume: %d, media_volume: %d\n",
        __FUNCTION__, __LINE__, calling_volume, media_volume);

# 音频系统调试: 

graph TD
  A[按键事件] --> B{KeyProcess}
  B -->|静音键| C[BTPhoneIMPL_muteMic]
  C --> D[setMicroPhoneGain]
  D --> E[ALSA驱动层]


# UI问题追踪-日常：
后续需要加宏来改语言收音

第一周：
新人入职，熟悉了环境
参加线上培训课，了解了工作制度以及一些要求和注意事项

20250423：
改语言，收音区域改 application\config\sunplus\sunplus_demo\Appconfig\App_config.ini 这个可能是demo板
/build/platform_cfg/4RlsCode_8368_XU_demov1.0_openall_cfg/defconfig 
这个地方去配置有线无线，屏参文件的选泽
执行程序：
make list 
make 2 && make all

make menuconfig 配置defconfig，会生成一个.config
配置屏参：
build\platform_cfg\4RlsCode_8368_XU_demov1.0_openall_cfg\defconfig
application\tools\tcon_bin_generator\SPHE8368U\panel_SPHE8368U_LVDS_6BIT_HSD080IFW1_A.h

工作环境：
ssh-keygen
cp ~/.ssh/id_rsa.pub . -rf
git clone git@192.168.3.146:8368P-rls
git clone git@192.168.3.146:8368XU-rls.git  //未审核分支
cat ./.ssh/id_rsa.pub
cat id_rsa.pub
ssh -T git@192.168.3.146:8368XU-rls.git
git branch -a
git checkout 8368XU-TB-CM-2U_Blaupunkt-gele
git clone ssh://chenshihao@192.168.3.146:29418/8368XU-rls.git //gerrit的审核分支
./gmenv.sh 检查编译环境
SecureCRT:打印设置：
D:\Log\%S\%Y\%M%D-%h%m%s.log
\%Y\%M%D_-%h:%m:%s
%h:%m:%s:
[Tips]
 git config --global user.email "chenshihao@topband.com.cn"
  272  git config --global user.name "chenshihao"
  273  git commit
  274  git pull
  275  git config --global core.editor vim
  276  git log
  277  git reset --hard 
  278  git log
  279  git reset --hard 1a2f5429fea5499b7b97eda6172ef6536a26bc5e
  280  git fetch 
  281  git merge
  282  git rebase 
  283  git log
  284  git branch -a
  285  git push origin HEAD:refs/for/8368XU-TB-CM-2U_Blaupunkt-gele //推送到远程gerrit分支 （如果第一次失败输下面）
  286  gitdir=$(git rev-parse --git-dir); scp -p -P 29418 chenshihao@192.168.3.146:hooks/commit-msg ${gitdir}/hooks/
  287  git commit --amend --no-edit  //修改最近一次提交的代码，而不想改动提交说明
  288  git push origin HEAD:refs/for/8368XU-TB-CM-2U_Blaupunkt-gele//审核分支
  
蓝宝6.75寸Debug审核分支：

git clone ssh://chenshihao@192.168.3.146:29418/8368XU-rls.git 
git push origin HEAD:refs/for/Blaupunkt_17455_D//推送到审核分支
Gerrit使用git amend修改已提交代码
git commit -a --amend --no-edit  //自动git add
SSH 连接到服务器 samba 
\\192.168.26.185\chenshihao
对比工具：
\\192.168.26.210\共享\2.软件安装 的Beyond.Compare.v3.3.13.18981


蓝牙事项：EVENT_PHONE_BTCALL_STATE_CHANGE 以callback通知 尽量在另外的线程更新画面，不要在callback占用太多时间

20250429:
蓝牙音乐调节音量无作用：
关键词：
BTSrv_ServiceCBK
getAllStreamTypeVolumes
15:55:58[QT] [Audiocontrol] getTrackStreamType 791  tag:  3  name:  BT_AUDIO_Track
15:55:58[QT] [Audiocontrol] getTrackStreamType 814  streamType:  
怀疑是上面streamType为空导致无法调节蓝牙音乐
因为对比过收音
13:38:37[QT] [Audiocontrol] getTrackStreamType 791  tag:  0  name:  S+AuxIn
13:38:37[QT] [Audiocontrol] getTrackStreamType 814  streamType:  media
AudioTagAlter
ENABLE_ADJUST_ALTER
getActiveTracksStreamType

而且对应走了
 ctrl->getActiveTracksName(AudioControl::AudioTagAlter, alterNames);
 ctrl->getActiveTracksName(AudioControl::AudioTagAuxiliary, auxiNames);
15:28:38[QT] [Audiocontrol] getActiveTracksName 756  tag;  3
15:28:38[QT] [Audiocontrol] getActiveTracksName 756  tag:  0

解决：
commit 78c15932eeda4245e95954cbc6dad519014b9d7b (HEAD -> 8368XU-TB-CM-2U_Blaupunkt-gele)
Author: chenshihao <chenshihao@topband.com.cn>
Date:   Tue Apr 29 17:54:07 2025 +0800

    fix:蓝牙音乐界面音量调节大小不受控制
    
            modified:   linux/sdk/out/appsdkfs/etc/as_server/tracks_property.xml
            modified:   linux/sdk/out/appsdkfs/etc/as_server/volume_property.xml
            modified:   linux/sdk/out/system/etc/as_server/tracks_property.xml
            modified:   linux/sdk/out/system/etc/as_server/volume_property.xml
    
    Change-Id: I10a8604dbbbab35788b8cad3c6ac7f1d6fa0bde


Commit: 3a0b1ab4d6ee30bc069524e35142ce57d697a886
Parents: 2cfec47b83f02ce994ef596b54cec1ac684887d9
Author: chenshihao <chenshihao@topband.com.cn>
Committer: chenshihao <chenshihao@topband.com.cn>
Date: Wed Apr 30 2025 11:31:40 GMT+0800 (中国标准时间)
 

fix:蓝牙音乐播放声音后喇叭无声音
    modified: linux/sdk/out/appsdkfs/etc/as_server/tracks_property.xml
    modified: linux/sdk/out/system/etc/as_server/tracks_property.xml

Change-Id: I21be04e04a9868188631cb926423ae5e8f227781

20250430：
[BUG] 
现象：蓝牙通话中触点界面上的静音图标静态，说话对方还能听到我方的声音
疑问：需要明确需求，点击静音图标后，是近端喇叭静音，还是远端手机听到的和近端喇叭一起静音？
而且已经在ui上有一个单独mute麦克风声音的按钮
为啥还有一个keyPressEvent函数

按键：KeyProcess,在basecontrol也有一个：onMcuKeyProcessSlot ->这个地方if (nKey == E_IPC_KEY_VOL_MUTE && nStatus == K_KeyUp) {判断里面增加一个发送信号}
蓝牙通话过程中点击静音无作用：
初步怀疑：BTPhoneIMPL_muteMic，BTPhoneIMPL_isMicMute
EVENT_PHONE_AUDIO_STATE
procesMuteOnoffCall
调节op增益位置：setMicroPhoneGain
或者直接抓打印，按键mute时候触发什么函数
**根本原因**：
**解决方案**：

20250506：
[BUG] 
蓝牙通话中会概率出现声音失真：
疑问：描述不够具体，是近端功放声音有失真，还是远端通话的手机听到的声音有失真？
如果是远端的话可能需要抓aec_dump录音文件给凌阳

无线CP已连接，Device Link列表界面断开CP连接，再去播放蓝牙音乐无声音输出:
[QT] [BlueToothModuleImpl][bluetoothmoduleimpl/bluetoothmodulemmpl.cpp  BTAudioCBK ][line is 231] BTAudioCBK : EVENT_AUDIO_TRACK_CHANGED_IND
[QT] [BlueToothMoluleImpl][bluetoothmoduleimpl/bluetoothmoduleimpl.cpp  BTAudioCBK ][line is 231] BTAudio(HQ_AUDIO_PLAYBACK_TIME_IND
16:44:31BtAudioTrackTask:[BTAUDIO_TRACK_MSG_DATA_IN] Send Fail"!! ret=7
[Bt_Stack][gsl_queue][trackQueue] queue0normal space has full!, current/max=60/60
[QT] [CommonTopbar] btnClicked id: "wifi"
初步对比sunplus公板正常，对比无线AA重新连接蓝牙时也正常，怀疑是无线cp断开后a2dp没连上
16:44:32[QT] [VolumeManager] getActiveTrack{Volumes 772 streamType:  "media"  volume:  110
09:18:20:[QT] [BlueToothModuleImpl][bluetoothmoduleimpl/bluetoothmoduleimpl.cpp  BTIMPL_GetBondedDeviceList ][line is 2158]  connState: 0
09:18:24:[QT] [CarPlayDeviceManager] BTSrv_ConnectionCBK 1178  eProfile:  1 BTConnState:  0 //a2dp DisConnected
09:18:24:[QT] [DeviceListView] 475  bt device in list mac: 53150559889379 SupportStatus: 3 ConnectStatus: 1 name: 
09:18:25:[QT] [BlueToothModuleImpl][bluetoothmoduleimpl/jluetoothmoduleimpl.cpp  BTSrv_ConnectionCBK ][line is 760] BTSrv_ConnectionCBK :  A2DPSNK status CONNECTED //这里已经连上
EVENT_PHONE_BATTERY_REMAINDER
EVENT_PHONE_SIGNAL_STRENGTH
device点击:featureRunningClick
蓝牙动作:BTSrv_ServiceCBK
蓝牙协议连接:BTSrv_ConnectionCBK
[QT] [CarPlayDeviceManager] [Debug] notify [--IN--]
171940.738: [QT] [Error] [ActivityManagerImpl] line: 1853 stopActivity: "carplay" fail!//ps:这里为啥停止失败了，导致资源没还回去
171940.739: [QT] [BaseControl] soundSourceChange soundType =  6 , soundState =  false //ps:为啥是6，这里是cpring
171703.076: [QT] [BtPhoneActivity] btConnectStateChangeSlot 1209 profile: 2 state: 2 //这里是a2dp连接
171836.263: [QT] [BtPhoneActivity] btConnectStateChangeSlot 1209 profile: 2 state: 2
171940.488: [QT] deviceview/deviceview.cpp [Debug] featureRunningClick [--IN--] //ps:这里是断开无线cp的操作
171942.124: [QT] [BlueToothModuleImpl][bluetoothmoduleimpl/bluetoothmoduleimpl.cpp  BTSrv_ConnectionCBK ][line is 760] BTSrv_ConnectionCBK :  A2DPSNK status CONNECTED //ps:还是连上了
171944.513: record_audio_track_data_flag file is not exist. //ps:记录音轨数据
171957.089: [QT] [Warning] [bluetoothmodule][BTSourceManger.cpp  btAudioTakeSource ][line is 257] line: 257 btmusic audio source already been token! //ps:这里应该是资源拿回来了
AUDIO_STATUS_STOP 

CPDevicePriv::connectBtProfiles


20250507:
[SOLVED]
**现象**：
设置界面拖动屏幕白天/夜晚亮度小光标会回来滑动:UI响应延迟>500ms  
跟代码有关系,dbnessprogressbar DBNESSNAME 调换 nbnessprogressbar NBNESSNAME 发现跟着ID走
[QT] [SetupRoot] dbusDayBrightNess: 这个更新很快
但是实际setDayBrightnessBar 这个也慢
[QT] [Mcusrv] onMcuSetSystemDataCommand Sys_ScreenStateCmd daybrigntness:  这个较慢
mode->sendSetupMessage(E_IPC_CMD_SCREEN_LEVEL,General_Bribrigntness,val.toInt()); 这一句有问题
onIpcSetupDataMsgSlot
emit updateSetupDataInfoSig(E_IPC_CMD_SCREEN_LEVEL,nData);
**根本原因**：  
`ReceiveSetuoModuleSlot` 同步调用 `setDayBrightnessBar` 阻塞UI线程  

**解决方案**：  
已解决：
注释ReceiveSetuoModuleSlot这段middleGenW->setDayBrightnessBar(DayBrightness); 这里流程较慢导致ui上反应较慢




20250508:
[SOLVED]
**现象**：
加减音量才会刷定时器 ，静音要单独刷

else if (volume->isHidden()) {}
        volume->setVolumeActivity(vMax, vMin);
        if (e->key() != KeyMute) {
            volume->updateVolume(dest_val);
        }
void ComVolumeView::updateVolume(quint8 val)
{
    volumeUi->progressBar->setValue(val);
    volumeUi->volVar->setText(QString::number(val));
    emit volumeValChange(val);
    timeReset();
}
**根本原因**：
**解决方案**：
已解决：
BaseControlPrivate::volumeKeyProcess 里面
else if (volume->isHidden()) {}
里面增加 else if (e->key() == KeyMute) { 启动4s定时器}的判断

20250509：
[SOLVED]
**现象**：
EQ→Filter→调节Phase/Slope，触点界面复位后，界面Phase/Slope数值恢复到默认值，实际声音效果没有恢复，概率100%
MEqWidget::dialogBtnClicked 
setFilterValue 
对比U平台：缺少resetFilterValue
095111.356: [QT] [Audiocontrol] initEqSystemVal16 set eq channel 65535
095111.356: [QT] [Audiocontrol] set eq channel2 65535 //(AudioControl::setEqGain) ->setEqGain16
095139.993: [QT] [Audiocontrol] initEqValue16 set eq channel 65535
095139.993: [QT] [Audiocontrol] set eq16 channel 65535
095139.993: [QT] [Audiocontrol] initEqSystemVal16 set eq channel 65535
095139.993: [QT] [Audiocontrol] set eq channel2 65535
**根本原因**：
**解决方案**：
已解决：增加一个resetFilterValue来重置
20250512；
EQ→Filter→调节Phase/Slope，ACC OFF/ON ，开机后声音效果变大，概率100%
在exeSetupSettingStage2里面注释了exeSetupAudioSetting
导致没跑exeFilter 但是注释打开会造成开机异常（声音很大而且第二次无声音）感觉机器主板有问题，经常无声音
参考U的代码：
但是这两个是TD平台的代码
有在初始化里面加SetupModule::initFilterValue
void SetupEqView::setupFilterValueInit()

MEqWidget::initWidget
这个地方需要调用一个函数，这个根据存的值调用setFilterValue();
但是是需要在SetupModule里面去加，时序要早初始化才能避免晚生效
这个问题还牵涉到在eq里面的UI时，进行的eq操作根本就没有保存到data里面，自然无法读取恢复
MEqWidget::btnSlot 这里面需要在操作ui的时候去存储对应的值
155331.278: [QT] [MEqWidget] saveBalanceMode 935 m_filterLowindex 6
155358.454: [QT] [SetupModule] initFilterValue 999 m_nLpfValue: 6 m_nHpfValue 0
printf("[%s][%d] set AudioLowPass phase %d\n",__FUNCTION__,__LINE__,filter.phase);
155358.454: [initFilterValue][1033] set AudioLowPass phase 0 //ps:读取存储之后还是相位为0，实际调节的是frequency不是相位
LPF 和 HPF 应该分别设置为不同通道或组合设置
目前都是在调AudioChannelMax
ctrl->setFilter(AudioControl::AudioChannelMax,filter);
看目前td也是
但是xu目前还是exeSetupAudioSetting
已解决：之前只有一个setFilter调整param.eqValue[17]，增加一个setHighFilter函数来调整param.eqValue[18]这个的数值

20250513：
管理声音位置:VolumeManager::soundChangeVolumeSetting
[BUG]
**现象**：
sub开关无作用：
增加打印：//ALOGD(__FUNCTION__<<__LINE__<<"subToggle:"<< subToggle);
printf("SubwooferView::btnSlots, subToggle: %s\n", subToggle ? "true" : "false");
打印chanel（AUDIO_CHANNEL_LFE）和参数true都正常，目前看不出来原因
设置把重低音开关关闭了 现象：重低音还有输出
SetupModule::initial
这里spPfcCtrl->PFC_Set_GPIO_Mode(GPIO_MODE_FUNCTION, 33, 1);这里设了重低音，不知道是不是导致一直开启
setSubwooferStatus(true); 看打印没问题 
设置里音量控制把语音/导航/通话音量调后，ACC OFF/ON语音/导航/通话音量实际记忆默认值：

在BaseControlPrivate::initVolume->VolumeManager::setVolumeDef 这里面仅对部分项目做了判断
这个默认值调节完之后，其实已经把值保存到callingDef，但是显示值改的地方在音量控制页面初始化，正常要开机还要去点进去音量控制才会走initData（ui显示的值才理应被改）
VolumeControlView::VolumeControlView
VolumeControlView::initData 这个地方不知道为啥读取了默认值

[SOLVED]
**现象**：
语言非英语状态，设置其他语言，返回主界面应用名称显示英语，没有随语言变化:
acc起来可以翻译，应该是少了通知刷新的事件导致没有改变后立马生效
retranslateUi(this)
languageChange
resetUi();
BtAudioView::showEvent
**根本原因**：
**解决方案**：
已解决：增加resetUi 接口去调用retranslateUi(this)
20250515:
[BUG]
**现象**：
usb播放视频很多不支持：
project/8368XU-rls/application/reference_ui/spLauncher/apis/fileprovider/filedeviceparser.cpp
getFileSuffix
FileSuffix videoSuffix[]

20250519：
[BUG]
**现象**：
EQ界面把16频段调节至最大声音失真：
目前回复：
因为目前支持最大的增益是+/- 12db ，该问题应该需要再细致一些，应该统计多少音量下，播放1khz或者单一频段hz的声音，调节的曲线值什么时候开始失真，失真率是多少，一般允许的失真率是有一定范围的，只要最大失真率不超过限定的值即可接受
[BUG]
**现象**：
语音/切换驾驶位置/EQ复位/恢复出厂设置/设置壁纸/Device Link触点+号，各界面弹出提示框，触点屏幕任意位置不会消失：
[SOLVED]
**现象**：
QT打开失败：
提示环境有误：
runtime error abnormal program termination
后面在系统变量上补充qt的几个bin位置就可以正常了

20250520:
[SOLVED]
**现象**：
关机状态(power)，倒车中后台有声音输出:
**根本原因**：
**解决方案**：
已解决：
void BaseControlPrivate::entryChangedSlot(const QString &activityName, const QVa
             q_ptr->slotUpdateEvent(E_IPC_SYSINFO_REVERSE_STATE, E_IPC_REVERSE_END);
         }
         nState = Reverse_State;
-        q_ptr->onPowerOffChange(nState, data.toBool());
+        //q_ptr->onPowerOffChange(nState, data.toBool());
+        BASEC_D(__FUNCTION__ << __LINE__ << "getPowerState:" << q_ptr->getPowerState());
+        if (!q_ptr->getPowerState())
+        {
+            q_ptr->onPowerOffChange(nState,data.toBool());
+        }
[SOLVED]
**现象**：
播放USB音视频/蓝牙音乐、CPAA音乐，按面板POWER键关机，音乐还会继续播放：
8368P的cp:
BaseControl::onMcuLauncherDataSlot
case E_IPC_SYSINFO_POWER:
ActivityManager::self()->KeyProcess_Specify(ActivityManagerImpl::self()->getCurSourceActivityName(),E_IPC_KEY_POWER,K_KeyPowerOn);
CarplayModuleImpl::cpAudioSetup
if(mCpResMgr->getCPAudioType() != type || type != AudioTypeMedia)
            cpAudioSourceChange();
        mCpResMgr->setCPAudioType(type);
CPModesChangedCbk::audioEntityChangedByiPhone
else if (ENTITY_Accessory == af) {
        if(mCpResMgr->getBorrowIDState(BorrowID_AudioOff) == false)
        {
            mCpResMgr->setCPAudioType(-1);
        }
} 改了不起作用，
BTAudioIMPL_getAvrcpPlayStatus
btAudioPlayControl
entryChangedSlot //ps:好像是和acc有关
setPowerState carplay里面还得调pCPObj->keyAudioOff(true);
**根本原因**：
**解决方案**：
已解决：
E_IPC_KEY_POWER 看各个activity里面各自的处理
比如：KeyProcess_Activity
cp里面真正的是调用这个资源
            mCpResMgr->setBorrowIDState(BorrowID_AudioOff, true);
            mCpResMgr->borrowResource(RESOURCEID_MainAudio, TRANSFER_PRIORITY_UserInitiated,
                                      TRANSFER_CONSTRAINT_UserInitiated, BorrowID_AudioOff);
AA里面还要支持key按键，也没有直接的接口去暂停音乐，改用keyDispatch的方法，加上时间判断按下释放

20250521:
[BUG]
**现象**：
开机概率性无声音：
@尹奇机器两台升级新软件，会出现断电，再上电开机整机没有声音输出，但有按键音，出现这现象后，要多次上电开机或着放一段时间会恢复正常@曾伟文说一下你的分析原因，谢谢！
从测量来看，功放工作正常，没有被mute，但是四路音频没有输出
估计从8368-2u没有信号出来
目前我自己试发现连按键音也没有
sendSysInfo
[InfoModuleImpl] SYS_INFO_NAME_VOLUME: 0 //ps 发现不静音的也有这些打印，排除

收音设为欧洲，打开TA收到RDS有效电台，没有trafic信息显示：
RadioView::updateRadioViewDataInfo
SetTATPStatus
RadioView::updateRadioDataInfo
SetRegStatus
[SOLVED]
**现象**：
播放蓝牙音乐，再进入收音界面 现象：蓝牙音乐声音有输出1秒且声音变大:
[QT] [Audiocontrol] getVolumeByStreamType 432  streamType:  media  vol:  28  volume:  27
[QT] [AuxinModuleImpl] setAudioChannel 1 可能是收音这里改channel了
[QT] [Audiocontrol] getVolumeByStreamType 432  streamType:  media  vol:  16  volume:  15
[QT] [Audiocontrol] set audio stream output source main 
AudioControl::setOutputSource
soundChangeMediaVolumeSetting //这里需要对volume进行多一个判断
getRealSetVolValue 830 real set volume:  27
BT_AUDIO_Track //ps:找不到
spAudioTypes.h
AudioControlPrivate::initQtSpMap
trackNameMap.insert(AUDIO_SOURCE_A2DP, AUDIO_SP_SOURCE_A2DP_AUDIO);
AUDIO_SOURCE_A2DP 得改成 BT_AUDIO_Track
BT_RG440 好多旧平台有但是xu没有
AudioControlProxy::initBTAudioTrackName
[QT] [Audiocontrol] getTrackStreamType 799  tag:  3  name:  S+CarPlayMedia
[QT] [Audiocontrol] getTrackStreamType 799  tag:  0  name:  S+AuxIn
[QT] [Audiocontrol] getTrackStreamType 799  tag:  3  name:  BT_AUDIO_Track
enum AudioTag {
        AudioTagMain,
        AudioTagSecond,
        AudioTagAlter,
enum SoundType
{
    MEDIA_SOUND,
mActiveTracksVolumeInfo
enum VolumeType
{
    SystemVolume,
    CarplayVolume,
    CarplayRingVolume,
    AndroidAutoVolume,
    AutoLinkVolume,
    BtMusicVolume,
    FileplayVolume,
    DiscplayVolume,
    MicVolume,
    AuxInVolume,
    I2SInVolume,
    TelVolume,
    AlterVolume
};
在 getRealSetVolValue(...) 中加入音源类型判断
需要重新做一个记忆上一个音频源的接口，而且在进入新音频源要往里面写值
**根本原因**：
**解决方案**：
已解决：
 // 增加判断：如果上一个音源是蓝牙音乐，则不应用 FM 音量曲线
    QString tempSourceActivity =
                    DataSaveControl::readSettingData(ComStrIdConst::SystemInfoTmpSourceMenu, ACTIVITY_RADIO).toString();
                BASEC_D(__FUNCTION__ << __LINE__ << "kkk====source activity:" << sourceActivity
                                     << "tempSourceActivity:" << tempSourceActivity);
但是有测到蓝牙播放无声音的情况，有点类似cp音乐转蓝牙音乐无声音的情况，而且会有出现无声音之后，断开蓝牙异常，假连接删不掉
SystemInfoSourceMenu 这个是存储当前源
SystemInfoTmpSourceMenu //Prev source activity


20250526：
[TODO]
跟can相关的提交id：5572089
在使用AA的keycode有效，需要在8368XU-rls\application\reference_ui\etc\Androidauto 底下的
androidauto_config_1024_600_UI_version_4_3.xml 的keycode设为true才行

20250527:
[DOING]
德国蓝宝ui：
图片资源更换切图，最好统一风格，后续沿用统一的命名格式

radio缺少am1,fm1，右边存储栏图片，滑条还没做，输入键盘也没换 有些-d的缺少
主界面缺少eq 和dab 在homeview缺少eqView = new MEqWidget(this);而且缺少槽去触发
sampleview也没有处理好
蓝牙缺少更新的槽，看到 if (spBtModule->btPhonebookLoadHistoryLogData(devAdr,HistoryCombine) == Success)（sloved）
音乐界面缺少随机，的置灰图片,而且列表里面那些小图标和滑条暂时还不清楚怎么处理的
设置还没开始替换
顶栏有个usb小按钮感觉需要判断当前usb状态（TODO）
[Tips]
windows如果输命令cd +地址，有时候会有影响判断的字符例如-或者\等特殊字符的话，可以直接在地址栏输入 powershell 快速打开
批量替换Windows文件名
加前缀：
Get-ChildItem -Path "C:\路径\*.txt" | Rename-Item -NewName { "prefix_" + $_.Name }
Get-ChildItem -Path "D:\文档\WXWork\1688856488688875\Cache\File\2025-05\德国蓝宝UI切图\切图 - 副本\蓝牙\拨号键盘\*.png" | Rename-Item -NewName { "02_dialbtn_" + $_.Name }

替换：
Get-ChildItem -Path "D:\文档\WXWork\1688856488688875\Cache\File\2025-05\德国蓝宝UI切图\切图 - 副本\radio\拨号键盘\*.png" | 
Rename-Item -NewName { $_.Name -replace '^02_dialbtn_(\d+)_', 'radio_but_loc_$1_' }

Get-ChildItem ... | Rename-Item -NewName {...} -WhatIf //查看模拟结果



20250529:
代码规范评审记录：

1，类接口首字母小写，使用驼峰法
2，C++ if语句统一不换行，if前后加空格。如：if (NULL == UiObj) {
3，判等，不等常量在前变量在后 如：if (NULL == UiObj)
4，log不能太随意，统一使用打印函数名，及有用信息，如：ALOGD("QT"<< __FUNCTION__ << "m_pQmlView:" << m_pQmlView);
5，变量命名统一，成员变量使用m_ 全局变量使用g_ ,静态变量s_ 如：成员变量int m_iXXX
6, 信号槽，增加后者sig slot
7，L194 info使用宏定义
8，switch case统一使用大括号，default不能省略
9，头文件第三方放最上面，其次系统，最后自定义
10，参数使用驼峰法
11，类访问权限依次变小public -》[signals-》slots] protected -》private
12, 变量初始化顺序按定义顺序
13，homewinew L80 宏定义
14，|| && 前后条件加括号，如：if ((HOME_ACTIVITY_BT_MUSIC == modeName) || (ACTIVITY_USB == modeName)) 换行|| &&在下一行开头
15, 不适用的接口使用（unused）标记
16，定义公共有含义返回值
17，函数entryChangedSlot需优化
18，源代码不能使用阿拉伯数字，除非是下标，长度
19， homewiew L480不用删除
20， "info"使用宏

[SOLVED]
**现象**：
6位升到8位机器上就会出现层纹，需要对应
20250605:
[BUG]
更换收音滑条ui：
死机：
[QT] [radioActivity] onCreat 16:23:28
/application/bin/Launcher: symbol lookup error: /tmp/sp/application/lib/activity/libradio.so: undefined symbol: _ZN9RadioInfo26GetRadioAreaAMFreqMinRangeEi
[TODO]
蓝宝UI顶栏topbar上面有一个usb状态没有进行判断
signal :deviceMounted deviceUnMounted
usb列表：
enum
{
    SPRoleDisplayType = Qt::UserRole + 2,
    SPRoleHeaderPixmap,
    SPRoleHeaderString,
    SPRoleCenterString,
    SPRoleTailString,
    SPRoleTailPixmap,
    SPRoleLightBool,
    SPRoleLightPixBool,
    SPRoleNormalPixmap,
    SPRolePressPixmap,
    SPRoleSelectPixmap,
    SPRoleText1String,
    SPRoleText2String
};
enum
{
    SPModelType_PSS = TABLE_HEADER_TYPE_PIXMAP | TABLE_CENTER_TYPE_STRING | TABLE_TAIL_TYPE_STRING,
    SPModelType_PSSP = TABLE_HEADER_TYPE_PIXMAP | TABLE_CENTER_TYPE_STRING | TABLE_TAIL_TYPE_STRING | TABLE_ITEM_TYPE_PIXMAP,
    SPModelType_SSS = TABLE_HEADER_TYPE_STRING | TABLE_CENTER_TYPE_STRING | TABLE_TAIL_TYPE_STRING, // SSS: string string string
    SPModelType_SSN = TABLE_HEADER_TYPE_STRING | TABLE_CENTER_TYPE_STRING | TABLE_DATA_TYPE_NONE,   // SSN: string string none
    SPModelType_SSNP = TABLE_HEADER_TYPE_STRING | TABLE_CENTER_TYPE_STRING | TABLE_DATA_TYPE_NONE | TABLE_ITEM_TYPE_PIXMAP,
    SPModelType_PSN = TABLE_HEADER_TYPE_PIXMAP | TABLE_CENTER_TYPE_STRING | TABLE_DATA_TYPE_NONE, // PSN: pixmap string none
    SPModelType_PSNP = TABLE_HEADER_TYPE_PIXMAP | TABLE_CENTER_TYPE_STRING | TABLE_DATA_TYPE_NONE | TABLE_ITEM_TYPE_PIXMAP,
    SPModelType_PSP = TABLE_HEADER_TYPE_PIXMAP | TABLE_CENTER_TYPE_STRING | TABLE_TAIL_TYPE_PIXMAP, // PSP: pixmap string pixmap
    SPModelType_PSPP = TABLE_HEADER_TYPE_PIXMAP | TABLE_CENTER_TYPE_STRING | TABLE_TAIL_TYPE_PIXMAP | TABLE_ITEM_TYPE_PIXMAP,
    SPModelType_NSP = TABLE_DATA_TYPE_NONE | TABLE_CENTER_TYPE_STRING | TABLE_TAIL_TYPE_PIXMAP, // PSP: pixmap string pixmap
    SPModelType_NSPP = TABLE_DATA_TYPE_NONE | TABLE_CENTER_TYPE_STRING | TABLE_TAIL_TYPE_PIXMAP | TABLE_ITEM_TYPE_PIXMAP,
    SPModelType_NSN = TABLE_DATA_TYPE_NONE | TABLE_CENTER_TYPE_STRING | TABLE_DATA_TYPE_NONE, // NSN: none   string none
    SPModelType_NSNP = TABLE_DATA_TYPE_NONE | TABLE_CENTER_TYPE_STRING | TABLE_DATA_TYPE_NONE | TABLE_ITEM_TYPE_PIXMAP,
};

20250609:
USB文件列表：
MediaListModel::data 这个函数里面控制具体行列显示

20250610:
radio UI滑条 要在mousePressEvent mouseMoveEvent mouseReleaseEvent 改对应的坐标
setBottomToolAnimationStart 控制不同页面的动画效果
为啥弄了m_bottomgridPressed(false)
  ,m_bottomgridmove(false)
  ,m_KeyInputPagePressed(false) 这种判断
上面只是作为底部按钮的判断

20250611：
eq需要增加显示back按钮，改显示方式和增加连接槽，以前是直接点击顶栏都会回到上一级菜单

20250612：
现在滑条已经移植完了，但是有新问题，就是当我去选择保存的值时，当前滑条不会跟着改变到相应的位置，
需要弄成全局变量存储，当点击时去更新一下
弄完滑条之后出现一个问题，就是可以滑动滑条，但是选择区域为欧洲或者美国，下面底框也能滑动，再去划滑条失败，后面排查出来是
标志位弄成同一个导致，需要新增一个判断位代表滑条处于操作状态
还有就是usb音频有个随机循环模式，重复单曲循环失效（TODO）

20250613：
点击预存台对应滑条已经完成，通过RadioView::setRadioCurFreq 这个函数读取当前设置的频率值去改变滑条坐标
现在自测收音，部分字体显示异常，EON,和REG 显示位置异常，滑条在点击pty列表时没有隐藏，usb视频有两个按钮还没实现槽(TODO)
接收到歌乐的新UI切图，需要重新制作主界面

20250615:
主界面只有一页，但是界面中间的那个大的显示区域是播放当前源的信息，并且只能播放收音跟音乐这两个源的内容。播放收音的时候，下边的那排图标的第一个，就换成音乐的图标，播放音乐的时候，下边的那排图标的第一个就换成收音的图标

20250617：
获取usb歌曲信息：获取路径
解析路径
寻找过程：找到ui上对应控件或者信息，找到谁调用的函数
最后找到：currentMedia() ：setPlayFile ：intoPlayingView：selectListItem：listModel：listModel = new MediaListModel(this); ： provider->itemName ：
QString FileBrowserProviderPrivate::itemName(int index)的return path.right(path.length() - path.lastIndexOf("/") - 1);
在basecontrol 里面存一个结构体，返回所需要的值，处理全部放在那边，homeview直接用单例就行

20250618:
homeview里面弄radiomoudule指针，用一个类包装一些重复获取的，传个参数啥的去实现 

20250619:
如果 RadioView 和 HomeView 都需要访问相同的数据，可以将数据放在一个共享的单例类中，然后让 RadioView 和 HomeView 都访问这个单例类中的数据。这种方法可以避免直接依赖 RadioView 的实例，且确保数据一致性。
创建一个单例类，用来保存广播数据：
[QT] [homeview] mediaplayUpdateSlot 253  Failed to get MediaplayModule
QObject::connect: No such slot HomeView::updateRadioDataInfo(int,QVariant)
QObject::connect:  (receiver name: 'homeview')
uboot:bootsp
复制： cp -r /tmp/kexun/homelauncher_A6765.zip .

usb的暂停和主界面的暂停，区分按钮

20250624:
测试表盘，收音滑条，全局变量
安装clang-format 发现vscode 用的remote-ssh 不会读取本地系统变量，而是去读远程服务器的系统变量

20250626:
usb视频的缩放 放大  setRatio(true, index); 待实验 P：selectMenuListSig

20250630：
方控逻辑写死，不能动态获取srcnaname 去触发，不符合使用待优化（TODO）
BaseControl::onMcuKeyProcessSlot case E_IPC_KEY_MODE:
而且图片 在界面有时候读取不了 必须得把播放打开才能读取名字
主界面 infopage 视频的暂停播放 和photo 的下一曲有问题
目前都是通过一个接口 spusbModule->getMediaPlayer()->next(); 音频和视频都可以
playingInfo.type == FT_Video
enum FileListType {
    FileTypeAudio = 0,
    FileTypeVideo,
    FileTypePhoto
};

# 疑难案例-TODO
* 日志系统是怎么处理的：
Commit: 43b8bcdb738451bf3549d8197277eb36e60b3205 这笔修改开始


# 总结
## 代码重构
### 谷歌推荐
1. #include 的路径及顺序
dir/foo.cc 或 dir/foo_test.cc 的主要作用是实现或测试 dir2/foo2.h 的功能, foo.cc 中包含
头文件的次序如下:
1.dir2/foo2.h (优先位置, 详情如下)
2.C 系统文件
3.C++ 系统文件
4.其他库的 .h 文件
5.本项目内 .h 文件
在 #include 中插入空行以分割相关头文件, C 库, C++ 库, 其他库的 .h 和本项目内的 .h 是个好
习惯。
ps:例子：
// 1. 当前模块的 .h 文件
#include "usbactivity.h"

// 2. C 系统头文件（如有）
#include <vector>
#include <memory>

// 3. C++ 系统头文件（Qt / STL）
#include <QString>
#include <QTimer>
#include <QDebug>

// 4. 第三方库头文件（如有）
#include <implicitrulemanager.h>  // 如果它来自外部SDK或独立组件，放这里

// 5. 本项目内头文件（按层级分组）
// Framework 核心模块
#include "../../../framework/src/core/include/activitymanagerimpl.h"

// 基础模块
#include "basecontrol.h"
#include "modulemanager.h"
#include "uimanager.h"

// 媒体相关模块
#include "mediaplayer.h"
#include "mediaplaymodule.h"
#include "mediaplayphoto.h"
#include "mediaplayerrulereason.h"

// 数据与配置模块
#include "datasavecontrol.h"
#include "sysdefine.h"
#include "filedeviceparser.h"

// 事件与通信
#include "event.h"
#include "IPCmsgdefine.h"

// UI 相关
#include "usbview/usbview.h"

2. 函数参数规范
[输入参数] → [inout 参数] → [输出参数] 

3. 作用域的命名空间：
在 .cc 文件中：
将 所有实现代码 （函数、变量、类定义等）都放到一个命名空间中
只有以下内容可以放在命名空间之外：
#include
gflags 的定义
类的前置声明
4. 非成员函数、静态成员函数和全局函数
不要随意使用全局函数，而是将它们放在合适的命名空间中；如果函数和某个类关系密切，可以定义为静态成员函数。不要为了封装几个静态函数就随便造一个类。 
方法一：命名空间中的非成员函数（推荐）
适合那些与某个模块有关但不依赖于类的状态的函数：
```
namespace utils {
    void doSomething() { /* ... */ }
    int calculate(int a, int b) { return a + b; }
}
调用时：
utils::doSomething();
int result = utils::calculate(3, 4);
```
优点：
避免污染全局作用域
结构清晰，易于组织模块化代码
 方法二：静态成员函数（适用于与类相关的工具函数）
当函数和某个类有强关联时，可以定义为静态成员函数：
```
class MathUtils {
public:
    static int add(int a, int b) { return a + b; }
};
调用：
int result = MathUtils::add(5, 7);
```
适用场景：
函数逻辑和类本身密切相关
可能访问类的静态成员或常量



















## 月总结
### 4月总结报告     
陈世浩
1.	本月重点任务完成情况总结
编译环境配置与调试
在本月完成了多个版本的编译环境调试工作，并通过 ssh-keygen 配置了与远程 Git 仓库的连接。确保了与团队协作的顺利进行，能够顺利拉取代码并进行本地修改。

蓝牙音量调节问题修复
本月解决了蓝牙音乐音量调节无效的问题。通过排查并对比音频流数据，发现音量调节界面未能正确识别蓝牙音频流类型。通过调整音量控制相关的配置文件（tracks_property.xml 和 volume_property.xml），成功恢复了蓝牙音乐音量调节的功能。
2. 下月重点任务计划
熟悉代码模块流程
继续处理相关模块问题，过程中熟悉了解代码，对代码结构和业务逻辑的理解，并通过分析现有的 bug 和调试过程，提升自己的问题解决能力。注重对模块之间依赖关系的梳理，确保在修改单个模块时不会影响到其他模块的功能，不要影响代码的稳定性。
优化编译与构建流程
在本月的基础上，进一步优化 make 配置和构建流程，提高编译效率和可复用性。同时，继续完善自动化构建工具的配置，以便团队成员能够更高效地进行版本管理与发布。
学习并实施更多的 Git 高级命令
深入理解 git rebase 和 git reset 等 Git 高级命令的使用场景，进一步简化开发流程，提高团队协作效率。
3. 本人/本小组/本部门能力提升与学习计划
个人提升计划
深入学习和实践 Git 使用技巧，尤其是在团队协作中的使用，确保开发流程的高效与清晰。
学习更多关于蓝牙技术的细节，特别是在音频流处理和设备互联方面的深入理解。
提升自己在嵌入式开发方面的能力，特别是针对音频相关的系统调试和优化工作。
小组能力提升计划
开展小组内部的技术分享会，定期学习分析、调试技巧和系统优化等内容。
加强小组成员在功能调试方面的培训，确保每个人都能够快速定位和解决相关问题。
部门能力提升计划
在部门内部推行代码审查和自动化构建流程，提升代码质量和协作效率。
引导部门成员使用更高效的开发工具，提升开发效率和产品质量。
4. 对 BU（业务单元）的建议
增强跨部门沟通与协作
在开发过程中，建议加强与其他部门的沟通，尤其是与硬件团队和测试团队的协作，确保软件和硬件的匹配度高，并且能够更快速地解决问题。
持续优化开发工具链
提议在 BU 内部推广自动化构建，提升版本发布的效率，并减少人为错误的风险。
加强培训与技术学习
定期开展技术培训，帮助团队成员提升核心技能，尤其是与项目出现相关的问题、嵌入式开发等领域的知识，有Wiki记录形成过程文档以保证团队技术能力的持续增长。
### 5月总结报告
1. 歌乐项目（9/8寸-XU平台）
✅ Bug修复与功能优化
媒体音量状态显示错乱 ：已定位并修复。
设置界面白天亮度滑动条异常回弹问题 ：已完成修复。
任意界面按学习方控静音键时，音量条不消失 ：解决该交互逻辑问题。
EQ界面Phase/Slope数值恢复默认值后声音效果未同步 ：修复数值与实际音频处理的同步逻辑。
部分翻译字段刷新不及时 ：补充通知事件机制，实现UI实时更新。
调整判断逻辑 ：将原有直接使用项目名判断的if逻辑封装成函数，提高可读性与扩展性。
调节Phase/Slope参数后，ACC OFF/ON再开机声音变大问题 ：定位为配置保存异常，已修复。
关机状态下倒车时后台有声音输出 ：排查并修正电源管理与音频通道控制逻辑。
蓝牙音乐切换至收音界面时存在残余音频输出且音量增大 ：优化音频焦点切换逻辑。
POWER键关机后仍播放音乐问题 ：修复音频服务关闭时机与系统生命周期绑定问题。
🔁 模块重构与代码优化
对多个模块进行代码结构调整，去除冗余判断，增强可维护性。
按照 Google Style Guide 规范统一代码风格。
引入评审规范，确保每次提交符合团队编码标准。
2. 德国蓝宝6.75寸项目
🎨 UI界面更新
完成Radio、主界面、USB、顶栏、蓝牙等模块的部分UI替换。
新UI适配新设计稿，正在进行细节优化与一致性调整。

一、重点任务完成情况
1. 歌乐项目问题修复
音频模块

修复媒体音量状态显示错乱、静音键触发音量条异常消失问题（0511周）

解决EQ界面 Phase/Slope 数值复位后音效未同步、ACC开关机后音效异常放大问题（0518周）

修复关机后音乐持续播放、倒车中后台异常输出声音、界面切换时蓝牙音量突增问题（0525周）

UI交互模块

优化设置界面亮度调节光标滑动逻辑（0511周）

补充多语言翻译实时刷新机制（0518周）

2. 德国蓝宝6.75寸项目UI升级
完成Radio/主界面/USB/蓝牙等核心模块的UI切图替换（0601周）

待处理：部分细节UI适配优化（持续进行中）

3. 代码质量优化
重构设置模块逻辑：封装项目名判断函数，替代分散的 if 条件（0518周）

持续遵循 Google Style Guide 规范调整代码结构（0518/0525/0601周）

二、核心进展与产出
模块	关键成果	影响
音频逻辑	修复5项音效控制BUG，覆盖开关机/静音/ACC等场景	提升系统音频稳定性
UI交互	完成蓝宝项目70%核心界面UI替换	推动新版本交付进度
代码架构	消除冗余判断逻辑，建立统一函数封装规范	增强可读性与维护效率
三、能力提升与学习计划
业务流程标准化

持续梳理音频设置、多语言刷新等核心流程文档

代码质量优化

全月累计重构3个模块代码，覆盖设置/收音/音频逻辑

严格执行代码评审规则（0601周新增）

技术规范落地

推动团队应用 Google Style Guide 统一编码风格

四、问题与建议
问题排查流程优化

建议在禅道BUG修复记录中补充：

问题根因分析（硬件/软件）

关键解决步骤与Commit ID
示例：

BUG#1234 关机后音乐持续播放
根因：电源事件未触发音频资源释放
修复：在AudioManager::onPowerOff() 增加资源回收逻辑 [Commit: a1b2c3d]

五、6月重点计划
歌乐项目

跟进XU平台（9/8寸）测试问题，修复收音模块遗留BUG

德国蓝宝项目

完成剩余UI细节适配，推进测试验收

技术深化

开展模块间通信机制学习，优化跨模块事件处理效率

#### 20250505-0511周总结
本周重点任务完成情况总结；
歌乐项目禅道问问题修复
对策了：
 媒体音量状态显示错乱
 设置界面拖动屏幕白天亮度小光标会回来滑动
 任意界面按学习方控上的静音键，弹出音量条不会消失
下周重点任务计划；
熟悉各项目模块代码
跟进禅道上的歌乐9/8寸-XU平台上面的测试的问题
3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量

#### 20250512-0518周总结
本周重点任务完成情况总结；
歌乐项目禅道问问题等修复
对策了：
EQ界面Phase/Slope数值恢复到默认值，实际声音效果没有恢复
部分翻译缺少通知事件导致没有实时刷新
调整部分判断逻辑，优化直接判断项目名字的if逻辑，封装成函数，改用调用函数的方式，增加可读性
2.下周重点任务计划；
熟悉各项目模块代码
修改bug同时对模块内代码进行重构优化
修复调节Phase/Slope，ACC OFF/ON ，开机后声音效果变大等设置模块问题
3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量，根据google-styleguide来调整优化

#### 20250519-0525-周总结报告
本周重点任务完成情况总结；
歌乐项目禅道问题等修复
对策了：
EQ→Filter→调节Phase/Slope，ACC OFF/ON ，开机后声音效果变大，概率100%
关机状态，倒车中后台有声音输出
播放蓝牙音乐，再进入收音界面 现象：蓝牙音乐声音有输出1秒且声音变大
2.下周重点任务计划；
熟悉各项目模块代码
修改bug同时对模块内代码进行重构优化
修复收音模块的问题
3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量，根据google-styleguide来调整优化
4.对BU的建议。
遇到的问题，比如禅道上面的问题，如果有时间的话可以写清楚解决的方法和原因或者具体修复commit的ID，特别有些是硬件和软件都有可能导致的问题，记录一下排查的思路。

#### 20250526-0601-周总结报告
本周重点任务完成情况总结；
歌乐禅道项目问题修复：
播放USB音视频/蓝牙音乐、CPAA音乐，按面板POWER键关机，音乐还会继续播放
德国蓝宝6.75寸项目更换新UI
Radio,主界面，usb，顶栏，蓝牙已经替换部分UI切图，还有些细节没有处理
2.下周重点任务计划；
继续调整德国蓝宝的新UI
修改bug同时对模块内代码进行重构优化
3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量。
根据google-styleguide来调整优化
按照代码评审记录的统一规则来提交代码
4.对BU的建议。
无

#### 20250602-0608-周总结报告
本周重点任务完成情况总结；
德国蓝宝6.75寸项目更换新UI
Radio,主界面，usb，继续完善替换部分缺失的UI切图，优化显示细节，新按钮增加对应的触发函数

2.下周重点任务计划；
继续调整德国蓝宝的新UI
修改bug同时对模块内代码进行重构优化
3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量。
根据google-styleguide来调整优化
按照代码评审记录的统一规则来提交代码
4.对BU的建议。
无

#### 20250609-0615-周总结报告
本周重点任务完成情况总结；
德国蓝宝6.75寸项目更换新UI
调整主界面，radio键盘，usbphoto，顶栏的UI
Radio模块的UI问题修复,修复收音点击预存台不更新滑条位置

2.下周重点任务计划；
新增印度歌乐项目的主界面切图以及工作逻辑

3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量。
根据google-styleguide来调整优化
按照代码评审记录的统一规则来提交代码
编写脚本，优化配置来实现配置宏或者读取值来实现增删更换功能
4.对BU的建议。
无

#### 20250616-0622-周总结报告
本周重点任务完成情况总结；
歌乐新UI的主界面移植
在制作过程中发现经常要跨源获取信息时要做重复工作
后面可以考虑增加共享操作或者全局变量，不用管内部的处理和实现，直接获取需要的值即可

2.下周重点任务计划；
调整歌乐的新UI，修复bug
修改bug同时对模块内代码进行重构优化

3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量。
根据google-styleguide来调整优化
按照代码评审记录的统一规则来提交代码
4.对BU的建议。
无
#### 20250623-0629-周总结报告
本周重点任务完成情况总结；
歌乐禅道项目问题修复：
播放USB音视频/蓝牙音乐、CPAA音乐，按面板POWER键关机，音乐还会继续播放
德国蓝宝6.75寸项目更换新UI
Radio,主界面，usb，顶栏，蓝牙已经替换部分UI切图，还有些细节没有处理
2.下周重点任务计划；
继续调整德国蓝宝的新UI
修改bug同时对模块内代码进行重构优化
3.本人/本小组/本部门能力提升与学习计划；
整理业务流程，优化代码质量。
根据google-styleguide来调整优化
按照代码评审记录的统一规则来提交代码
4.对BU的建议。
发放软件：所处分支和最后具体定位修改的没有明确贴出来，后续维护混乱，有个公共位置存放和迭代的软件版本库，
改动：无论是硬件还是软件更新或者改动，必须要发邮件通知到相关人员，或者大家会议讨论确定修改和注意事项，不要无记录修改
很多问题，需要多对比，先排查出来是硬件问题还是软件问题，进行总结归类，下次遇到类似的问题就可以快速定位，而不是靠猜，改一点试一下，同时最好可以输出指标性文档有评判标准具有说服力。
软件最好也有针对系统的指标，比如说cpu占用率，内存占用，将某个模块限制一定的范围属于正常等等
目前对于整体项目没有记录文档，很多旧项目不熟悉和难以维护