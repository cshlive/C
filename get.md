# 关于系统调用和库函数
1. 系统调用通常用于底层文件访问（low-level file access），例如在驱动程序中对设备文件的直接访问。

**系统调用是操作系统相关的，因此一般没有跨操作系统的可移植性 **

系统调用发生在内核空间，因此如果在用户空间的一般应用程序中使用系统调用来进行文件操作，会有用户空间到内核空间切换的开销。
使用库函数也有系统调用的开销，为什么不直接使用系统调用呢？这是因为，读写文件通常是大量的数据（这种大量是相对于底层驱动的系统调用所实现的数据操作单位而言），这时，使用库函数就可以大大减少系统调用的次数。这一结果又缘于缓冲区技术。在用户空间和内核空间，对文件操作都使用了缓冲区，例如用fwrite写文件，都是先将内容写到用户空间缓冲区，当用户空间缓冲区满或者写操作结束时，才将用户缓冲区的内容写到内核缓冲区，同样的道理，当内核缓冲区满或写结束时才将内核缓冲区内容写到文件对应的硬件媒介。
****

* 进程中每个打开的文件都用一个编号来标识，称为文件描述符，文件描述符1表示标准输出，对应于C标准I/O库的stdout
* 用Unbuffered I/O函数每次读写都要进内核，调一个系统调用比调一个用户空间的函数要慢很多，所以在用户空间开辟I/O缓冲区还是必要的，用C标准I/O库函数就比较方便，省去了自己管理I/O缓冲区的麻烦。

* 用C标准I/O库函数要时刻注意I/O缓冲区和实际文件有可能不一致，在必要时需调用fflush(3)。

* 我们知道UNIX的传统是Everything is a file，I/O函数不仅用于读写常规文件，也用于读写设备，比如终端或网络设备。在读写设备时通常是不希望有缓冲的，例如向代表网络设备的文件写数据就是希望数据通过网络设备发送出去，而不希望只写到缓冲区里就算完事儿了，当网络设备接收到数据时应用程序也希望第一时间被通知到，所以网络编程通常直接调用Unbuffered I/O函数。

* 注意open函数与C标准I/O库的fopen函数有些细微的区别：

    以可写的方式fopen一个文件时，如果文件不存在会自动创建，而open一个文件时必须明确指定O_CREAT才会创建文件，否则文件不存在就出错返回。

    以w或w+方式fopen一个文件时，如果文件已存在就截断为0字节，而open一个文件时必须明确指定O_TRUNC才会截断文件，否则直接在原来的数据上改写。
    
******
规定一些特殊语法表示字符类、数量限定符和位置关系，然后用这些特殊语法和普通字符一起表示一个模式，这就是正则表达式
2. fork函数的特点概括起来就是“调用一次，返回两次”，在父进程中调用一次，在父进程和子进程中各返回一次。
3. 父进程通过fork可以将打开文件的描述符传递给子进程

子进程结束时，父进程调用wait可以得到子进程的终止信息

几个进程可以在文件系统中读写某个共享文件，也可以通过给文件加锁来实现进程间同步

进程之间互发信号，一般使用SIGUSR1和SIGUSR2实现用户自定义功能



 # 日常任务
1.  关于QT学习的布局管理器
* 水平（ctrl+H），垂直（ctrl+L），分裂器（运行后可以自己拖拉伸缩），伙伴（&+英文快捷键，快速定位），tab顺序（运行后按TAB键会自动跳焦点），定位器（ctrl+K,输入前面一个字符+空格+定位内容）
2. 主窗口
菜单栏和工具栏他们的action编辑，dock部件（工具箱）
3. 事件系统
事件的处理：先传递到指定窗口部件的（先获得焦点的窗口部件），若该部件忽略该事件就会传到该部件的父部件
调用父类的函数实现默认操作时，在子类的实现函数里面要注意代码顺序，先调用再ignroe().
重新实现事件处理函数时，一般要调用父类的相应事件处理函数来实现默认操作
Qt中事件对象默认是 accept 的，而作为所有组件的父类QWidget的默认实现则是调用ignore()。
很棒的讲解：https://zhuanlan.zhihu.com/p/50053079
4. QT对象模型和容器类
信号和槽的关联
connect函数参数（发射信号的对象，发射的信号，接受信号的对象，执行的槽（在声明的时候必须使用slots关键字））对于信号和槽必须使用SIGNAL（）和SLOT（）宏；很棒的讲解：https://zhuanlan.zhihu.com/p/86313966
属性系统：
声明属性的必备条件：
    继承于QObject
    使用Q_OBJECT宏
    使用Q_PROPERTY宏

属性声明有2种形式，带MEMBER和不带MEMBER字段；
1. 不带MEMBER字段
形式为：类型+属性名+READ+get函数+WRITE+set函数，其中WRITE+set函数为可选。
2. 带MEMBER字段
形式为：类型+属性名+MEMBER+成员变量名+READ+get函数+WRITE+set函数，其中READ+get函数+WRITE+set函数为可选。
对象树
容器（迭代器）

深复制会复制一个对象，浅复制则是复制一个引用（仅仅是一个指向共享数据库的指针）
=（隐形共享类仅需设置指针和增加引用计数的值）

5. 界面外观
样式表比调色板好，不受其他平台限制，方便实现快速换肤

6. 国际化
使用QT Linguist翻译程序
配置环境变量：
```
export QTDIR=/opt/Qt5.3.2/5.3.2
export PATH=$QTDIR/gcc_64/bin:$PATH
export LD_LIBRARY_PATH=$QTDIR/gcc_64/lib
```
7. 2D绘图


8. 图形视图动画和状态机框架

gdb调试参数：
-可执行文件 开始调试
进入gdb调试后：
s（往下走，可以进入函数内）
n（源代码行数往下走）
bt（看帧关系）
info loacals（变量数值）
p（打印，后面语法一样）
q（退出）


* 装搜狗输入法：(装依赖)
```
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
sudo apt install -f
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
```
*****
* 构造方法用来初始化类的对象，与父类的其它成员不同，它不能被子类继承（子类可以继承父类所有的成员变量和成员方法，但不继承父类的构造方法）。因此，在创建子类对象时，为了初始化从父类继承来的数据成员，系统需要调用其父类的构造方法。子类构造函数必须要调用父类的构造函数（无论显式还是隐式），本质原因在于继承的性质决定了必须先有父再有子！

* 信号：特定情况触发的被发射的时间，如点击信号
* 槽：对信号响应的函数，当信号发射时，关联的槽函数被自动执行，信号和槽关联通过QObject::connect()函数实现的
* QDialog dialog 这样是定义了一个对象，QDialog  * dialog 是定义了一个指向QDialog类对象的指针变量
* 回调函数的应用非常的广泛。通常，我们需要一个统一得接口来实现不同内容的时候，用回调函数来实现就非常合适；可以实现对象之间的通信

```
QOject::connect(sender,SIGNAL(signal()),recevier,SOLT(slot()));
```
* 继承：
```
class  QWDlgManual : public QDialog
```


dpkg锁解决案例：
```
sudo rm /var/lib/dpkg/lock-frontend
    （sudo apt-get  install libgstreamer0.10-dev）
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
```
*****


9. DAB的数据流： 进入某个模块，先创建一个根窗口，初始化与硬件进行通讯，获取DAB版本号。获取电台数量
创建公钥1：ssh-keygen -t rsa -C "chensh@maxmade.com"
2：ssh-keygen -t rsa -C "chensh@maxmade.com" -f ~/.ssh/second_rsa
 cd ~/.ssh
得到公钥2：ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0zc7POAnjyypRmX78lgTTm+AmWGT/jycIAG4flZTD42yPuMjdGCwrGJaq06JzNOxWYFKiaTpLakjanbGfV6/jc9VeVgoAvzZXg8Xa7ylSe1t+33v9O6y8FUOZVHeXZxwQ7iqTEEhuK7sQtPJ0OoAehp2/GTaIF+FiVTLhSRAcSBK6IH/INM502kLNdwpu/z9r1GpbXqFkn61usmEN90cJuLza9uIaXOCxO1sa3yig3Mgyiu4N5ma3egpKeh+g/A04b043E5MaIxS3g6FnigKr41BYsVSTal/8lmFtWCNpAq1VXVtx0VYPsFYZymK5InITgoTpDL7fBJ77O7FIcP/9 chensh@maxmade.com

# git命令的使用
1. 常用
git status  查看当前状态
git log  查看提交日志
git merge dev  合并dev分支至当前分支
git add .      添加当前目录全部文件至暂存区
git commit -m '测试'     提交，提交信息为测试
git push origin master  推送至远端分支（master为需要推送分支，按实际需要选择）
git pull origin master  合并远端分支至本地 (git pull 等于 git fetch + git merge)
git pull --rebase origin master rebase方式合并远端分支至本地
git branch 查看当前分支
git branch dev 创建dev分支  （dev可选）
git branch -d dev 删除dev分支
git branch -r 查看远程分支
git branch -a 查看所有分支 （包括远程分支）
git checkout master 切换至master分支
git checkout -b dev 创建dev分支并切换至dev分支
git checkout -b dev origin/dev 创建远程分支到本地
git restore file 丢弃工作区修改（file为具体文件名称）
git restore * 丢弃所有工作区修改
git restore --staged file  回退暂存区文件 不会更改文件内容
git rebase --continue   rebase后继续操作
git rebase --abort 退出rebase 操作


git reset：回退版本，可指定某一次提交的版本。git reset [--soft | --mixed | --hard] commitId。
git revert：撤销某个提交，做反向操作，生成新的commitId，原有提交记录保留。git revert commitId。
回退分两种情况：
   已 commit，未push到远程仓库。

    git reset --soft（撤销commit）。

    git reset --mixed（撤销 commit 和 add 两个动作）。

已 commit，并且push到了远程仓库。

    git reset --hard（撤销并舍弃版本号之后的提交记录）。

    git revert（撤销，但是保留了提交记录）。

git checkout .(清空工作区，恢复到刚pull下来的状态)

2.解决冲突：
根据上面的学习过程，我总结了一个解决冲突的常规流程：

    1. 前提条件：不能在 master 分支上修改任何文件。master 分支的变更只能通过 git pull 和 git merge 获得。在 master 分支下面，不能手动修改任何文件。
    2. 我们自己有一个分支用来修改代码，例如我的分支叫做dev分支。我把代码修改完成了，现在不知道有没有冲突。
    3. 在 dev 分支里面，执行命令git merge origin/master，把远程的master分支合并到当前dev分支中。如果没有任何报错，那么直接转到第5步。（此方法无法合并）
    4. 如果有冲突，根据提示，把冲突解决，保存文件。然后执行命令git add xxx把你修改的文件添加到缓存区。然后执行命令git commit -m "xxx"添加 commit 信息。
    5. 执行如下命令，切换到 master 分支：git checkout master。
    6. 执行命令git pull确保当前 master 分支是最新代码。
    7. 把dev分支的代码合并回 master 分支：git merge dev。
    8. 提交代码：git push。

原因：本地修改的文件和目标远程库对同一个文件都有修改。这时无论是统一分支的pull，push，还是不同分支的merge时都会产生冲突。

解决办法：

方法一（放弃本地，使用远程）：

git pull 出现冲突后丢弃本地冲突文件修改，采用远程文件覆盖本地文件git checkout [文件路径]例：git checkout test/src/main/resources/spring-shiro.xml

方法二（暂存到暂存区，更新后，从暂存区取出合并解决冲突）：

git pull 出现冲突后可以暂存本地修改git stash ,然后git pull 更新代码，git stash list 可查看暂存记录列表，释放本地暂存 git stash apply stash@{0} ，出现冲突文件，找到并解决，然后可以提交git add . 加入索引库，然后本地提交git commit -m '注释' 最后git push到远程。

方法三（更新发现冲突，提交本地，再更新，找到冲突地方解决后，再次提交推送远程）：

1、git pull更新代码，发现error: Your local changes to the following files would be overwritten by merge:pom.xmlPlease commit your changes or stash them before you merge.这说明你的pom.xml与远程有冲突，你需要先提交本地的修改然后更新。

2、git add pom.xml

git commit -m '冲突解决'

提交本地的pom.xml文件，不进行推送远程

3、git pull

更新代码Auto-merging pom.xmlCONFLICT (content): Merge conflict in pom.xmlAutomatic merge failed; fix conflicts and then commit the result.更新后你的本地分支上会出现 (develop|MERGING)类似这种标志。

4、找到你本地的test.txt文件，并打开你会在文件中发现<<<<<<< HEAD ，======= ，>>>>>>> ae24sgwmfp2m2ojr2jaagwhhfawe2类似这样的标记。

<<<<<<< HEAD和=======中间的是你自己的代码， ======= 和>>>>>>>中间的是其他人修改的代码自己确定保留那一部分代码，最后删除<<<<<<< HEAD ，======= ，>>>>>>>这种标志。

5、git add test.txt && git commit -m '冲突解决结束'  再次将本地的test.txt文件提交。

6、git push将解决冲突后的文件推送到远程。

只要所有开发者都遵守这个规则，那么解决冲突是一件非常容易的事情。

快捷方法：cp out/ISPBOOOT.BIN /media/chenshihao/6564-3661 && umount /media/chenshihao/6564-3661 （复制文件夹内的文件到另外一个位置且卸载U盘ps：用pwd获取路径）


1.全部编译项目命令：./mk8388cxx.sh 1  &&  ./mk8388cxx.sh all 
只是修改了代码编译项目命令：./mk8388cxx.sh app && ./mk8388cxx.sh rom

2.项目头文件位置：Direct8388GitServer/appliction/include/
项目配置文件位置：Direct8388GitServer/appliction/config/maxmade/
这两个地方都是对应项目存放配置文件的地方
其中主要有XX-XXXX-XX.h和app_config文件放了很多关于功能的宏，这些宏都可以在代码里面搜索到，可以看一下具体做了什么，是什么功能，删除或者添加可以修改项目的功能。

3.git 相关命令
注意：输入git commit命令之前要git pull一下，更新到最新代码之后再提交自己的修改。不然如果别人先提交了同样的文件修改，就会跟你的提交产生冲突，你就提交不了了。需要整合冲突才能提交。方法就是先把冲突的文件从暂存区移出来，然后复制到另一个地方，然后使用git checkout命令删除当前文件的修改，更新最新代码，然后再重新把你的修改加进去（推荐使用Meld软件），重新add进去，然后commit，最后push。

git pull                    更新最新的代码状态
git status|less             查看当前修改代码状态
git checkout 文件名          删除当前文件的修改
git diff 文件名              查看当前文件的修改内容
git add 文件名               将当前文件修改提交到暂存区
git commit -m "修改内容"      提交暂存区内容到本地仓库
git push                    将本地仓库的修改提交到服务器

git log                     显示提交了的log
git show  log的ID           显示ID对应的log修改的内容

git reset HEAD 文件名        将文件从暂存区中移出，就是撤销add操作（还没有执行commit）
git reset --soft HEAD^      撤销执行commit（还没有执行push）
git reset --hard HEAD^      撤销执行commit，连add也撤销（还没有执行push）

git config user.name 'name'           修改git author用户名字
git config user.email email-address   修改git author邮件地址
git diff  --name-only  . |grep "cfg"    查看修改的文件里面包含cfg名字的


# 经验
1. 增改翻译：先在系统.pro配置文件加上对应的ts：TRANSLATIONS = \ 
改变翻译的.ts文件（1：在项目application/ui2/splaucher目录下；2：在application/config/maxmade/项目文件/language下面），利用qt语言家（打开目录在qt安装目录的bin文件底下）
用qt的languist先制作好ts文件（更新翻译），再生成qm文件（发布翻译），再在qt程序里面加载qm文件即可实现国际化

2. 更换开机logo
(1). 更换开机logo： 
找到项目底下目录的build/Tools/binary_gen，在此用终端打开，把焦点换到文件。把同名文件脚本拖到终端，再把bmp文件拖进去生成一个.bin文件，把这个文件拷贝到application/config/maxmade/项目名字，放到logo文件夹下并且rename文件为logo.bin
图片格式要求为24位bmp(不能为大写的BMP,否则会无法显示),颜色为256色的图片 (如何获取24位256色的图片,可将24位大于256色的图片让美工先转为256色8位的图片,再转回24位,这样将可将logo图片的颜色降为256色);
(2). 生成可更换开机logo的方法：
1.进入code的build/tools/binary_gen路径下 将图片也一并放入此目录下  图片格式要求为24位bmp图片
2.使用命令./isp_bin_gen_palette  图片1 图片2 。。。生成每张图片对应的.bin文件以及将图片打包在一起的isp_part.bin文件  生成每张图片对应的.bin文件(需注意有没有各个图片对应的bin,没有就是错的)以及将图片打包在一起的isp_part.bin文件（每个图片命名格式为应为logo1.bmp，logo2.bin..........）
3.将isp_part.bin文件更名为logo.bin  并将其复制到对应的配置路径下(对应项目config下的logo_1024_600文件夹内)
code中需要更改：
4.Boot_logo.c中将图片对应的bin名加入logo_list中
```
static logo_list nor_logo_list[] =
 {
- {"logo.bin",},
+ {"logo1.bin",},{"logo2.bin",},{"logo3.bin",},
 };
注意：logo1为图片打包时对应的名字！，有多少张图片则添加多少个bin名
```
5.通过更改Cmd_bootsp.c中show_normal_logo的下标参数来对logo进行更改
```
-	show_normal_logo(0);
+	show_normal_logo(1);

```
6.要使用多logo还需在头文件内定义宏#define SUPPORT_LOGO_SWITCH 4   //支持可选开机logo和设置数量，并在setup.ini文件内添加该选项
7.同时还需要在项目的配置文件defconfig中将
```
# LOGO Setting
#
# CONFIG_GLB_GMNCFG_LOGO_FMT_LUT8 is not set
CONFIG_GLB_GMNCFG_LOGO_FMT_ARGB8888=y
CONFIG_GLB_GMNCFG_UBOOT_LOGO_ON_DEFAULT=y
# CONFIG_GLB_GMNCFG_UBOOT_LOGO_ON_2ND_FB1 is not set
# CONFIG_GLB_GMNCFG_UBOOT_LOGO_ON_SUP is not set
改为
# LOGO Setting
#
CONFIG_GLB_GMNCFG_LOGO_FMT_LUT8=Y
#CONFIG_GLB_GMNCFG_LOGO_FMT_ARGB8888 is not set
#CONFIG_GLB_GMNCFG_UBOOT_LOGO_ON_DEFAULT is not set
# CONFIG_GLB_GMNCFG_UBOOT_LOGO_ON_2ND_FB1 is not set
CONFIG_GLB_GMNCFG_UBOOT_LOGO_ON_SUP=y
```

ps:注意:如果编译后出现Error: Assgined partition size is less than the image size: logo, 3145728 < 3693568这样的错误
则需要修改
8368-U-Project2-TD/8368-U-20200422/build/platform_cfg/4RlsCode_8368_U_sunplus_cfg/isp.sh内        logo         0x300000  \ logo 分区的大小,一般加20000的倍数,如加到0x340000或0x1000000
样例：
准备两张大小为1024×600的24位.bmp图片  logo1.bmp logo2.bmp
1.使用./isp_bin_gen_palette logo1.bmp logo2.bmp  
2.生成logo1.bin logo2.bin isp_part.bin
3.将isp_part.bin文件更名为logo.bin 
4.用它替换掉application/config/sunplus/sunplus_demo/logo_1024_600/路径下的logo.bin
5.将logo_list中的内容改为{"logo1.bin",},{"logo2.bin",},
6.根据需要将图片下标填入show_normal_logo的参数中，达到更改图标的目的
(3). 动态logo 制作方法：
1.从美工处获得.mkv的视频文件,修改视频名为logo.mkv
2.使用库内build/tools/binary_gen/isp_bin_gen_palette脚本文件添加.mkv文件生成isp_part.bin文件
3.将isp_part.bin文件改名为animation_logo.bin
4.将文件添加到对应的动态logo存放处
5.TD的话需要在config对应项目的logo_1024_600文件夹下将静态logo改为黑屏的静态logo,即文件夹内的这个,防止没有静态logo动态logo闪白屏现象

3. 合并代码：每次修改代码后，准备提交到远程，先git add 放到暂存区，再git pull，如果冲突，先把本地冲突文件，git reset HEAD 文件名，复制到另外一个地方，再git checkout  . 放弃修改，再打开meld，把冲突代码，将自己的代码加进去，再git add 文件名，git commit ，git push
4. 对Linux机器进行截屏：
1.将可执行文件screenshot拷贝至U盘
2.将U盘插到linux平台机器上
3.通过超级终端命令行进入挂载的U盘目录下，执行./screenshot,会生成一个命名为screenshot+时间戳的jpg截图文件（使用U盘前，我们先要为外挂点新建一个子目录，一般外挂点的子目录都是建立在/mnt里面的，我们也建在那里，当然也可以建在/目录下，名字可以自己定，我们就取名为usb，终端下的命令如下：  mkdir /mnt/usb    然后我们就可以接上我的U盘了，然后在终端下输入命令并击Enter键即可：  mount /dev/sda1 /mnt/usb    在Windows下当我们用完U盘后，在我们取下U盘前我们先要删除，同样在Linux下我们也要删除挂起点，方法是：   umount /dev/sda1 /mnt/usb 或 umount /dev/sda1   如果不把U盘给umount掉，那样很容易造成数据的丢失 ）
```
mount /mnt/sda1
```
ps：注意：
一张图片最好多截几次，防止截图失败生成无法查看的图片。
5. 使用打印工具minicom ：
https://worthsen.blog.csdn.net/article/details/77662637?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EOPENSEARCH%7ERate-4-77662637-blog-120830919.pc_relevant_3mothn_strategy_and_data_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EOPENSEARCH%7ERate-4-77662637-blog-120830919.pc_relevant_3mothn_strategy_and_data_recovery&utm_relevant_index=9