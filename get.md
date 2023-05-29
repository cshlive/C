# 以前笔记
C++对c的增强：
（1）全局变量检测int a；int a = 10；（C语言可以通过，但C++不可以）
（2）函数检测，参数类型个数等
（3）类型转换检测，必须强制类型转换
（4）struct增强，里面可以放函数
（5）bool数据，（c里没有）
（6）三目运算符增强，c中返回值，C++返回变量
（7）const增强，c中可以通过指针修改值，伪常量，但C++相当于一个Key：value符号表，没分配内存，自然也没办法修改，可以真正替换初始初始化数组int a[value]
引用：就是起别名，一个指针常量，还有指针引用，常量引用（参数里面加const）
重载：
（1）重载条件：必须在同一作用域，不同参数类型，数量，默认参数不能产生二义性
（2）返回值不可以作重载条件
内联函数：
（1）类内部成员，默认加inline
（2）类似于宏，但是是优化版，宏定义缺陷不知类型，比如a++，它不会灵活用
引用重载：
必须有合法的内存空间
const也可作为重载的条件 int tmp = 10； const int &a = tmp；
封装：
C语言封装：行为和属性分开，类型检测不强；
C++封装，严格类型转换检测，让属性和行为绑在一起，作为一个整体来表示生活整体事物。另外还有控制权限，public，protecteed，private；
尽量用私有方法设置成员属性，自己提供公共的对外接口进行set和get方法来访问变量。
引用传递花销会少一点，值传递会额外增加一个中间值传递。
利用全局函数（要两个不同的参数）和成员函数（另外一个参数跟自己本身内部变量对比，只需另外一个参数）进行判断，参数有所不一样。
构造函数:(放在public里)
构造函数（对象初始化），与类名相同，没有返回值，不用写void，可以发生重载（可以带参数），编译器会自动调用，但只有一次。
析构函数没有参数
分类有两种方式：1.参数{无参构造函数（默认），有参构造函数}；2.类型{普通构造函数，拷贝构造函数(Person(const Person&p）),放另外一个对象)}
Person(10)是匿名对象，执行完当前行就会释放这个对象
拷贝构造函数Person(const Person& p），Person p2 (p1)；或者Person p2 = Person(p1);不能用拷贝构造函数初始化匿名对象
默认拷贝构造函数是值传递，只可以传递属性值
？？？什么适合调用拷贝构造函数（不是很理解），用已经创建好的对象创建新对象
浅拷贝：是系统默认提供的拷贝函数，只是很肤浅的值拷贝属性的地址和名称，一旦放在堆上的变量释放掉，后面也想跟着删掉，但是没得删，报错（解决问题需要自己创建拷贝构造函数）。而深拷贝则会另外开辟一块内存用来用来存放
对象初始化列表，构造函数后面加：属性值（参数）
当类对象作为类的成员，构造顺序先构造类对象，然后构造自己，析构则与之相反。
explicit关键字是防止构造函数中的隐式类型转换
所有new出来的对象都会返回该类型的指针，malloc则返回void*，并且还要强转，也不会调用构造函数。new是一个运算符，malloc则是系统提供的函数。
new运算符，new出来数组，如何释放？delete [] 数组名；中括号非常重要，不然只会释放一个。同时new出来数组，肯定会调用默认构造函数，如果有参了，记得也要有默认无参构造函数。
staic静态成员变量，类内声明，类外实现定义。编译的时候分配内存，可以实现多个对象共享同一数据（通过对象访问属性；通过类名：：访问属性），可以权限控制
静态成员函数，不可以访问 普通成员变量，因为共享数据，无法识别将哪个对象的修改，但是可以访问静态成员变量，因为不需要区分
单例模式：一个类只有一个全局对象
常函数 void func（）const，常函数修饰this指针 const Type（Person） * const this；常函数不能修改this指针指向的值；
常对象 不可以调用普通的成员函数	常对象 可以调用常函数




## C++
```


```





## 关于系统调用和库函数
*******
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


********
 ## Linux基础命令

*****

 * 装搜狗输入法：(装依赖)
```
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
sudo apt install -f
sudo dpkg -i sogoupinyin_2.2.0.0108_amd64.deb
```
*****

* dpkg锁解决案例：
```
sudo rm /var/lib/dpkg/lock-frontend
    （sudo apt-get  install libgstreamer0.10-dev）
    sudo rm /var/cache/apt/archives/lock
    sudo rm /var/lib/dpkg/lock
```
*****
* 安装Ubuntu的wine微信：
```
https://blog.csdn.net/Q1013331Q/article/details/125513765


Ubuntu安装微信，三步到位


不废话废话，直接来！

第一步浏览器打开下载：

http://archive.ubuntukylin.com/software/pool/partner/ukylin-wine_70.6.3.25_amd64.deb

第二步浏览器打开下载：

http://archive.ubuntukylin.com/software/pool/partner/ukylin-wechat_3.0.0_amd64.deb

第三步输入指令：

sudo apt-get install -f -y ./ukylin-wine_70.6.3.25_amd64.deb
sudo apt-get install -f -y ./ukylin-wechat_3.0.0_amd64.deb

    1
    2

如图
这时便可以上微信啦！

```


* 配置公钥：ssh-keygen -t rsa -C "chensh@maxmade.com" -f ~/.ssh/second_rsa
 cd ~/.ssh
得到公钥2：ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC0zc7POAnjyypRmX78lgTTm+AmWGT/jycIAG4flZTD42yPuMjdGCwrGJaq06JzNOxWYFKiaTpLakjanbGfV6/jc9VeVgoAvzZXg8Xa7ylSe1t+33v9O6y8FUOZVHeXZxwQ7iqTEEhuK7sQtPJ0OoAehp2/GTaIF+FiVTLhSRAcSBK6IH/INM502kLNdwpu/z9r1GpbXqFkn61usmEN90cJuLza9uIaXOCxO1sa3yig3Mgyiu4N5ma3egpKeh+g/A04b043E5MaIxS3g6FnigKr41BYsVSTal/8lmFtWCNpAq1VXVtx0VYPsFYZymK5InITgoTpDL7fBJ77O7FIcP/9 chensh@maxmade.com
（后面有公钥后怎么进入连接服务器，将自己的公钥添加进配置文件“.什么的文件”）
gedit id_rsa.pub 
cd
 ssh git@192.168.30.5
 公匙免密码操作：
ssh-keygen -t rsa
ssh-copy-id -i ~/.ssh/id_rsa.pub  git@192.168.30.5 -p 22
git pull

* 打包和压缩文件：
tar 文件打包 c创建包文件  f 指定目标文件  v显示文件名称  t显示包中内容 x释放包中内容  z使得tar可以直接进行压缩和解压的功能    

压缩文件实现过程：要将文件先进行打包，然后压缩，再解压

使用方法：tar cvf  +文件 打包文件 

直接压缩和解压：tar zcvf +文件       tar zxf +文件 

gzip 压缩和解压文件 

把常用的tar解压命令总结下，当作备忘：

tar

-c: 建立压缩档案
-x：解压
-t：查看内容
-r：向压缩归档文件末尾追加文件
-u：更新原压缩包中的文件

这五个是独立的命令，压缩解压都要用到其中一个，可以和别的命令连用但只能用其中一个。下面的参数是根据需要在压缩或解压档案时可选的。

-z：有gzip属性的
-j：有bz2属性的
-Z：有compress属性的
-v：显示所有过程
-O：将文件解开到标准输出

下面的参数-f是必须的

-f: 使用档案名字，切记，这个参数是最后一个参数，后面只能接档案名。

#tar -cf all.tar *.jpg
这条命令是将所有.jpg的文件打成一个名为all.tar的包。-c是表示产生新的包，-f指定包的文件名。

#tar -rf all.tar *.gif
这条命令是将所有.gif的文件增加到all.tar的包里面去。-r是表示增加文件的意思。

#tar -uf all.tar logo.gif
这条命令是更新原来tar包all.tar中logo.gif文件，-u是表示更新文件的意思。

#tar -tf all.tar
这条命令是列出all.tar包中所有文件，-t是列出文件的意思

#tar -xf all.tar
这条命令是解出all.tar包中所有文件，-x是解开的意思


压缩

    tar –cvf jpg.tar *.jpg  将目录里所有jpg文件打包成tar.jpg
    tar –czf jpg.tar.gz *.jpg   将目录里所有jpg文件打包成jpg.tar后，并且将其用gzip压缩，生成一个gzip压缩过的包，命名为jpg.tar.gz
    tar –cjf jpg.tar.bz2 *.jpg 将目录里所有jpg文件打包成jpg.tar后，并且将其用bzip2压缩，生成一个bzip2压缩过的包，命名为jpg.tar.bz2
    tar –cZf jpg.tar.Z *.jpg   将目录里所有jpg文件打包成jpg.tar后，并且将其用compress压缩，生成一个umcompress压缩过的包，命名为jpg.tar.Z
    rar a jpg.rar *.jpg rar格式的压缩，需要先下载rar for linux
    zip jpg.zip *.jpg   zip格式的压缩，需要先下载zip for linux

解压

    tar –xvf file.tar  解压 tar包
    tar -xzvf file.tar.gz 解压tar.gz
    tar -xjvf file.tar.bz2   解压 tar.bz2
    tar –xZvf file.tar.Z   解压tar.Z
    unrar e file.rar 解压rar
    unzip file.zip 解压zip


总结

    *.tar 用 tar –xvf 解压
    *.gz 用 gzip -d或者gunzip 解压
    *.tar.gz和*.tgz 用 tar –xzf 解压
    *.bz2 用 bzip2 -d或者用bunzip2 解压
    *.tar.bz2用tar –xjf 解压
    *.Z 用 uncompress 解压
    *.tar.Z 用tar –xZf 解压
    *.rar 用 unrar e解压
    *.zip 用 unzip 解压

* 文件查找：
文件查找：find  +路径  -name +文件名  搜索文件   find / -name  文件名  全盘搜索

find . -name *   模糊cha'zhao'da

数据查找：grep 要过滤的数据   文件名  查看该文件中指定的数据

ls | grep +文件名 <=>find +路径  -name +文件名
grep + 所寻找的东西 +文件 （搜寻的内容）

find 文件目录 -type f |xargs grep "查询内容"

二、查找关键词所在的文件名及关键词所在行的内容
  方式1：

grep -r "关键词" 文件目录 

  示例：

    # grep -r "extension=php_pdo*" /usr/local/php71/
    /usr/local/php71/etc/php.ini:;extension=php_pdo_firebird.dll
    /usr/local/php71/etc/php.ini:;extension=php_pdo_mysql.dll
    /usr/local/php71/etc/php.ini:;extension=php_pdo_oci.dll

  方式2：

find 文件目录 -type f |xargs grep "查询内容"

  示例：

    # find /usr/local/php71/ -type f |xargs grep "extension=php_pdo*"
    /usr/local/php71/etc/php.ini:;extension=php_pdo_firebird.dll
    /usr/local/php71/etc/php.ini:;extension=php_pdo_mysql.dll
    /usr/local/php71/etc/php.ini:;extension=php_pdo_oci.dll

      注：如需限制文件名，可添加[-name]参数，例：find 文件目录  -type f -name "文件名" |xargs grep "查询内容"

三、仅查找关键词所在的文件名

grep -r -l "关键词" 文件目录

  示例：

    # grep -r -l "extension=php_pdo*" /usr/local/php71/
    /usr/local/php71/etc/php.ini

* linux 进程：
进程就是运行中的程序

PCB ：进程描述符（进程控制块），一个PCB对应一个进程，PCB就是一个双向循环链表

PID是操作系统对进程的标识符ID，也叫进程号，对应一个进程

创建进程时，先建立一个PCB，再加载进程，撤销时，先撤销进程，再撤销PCB

僵死进程：进程释放，PCB没释放

命令：

ps 显示当前终端正在进行的程序 -e/-A显示详细进程信息 -ef展示更多的信息 -f显示更多属性（全格式） -L显示进程的线程ID

pstree 把进程以树状图形式显示

kill +id 结束一个进程 -9 强制结束进程 -STOP 挂起一个进程 [1]:任务号 + 已停止 任务名

ctrl c结束一个进程 ctrl z 挂起一个进程

pkill +任务名称 结束相同任务名称的所有进程

jobs 显示当前终端任务或后台执行、挂起的任务

fg %+任务号 将进程任务放到前台

bg %+任务号 将挂起的任务进程放到后台

top 显示系统资源的使用情况，类似于任务管理器 

sleep 睡眠进程

* linux文件：
“-” ：普通文件 “d”：目录文件 “p”：管道文件 “l”：链接文件 “b”：块设备文件 “c”字符设备文件 “s”：套接字文件

“r”：可读，等于4   “w”：可写，等于2   “x”：可执行，等于1   rwx =421

rw-：u：user 文件归属人权限

rw-：g：group 表文件同组用户权限

r--：o：other 外人访问权限

修改权限：chmod u/g/o +:增加全选 -:减少权限 r/w/x  或者 chmod 774 文件名

vim 文件操作 

进入后分三种模式：命令模式、末行模式、编辑模式

命令模式：

1.u 恢复、撤销

2.n d删除光标下n行

3.n y拷贝光标下n行

4.p 粘贴

5.GG到文本最后一行

6.gg到文本第一行

7.ctrl r撤销上一步

8.r替换光标所在地方的字符

9.n G 跳转到第n行

末行命令：

1.q 退出

2.w 保存 ，加文件名可以另存为

3.q！ 强退

4./ 从光标向下搜索

5.set nonu 去掉行号

6.set nu 加行号

7.？从光标向上搜索

8.n,m s/旧字符/新字符/g 把从n到m行所有的旧字符换成新字符

编辑模式

1.i进入编辑

2.a跳到光标后方

3.A跳到光标前方

4.o换行到光标的下一行

5.O换行到光标的上一行

* 符号：
在C++中，通常，
1.A.B则A为对象或结构体
2.A->B则A为指针，->为成员提取，A->B是提取A中成员B，A只能是指向类、结构、联合的指针
3.::是作用域运算符，A::B表示作用域A中的名称B,A可以是名字空间、类、结构
4.:一般表示用来继承

* 输出文件名字到一个文件里面
ls -F > cat1.txt   //输出文件名字到另一个文件夹
ls -R 表示递归输出子目录的文件和目录名称





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




9. DAB的数据流： 进入某个模块，先创建一个根窗口，初始化与硬件进行通讯，获取DAB版本号。获取电台数量
创建公钥1：ssh-keygen -t rsa -C "chensh@maxmade.com"

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
git stash（当当前分支工作区有代码还没完成，但你想要切换分支，就可以使用它，就可以实现现场的保护，把没完成的工作区的代码暂存起来）
git stash list （列出所有的现场信息，也就是你切换之前保存的信息）
git stash pop （现场恢复）

git pull                    更新最新的代码状态
git status|less             查看当前修改代码状态
git checkout 文件名          删除当前文件的修改
git diff 文件名              查看当前文件的修改内容（工作区与暂存区）
git diff --cached 文件名 暂存区与版本库的差异
git diff HEAD 文件名 工作区与版本库
git add 文件名               将当前文件修改提交到暂存区
git commit -m "修改内容"      提交暂存区内容到本地仓库
git push                    将本地仓库的修改提交到服务器

git log                     显示提交了的log
git show  loapplication/reference_ui2/spLauncher/sysset/src/lang/lang_ar.qm
g的ID           显示ID对应的log修改的内容

git reset HEAD 文件名        将文件从暂存区中移出，就是撤销add操作（还没有执行commit）
git reset --soft HEAD^      撤销执行commit（还没有执行push）
git reset --hard HEAD^      撤销执行commit，连add也撤销（还没有执行push）

git config user.name 'name'           修改git author用户名字
git config user.email email-address   修改git author邮件地址
git diff  --name-only  . |grep "cfg"    查看修改的文件里面包含cfg名字的


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

6、git push将解决冲突后的文件推送到远程

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
日常git status，在git  pull ，开始修改，修改完之后先git diff查看一下自己修改的地方，git add 再git pull 一下（如果冲突），先把冲突文件改名mv 文件名（冲突文件）其他命名，打开meld文件看一下两个文件哪里不一样，把其他命名那个文件的自己修改的添加到冲突文件里面，保存再git add，commit上传。平常如果编译了的话git clean -xdf 再git checkout . git status一下最后git  reset HEAD 文件（如果已经git add的话）


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
//3.通过超级终端命令行进入挂载的U盘目录下，执行./screenshot,会生成一个命名为screenshot+时间戳的jpg截图文件（使用U盘前，我们先要为外挂点新建一个子目录，一般外挂点的子目录都是建立在/mnt里面的，我们也建在那里，当然也可以建在/目录下，名字可以自己定，我们就取名为usb，终端下的命令如下：  mkdir /mnt/usb    然后我们就可以接上我的U盘了，然后在终端下输入命令并击Enter键即可：  mount /dev/sda1 /mnt/usb    在Windows下当我们用完U盘后，在我们取下U盘前我们先要删除，同样在Linux下我们也要删除挂起点，方法是：   umount /dev/sda1 /mnt/usb 或 umount /dev/sda1   如果不把U盘给umount掉，那样很容易造成数据的丢失 ）
```
mount /mnt/sda1
```
ps：注意：./screenshot
cd /mnt/sda1/scr(tab)   (有时候不一定是sda1，设备号不唯一)
一张图片最好多截图和截屏多几次，防止截图失败生成无法查看的图片。
5. 使用打印工具minicom ：
https://worthsen.blog.csdn.net/article/details/77662637?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EOPENSEARCH%7ERate-4-77662637-blog-120830919.pc_relevant_3mothn_strategy_and_data_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EOPENSEARCH%7ERate-4-77662637-blog-120830919.pc_relevant_3mothn_strategy_and_data_recovery&utm_relevant_index=9
6. 静态库与动态库创建：
lib**.a 静态库 => 链接阶段 =>  复制一份到 可执行程序内部

lib**.so  共享库  => 链接阶段 =>   标记库的位置然后使用的时候调用 

静态库是多个.o文件打包

ar命令 将所有的.o文件打包成静态库

c是创建库     v是详细过程

静态库创建：
先写好函数文件，用gcc -c 加函数文件 编译成.o文件 然后用ar crv libfoo.a +文件名.o+文件名.o命令将所有的.o 文件打包到libfoo.a 中，将所有的函数声明写进一个头文件中，将头文件和打包好的lib**.a 文件放进同一个文件夹里，写进一个main函数，然后编译链接 gcc -o main main.c -L.（接当前文件夹) -l(链接哪个**库文件) foo
创建共享库：
生成.o以后，gcc -shared -fPIC -o libfoo.so min.o max.o 

需要把生成的libfoo.so共享库移动到 /usr/lib 位置  sudo mv libfoo.so  /usr/lib

然后再gcc -o main main.c -lfoo  直接使用   
7. 开sdk层打印：
修改defconfig文件（在application/config/对应的项目/platform/）修改等级为v
qt的clog.h开打印
连接minicom，上电后敲 logset ALOG_LEVEL v
/media/flash/nvm/goc/路径下的btsnoop_hci.clog文件

8. 8368-U平台系统升级失败后无法继续升级解决办法
build/tools/isp/isp.c PROGRAM_HEADER_LAST注释掉。使系统升级失败后能关机开机继续升级。这种方法适用于升级过程中断电。升级过程中拔掉U盘，则无法再次升级。


9. 8368-U平台，如何空中抓包。
"Harven 20211020: 
请用如下方式抓空中包，车机端通过tcpdump抓协议栈包；tcpdump可执行档参考附件，命令说明如下：
       /media/sda1/tcpdump -i wlan0 -G 1200 -w /media/sda1/CarPlay_test.pcap &
 其中，tcpdump放置于U盘，
-i wlan0 ：指定网卡接口， 
-G 1200：循环抓取，仅保存最近20分钟数据；
       -w /media/sda1/CarPlay_test.pcap：抓包结果存放于U盘的CarPlay_test.pcap文件；
       后台执行；
       当复现到问题后，直接 kill掉tcpdump进程即可；最后执行sync，再从车机拔出U盘；"


10. 代码移植过程
"1.命令行输入ssh git@192.168.30.5登录在git server的git账号 上, 执行 git init --bare 8368-XUCarSDK
2.再创建个命令行输入ssh soft1@192.168.30.5登录在客户端的账号，创建8368-XUCarSDK目录，进入8368-XUCarSDK目录执行git init
3.在该目录输入以下命令
git remote add sunplus gitolite3@121.15.134.182:8368-UCarSDKMAXMADE
git pull sunplus 远程分支名(如:8368-XU-20220901)
4.git checkout 远程分支名
5.git checkout -b 新分支名
6.git remote add origin git@192.168.30.5:~/8368-XUCarSDK
7.git push origin 新分支名
这上面就完成了对应的远程库的创建,其他的用户就可以对其进行拉取和上传了
 git clone -b 8368-XU-20220901 git@192.168.30.5:~/8368-XUCarSDK
8.从其它项目拷贝mk8388cxx.sh过来
9.执行./mk68xu.sh 2(因为xu的配置为第二套方案，从新配置刷新配置需要./mk68xu.sh 2，如果./mk68xu.sh 1则编译出的升级文件将无法升级) , 如果提示编译工具错误，检查一下mk8388cxx.sh里面PATH的设置,8368XU的需要修改路径为
export PATH=$CBIN:$PWD/build/tools/arm-9.2_eabihf/bin/:$PWD/build/tools/arm-2014.05/bin:$PATH:$PWD/boot/uboot/tools/
10.如果提示 err: .libcxx_cfg not found !!!!! , 执行一下 make 2 ,再重新执行 ./mk68xu.sh 2
11.((/bin/sh: 1: cmake: not found) 8368-P 需要安装cmake;   sudo apt-get install cmake
12.8368-P: bison: not found ; sudo apt-get install bison
13.8368-P : flex: not found ; sudo apt-get install flex
14.8368-P : ../scripts/extract-cert.c:21:10: fatal error: openssl/bio.h: 没有那个文件或目录  , 解决办法: sudo apt-get install libssl-dev
15.如果出现卡死等问题，可以把代码恢复成跟服务器一样再试试，或者恢复到以前的版本尝试。"

11. 新建项目
1.在对应的地方以终端打开，拖进脚本 输入参考项目，输入生成项目
2.修改panel ，在config文件夹下修改deconfig和app_config 的.ko，修改对应面板

12. GDB调试
前期准备:
1.更新 CP 服务或其它需要 GDB 调试的 lib 支持 GDB 调试(找 Sunplus)
2.修改 linux/sdk 下的 Makefile
在 packimg:下的
-$(FIND) ./out/system/bin -type f | xargs -I '{}' $(TARGET_TOOLS_PREF
IX)strip '{}' 2> /dev/null
在路径后加入不需要压缩的 bin 或 lib:
-$(FIND) ./out/system/bin
carplay_plugin.so"
!-name "apple_carplay_server" ! -name "lib
-type f | xargs -I ..................

GDBDebug-MakefileGDB 调试 CP 步骤:
1.ps -e 看下 cp server 的进程 pid
2.把 GDB 拷到 U 盘,插到机器上
3.连接无线 cp
4.连上后,进 USB 目录,执行./GDB
5.输入 attach pid 号
支持 GDB)
(这个时候 cp 会卡住)
(表示当前监视 cp server 所在现成,需要 cp server支持GDB)
6.再输入 c
(即:continue, 解除卡住)
7.开始测试,期间不要在打印行随便输入任何东西(GDB 调试不稳定容易造成崩
溃影响正常测试)
(即使是 Enter 换行也不要,GDB 模式下直接敲 Enter 默认输入上一次指令)
8.复测到卡死问题时
先按一下 ctrl+c,避免输入缓冲区有数据
敲 info threads 查看线程信息
此时*会直接指向出问题的线程9. 再敲 bt(第一下可能不会出来,要敲两下),查看该线程出错位置
10.有时可能 bt 信息不够
需要额外敲:f 1 和 p limiter
注意事项:
因为 GDB 工具不稳定,有时候系统卡死可能是 GDB 工具造成的,如何确认?
(1). 敲了该敲的指令后,先敲一下 c,看是否恢复。如果能恢复即为卡 GDB;
(2). 敲了 c 后无反应,直接敲 q,提示退出 GDB,输入 y 退出,如果能恢复即为卡
GDB;
(3). 退出 ps -e 查看 Launcher 和 apple_carplay_server 是否还在,不在的那就
必定是死机了。

13. Linux usb/U盘解除写保护：
tail -f /var/log/syslog
插入u盘
看自己是sdc1还是sdb别的
umount /media/chenshihao/HOUSE  (弹出u盘)
sudo dosfsck -v -a /dev/sdc1 

14. 输出文件名字到一个文件里面
ls -F > cat1.txt   //输出文件名字到另一个文件夹
ls -R 表示递归输出子目录的文件和目录名称
  gedit cat1.txt   打开查看

15. 快速打开Linux的svn
在对应文件夹用终端打开
输入rabbitvcs browser

16. svn回退版本
在windows下在对应文件夹下，右键保存版本到某一个地方（名字尽量不变）
再把该版本上传到对应地方

* 编译代码问题
1.编译8388代码：
进入/Direct8388GitServer/linux/kernel/drivers/framebuffer 的makefile文件
修改SUPPORT_CHECK_CODING_STYLE=1 将1改为0
进行./mk      1
./mk      all
* 划词翻译pdf 网址：https://pdf.hakso.net/web/viewer.html
用火狐打开，并把要翻译的拖进去

* 测试Carplay 带宽
目前只有红色的iPhone13有最新的carplay test

1.车机连接打印线，电脑打开log串口工具

2.车机连接手机无线cp

3.手机打开carplay test应用，找到Performance，选择wireless Test

4.只需要选择不同的case来进行测试，其余不用修改

5.不同的case要输入的命令行不同，需要打开后将其复制下来，然后通过复制快速打入命令行，因为测试要求10s内输入，每行命令后面添加一个&

如：

    TCP Iperf server: iperf -p 6001 -s -i 1 -w 176k &
    UDP Iperf server: iperf -p 5001 -s -i 1 -w 512k -u &

这样是保证iperf服务在后台运行，可以使终端可以继续输入命令

6.不同case需要输入的命令手机都会有提示

7.可以输入

ps -e

    查看各个已开启的服务，在测试前需要关闭所有的iperf服务，可以输入

kill -s 9 对应服务id号

    强制关闭已开启的iperf服务

然后再进行命令行的输入，如果失败则可以关闭服务重新输入命令

8.成功后手机会提示是否通过该case，手机可将结果导出为.txt发送到微信或者邮件 


* flash镜像文件(烧录软件)制作：

在连上打印线之后要先设置波特率115200
1B			//十六进制Esc,进入uboot模式，串口工具使用Hex格式发送
Esc			//进入uboot模式,可在minicom使用	
（如果是8368C还要重启一下，再按ESC进入Uboot）在开机起来的过程中按Esc进去uboot模式,15s后MCU会自动重启，重启时再次进入uboot就不会再重启了，此时插入USB
ispsp mtdparts_adj		//制作前必要步骤之调整flash块
（第一次无法识别，再输入一次）
snand_ghost usb 0 -sb -su	//8368U 从flash写出烧录文件到usb 0
ghost2snand usb 0 -sb		//8368U 从usb 0写入烧录文件到flash(软件验证)


snand_ghost_sb usb 0		//8368C 从flash写出烧录文件到usb 0

* linux 环境配置：
1.安装Ubuntu 18.04 操作系统
2.安装完操作系统后，安装开发环境。
2.1git 代码管理工具安装
先执行sudo apt-get update
再执行sudo apt-get install git
2.2编译环境安装
sudo apt-get install build-essential cmake gawk lib32z1  bison flex libssl-dev

2.3安装rabbitvcs svn， SVN文档管理工具
sudo apt-get install rabbitvcs-cli rabbitvcs-core rabbitvcs-gedit rabbitvcs-nautilus


2.4Qt集成开发工具安装
在svn://192.168.10.9/市场&研发事业部/软件部/资料/开发工具 路径下下载
qt-opensource-linux-x64-5.3.2.run

然后进入下载目录，使用chmod命令添加执行权限
然后执行 ./qt-opensource-linux-x64-5.3.2.run 进行安装，接下来的图形安装步骤，点击下一步直到完成即可。


2.5安装openssh , 如果需要不输入密码就访问git 服务器则需要执行此步骤
2.5.1  sudo apt-get install openssh-client openssh-server
2.5.2  执行ssh-keygen 命令，就会在 ~/.ssh/ 目录下生成 id_rsa       id_rsa.pub   known_hosts 这三个文件。将id_rsa.pub文件发给各自的师傅，放到git服务器上。

2.6搜狗输入法和wps安装，drawio画图工具

在svn://192.168.10.9/市场&研发事业部/软件部/资料/开发工具 路径下下载
sogoupinyin_2.2.0.0108_amd64.deb
wps-office_11.1.0.10702_amd64.deb
drawio-amd64-20.3.0.deb
这些也可以从网上下载最新的。

然后执行 sudo dpkg -i xxx.deb  安装相应的软件包。如果提示有依赖的软件包需要安装，则需要另外执行 sudo apt-get -f install

2.7uart 打印工具安装
命令行工具可以使用minicom , sudo apt-get install minicom
图形化工具可以使用cutecom, sudo apt-get install cutecom

2.8文件比较工具
sudo apt-get install meld

2.9邮箱使用ubuntu自带的thunderbird 工具进行配置即可

2.10我们的代码中自定义了一些控件，QtDesinger如果要正常显示这些控件。则需要安装以下步骤添加控件插件。
在svn://192.168.10.9/市场&研发事业部/软件部/资料/开发工具 路径下下载
designer_plugin_lib.zip
解压压缩包后，将里面的 .so 文件都复制到以下路径
~/Qt5.3.2/5.3/gcc_64/plugins/designer
~/Qt5.3.2/Tools/QtCreator/bin/plugins/designer

* 总结一下8368XU 死机问题的查找步骤：
1.出现“Accessory Application PID[716] die”类似这样的die，需要先使用top指令查看是哪一支Application 停掉了，先定位问题出在哪个模组，同时接上ecos debug一起提供log。
2.找出是哪支application挂掉之后，需要考虑挂在这支application上的所有的code。 比如挂在Launcher这一支：
716  1 root  S   152m 80.3   0  0.0 /application/bin/Launcher --dfb:no
因为Application die, 有可能是Qt, dfb, 也有可能是客户App的code，只要活在Launcher进程上的代码都有嫌疑。
3.此时需要进一步锁定具体是死在哪个位置哪个函数
a.先加上init_sig.cpp的代码（代码看最后）
b.尽量在Launcher启动的刚开始调用init() , 注册back trace的打印
c.Backtrace_test.cpp为调用范例（对应的代码在文末）
d.定位死机的点在哪边
加了以上代码后出现死机时会打印出以下信息：





signum= 11   SIGSEGV表示访问了非法内存，访问的非法地址是info.si_addr= 0x29d，这个/application/bin/Launcher() [0x264da]地址很可能就是问题发生的位置，此时需要使用反汇编将地址找到是哪个函数，看是否存在风险。
这个地址发生在application内，查找反汇编地址需要按以下步骤运行：
(a).在根目录下执行gmenv.sh不要退出；


(b).进入application/out/system/bin下执行arm-none-linux-gnueabihf-objdump -D Launcher，然后根据死机地址查询对应的函数即可。


4.有时也可上网查询报错信息是什么问题，比如下面这个报错：
Alignment trap: not handling instruction e8503f00 at [<410a7b1a>]
Unhandled fault: alignment exception (0x001) at 0xaf
在网上查找就能找到可以查找问题的方向：
https://www.cnblogs.com/pjl1119/p/13441457.html
https://www.796t.com/content/1541760907.htm




init_sig.cpp文件所有内容：

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <signal.h>
#include <sys/prctl.h>
#include <execinfo.h>


#define BACKTRACE_DEPTH_SIZE	(32)

typedef struct {
	int num;
	char name[8];
} SymbolNameTable_t;

const SymbolNameTable_t gSymbolNameTbl[] = {
	{SIGSEGV, "SIGSEGV"},
	{SIGTERM, "SIGTERM"},
	{SIGINT,  "SIGINT"},
	{SIGQUIT, "SIGQUIT"},
	{SIGABRT, "SIGABRT"},
	{SIGBUS,  "SIGBUS"},
	{SIGILL,  "SIGILL"},
	{SIGKILL, "SIGKILL"},
	{SIGFPE,  "SIGFPE"},
	{SIGTERM, "SIGTERM"},
	{SIGSTOP, "SIGSTOP"},
//	{SIGPIPE, "SIGPIPE"},
};

const int gSymTblSize = sizeof(gSymbolNameTbl) / sizeof(SymbolNameTable_t);

static const char *getSymbolName(int signum)
{
	int i;

	for(i = 0 ; i < gSymTblSize ; i++) {
		if(gSymbolNameTbl[i].num == signum) {
			return gSymbolNameTbl[i].name;
		}
	}

	printf("Signal name not found! Please check your code!\n");
	assert(0);
}

static void signal_segv(int signum, siginfo_t* info, void* ptr)
{
//	static const char *si_codes[3] = {"", "SEGV_MAPERR", "SEGV_ACCERR"};

	(void)ptr;

	char thread_name[1024+1] = {0};
	void * arr[BACKTRACE_DEPTH_SIZE] = {0};
	int thread_depth;
	char ** symbol_str;
	int i;

	printf("=== %s ===\n", __FUNCTION__);
	printf("signum = %d (%s)\n", signum, getSymbolName(signum));
	printf("info.si_errno = %d\n", info->si_errno);
	printf("info.si_code  = %d\n", info->si_code);
	printf("info.si_addr  = %p\n", info->si_addr);

	if (prctl(PR_GET_NAME, (unsigned long)thread_name, 0, 0, 0) != 0) {
		strcpy(thread_name, "<name unknown>");
	} else {
		// short names are null terminated by prctl, but the manpage
		// implies that 16 byte names are not.
		thread_name[1024] = 0;
	}

	printf("=========\n");
	printf("Thread Name: %s\n", thread_name);

	thread_depth = backtrace(arr, BACKTRACE_DEPTH_SIZE);
	symbol_str = backtrace_symbols(arr, thread_depth);

	if(symbol_str != NULL) {

		printf("Back trace: (depth=%d)\n", thread_depth);
		for(i = 0 ; i < thread_depth ; i ++) {
			printf("\t %s\n", symbol_str[i]);
		}
		printf("Back trace (END)\n");

		free(symbol_str);
	}

	/* remove our net so we fault for real when we return */
	signal(signum, SIG_DFL);

	exit (-1);
}

int init() {
	struct sigaction action;
	memset(&action, 0, sizeof(action));
	action.sa_sigaction = signal_segv;
	action.sa_flags = SA_SIGINFO;

	int i;

	for(i = 0 ; i < gSymTblSize ; i++) {
		if(0 > sigaction(gSymbolNameTbl[i].num, &action, NULL)) {
			perror(gSymbolNameTbl[i].name);
			return 0;
		}
	}

	signal( SIGPIPE, SIG_IGN ); // Ignore SIGPIPE signals so we get EPIPE errors from APIs instead of a signal.
	return 0;
}


Backtrace_test.cpp文件所有内容：

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#if 1
#include <signal.h>
#include <sys/prctl.h>
#include <execinfo.h>
#endif

#define BACKTRACE_DEPTH_SIZE	(32)

typedef struct {
	int num;
	char name[8];
} SymbolNameTable_t;

const SymbolNameTable_t gSymbolNameTbl[] = {
	{SIGSEGV, "SIGSEGV"},
	{SIGTERM, "SIGTERM"},
	{SIGINT,  "SIGINT"},
	{SIGQUIT, "SIGQUIT"},
	{SIGABRT, "SIGABRT"},
	{SIGBUS,  "SIGBUS"},
	{SIGILL,  "SIGILL"},
	{SIGKILL, "SIGKILL"},
	{SIGFPE,  "SIGFPE"},
	{SIGTERM, "SIGTERM"},
	{SIGSTOP, "SIGSTOP"},
//	{SIGPIPE, "SIGPIPE"},
};

const int gSymTblSize = sizeof(gSymbolNameTbl) / sizeof(SymbolNameTable_t);

static const char *getSymbolName(int signum)
{
	int i;

	for(i = 0 ; i < gSymTblSize ; i++) {
		if(gSymbolNameTbl[i].num == signum) {
			return gSymbolNameTbl[i].name;
		}
	}

	printf("Signal name not found! Please check your code!\n");
	assert(0);
}

static void signal_segv(int signum, siginfo_t* info, void* ptr)
{
//	static const char *si_codes[3] = {"", "SEGV_MAPERR", "SEGV_ACCERR"};

	(void)ptr;

	char thread_name[1024+1] = {0};
	void * arr[BACKTRACE_DEPTH_SIZE] = {0};
	int thread_depth;
	char ** symbol_str;
	int i;

	printf("=== %s ===\n", __FUNCTION__);
	printf("signum = %d (%s)\n", signum, getSymbolName(signum));
	printf("info.si_errno = %d\n", info->si_errno);
	printf("info.si_code  = %d\n", info->si_code);
	printf("info.si_addr  = %p\n", info->si_addr);

	if (prctl(PR_GET_NAME, (unsigned long)thread_name, 0, 0, 0) != 0) {
		strcpy(thread_name, "<name unknown>");
	} else {
		// short names are null terminated by prctl, but the manpage
		// implies that 16 byte names are not.
		thread_name[1024] = 0;
	}

	printf("=========\n");
	printf("Thread Name: %s\n", thread_name);

	thread_depth = backtrace(arr, BACKTRACE_DEPTH_SIZE);
	symbol_str = backtrace_symbols(arr, thread_depth);

	if(symbol_str != NULL) {

		printf("Back trace: (depth=%d)\n", thread_depth);
		for(i = 0 ; i < thread_depth ; i ++) {
			printf("\t %s\n", symbol_str[i]);
		}
		printf("Back trace (END)\n");

		free(symbol_str);
	}

	/* remove our net so we fault for real when we return */
	signal(signum, SIG_DFL);

	exit (-1);
}

int init() {
	struct sigaction action;
	memset(&action, 0, sizeof(action));
	action.sa_sigaction = signal_segv;
	action.sa_flags = SA_SIGINFO;

	int i;

	for(i = 0 ; i < gSymTblSize ; i++) {
		if(0 > sigaction(gSymbolNameTbl[i].num, &action, NULL)) {
			perror(gSymbolNameTbl[i].name);
			return 0;
		}
	}

	signal( SIGPIPE, SIG_IGN ); // Ignore SIGPIPE signals so we get EPIPE errors from APIs instead of a signal.
	return 0;
}

int main(void)
{
	char *ptr = NULL;

	init();

	printf("%s:%d\n", __FUNCTION__, __LINE__);

	printf("ptr[3] = %c\n", ptr[3]);


	return 0;
}





# 代码样例
1. 信号与槽的实现：
// 信号槽的使用
// connect(sender,signal,receiver,slot)
// sender 信号发送者 signal 要发送的信号 receiver 信号接收者 slot 槽函数
```
class Teacher{
	// 自定义信号
	signal:
		// 注意 信号 只声明 不实现
		void hungry();
};
class Student{
	slots:
		// 槽函数
		void treat();
};
// 槽函数实现
void Student::treat(){
	qDebug() << "该吃饭了！";
}
// 触发信号方法
void MyWidget::classIsOver(){
	// 发送信号
	emit teacher ->hungry();
}
teacher = new Teacher(this); // this 添加children 表 方便回收
student = new Student(this); 
// 信号槽连接
connect(teacher,&Teacher::hungry,student,&Student::treat);
/*
	注意:
		1.对于有重载的信号和槽 使用函数指针处理
			void(Teacher::*teacherSignal)(QString)=&Teacher::hungry; // 这里假设hungry信号 被重载过
			void(Student::*studentSlot)(QSting)=&Student::treat; // 这里treat 槽函数被重载过
			connect(teacher,teacherSignal,student,studentSlot);// 重载后的连接
		2.信号和槽函数的返回值是void
		3.槽函数是普通成员函数 会受到public private protected的影响
		4.使用emit 关键字触发信号
		5.任何成员函数、static 函数、全局函数 lambda表达式都可以作为槽函数
		6.信号 和 槽必须保持 参数一致 即类型一致，槽函数的参数可以比信号少
		7.一个信号可以和多个槽连接
		8.多个信号可以连接到一个槽
		9.一个信号可以连接到另外的一个信号
		10.信号槽可以取消连接 
*/
```

2. 按钮：
```
#include <QPushButton>
QPushButton *btn = new QPushButton;
// 设置父窗口
btn ->setParent(this);
// 设置文字
btn ->setText("文件");
// 移动位置
btn ->move(100,100)
/*第二种创建方式*/
QPushButton *btn2 = new QPushButton("哈比布",this);
// 重新指定窗口大小
this ->resize(600,400);
// 设置窗口标题
this ->setWindowTitle("第一个窗口");
// 限制窗口大小
this ->setFixedSize(600,400);

```

3. lambda:
/* c++11 中的Lambda 表达式用于定义并创建匿名的函数对象 */
```
/*
[函数对象参数](操作符重载函数参数)mutable ->返回值{函数体}
*/

```
[] 函数对象参数 标识一个lambda 的开始 必须存在，函数对象参数是传递给编译器自动生成的函数对象类的构造函数的。

    空 没有使用任何函数对象参数
    = 函数体可以使用Lambda 所在作用范围内所有可见的局部变量，包括Lambda所在类的this,并且是值传递方式 相当于告诉编译器自动按值传递所有局部变量
    & 告诉编译器按引用传递了局部变量
    a 将a按值传递，按值传递时候，函数体内不能修改传递进来的a的拷贝，因为默认情况下函数是const的， 要修改a的拷贝 可以添加 mutable 修饰符
    &a 将a 按引用传递
    a,&b 将a 安值进行传递，b按引用传递
    =,&a,&b 除了a和b 按引用传递外，其他参数都按值传递
    &,a,b 除a和b 按值传递外，其他参数都按引用传递

mutable 可修改标识符：按值传递参数时，加上mutable 修饰符 可以按值传递进来的宝贝
函数返回值: -> 返回值类型 标识函数返回值的类型 当返回为void，或者只有一处 return的地方
{} 是函数体 这部分不能省略 但函数体可以为空

4. 消息机制和事件:
```
/*
	1. Qt程序 需要在main() 函数创建一个 QApplication对象 然后调用exec() 函数，执行exec() 函数之后，程序进入事件循环监听
	2. Qt中所有的事件类 继承自QEvent, 这个事件传递给QObject的event() 函数，event()函数不直接处理事件，是按照事件对象类型分派特定的事件处理函数(event handler)
*/
/*
	QWidget 事件处理回调函数
		keyPressEvent()
		keyReleaseEvent()
		mouseDoubleClickEvent()
		mouseMoveEvent()
		mousePressEvent()
		mouseReleaseEvent()
*/
class EventLabel : public QLabel{
	protected:
		void mouseMoveEvent(QMouseEvent *event);
		void mousePressEvent(QMouseEvent *event);
		void mouseReleseEvent(QMouseEvent *event);
};
void EventLabel::mouseMoveEvent(QMouseEvent *event){
	this ->setText(QString("<center><h1>Press:(%1,%2)</h1></center>").arg(QString::number(event ->x()),QString::number(event ->y())));
}
void EventLabel::mousePressEvent(QMouseEvent *event){
	this ->setText(QString("<center><h1>Press:(%1，%2)</h1></center>").arg(QString::number(event ->x()),QString::number(event ->y())));
}
void EventLabel::mouseReleaseEvent(QMouseEvent *event){
	QString msg;
	msg.sprintf("<center><h1>Relese:(%d,%d)</h1></center>",event ->x(),event ->y());
	this ->setText(msg);
}
int main(int argc,char *argv[]){
	QApplication *label = new EventLabel;

	EventLabel *label = new EventLabel;
	label ->setWindowTitle("MouseEvent~~~");
	label ->resize(300,300);
	label ->show();
	return 0;
}

```
5. event:
```
/*
	1.事件创建完毕后，Qt将这个事件对象传递给 QObject的 event() 函数，event() 函数负责分发给不同的事件处理器
	2.如果希望在事件分发之前 做一些操作 重写event() 函数
*/
bool CustomWidget::event(QEvnet *e){
	if(e ->type() == QEvent::KeyPress){
		QKeyEvent *keyEvent = static_case<QKeyEvent *>(e);
		if(keyEvent() ->key() == Qt::Key_Tab){
			qDebug() << "You press tab";
			return true;
		}
	}
	return QWidget::event(e);
}

```
6. 事件过滤器：
```
class MainWindow : public QMainWindow{
	public:
		MainWinow();
	protected:
		bool eventFilter(QObject *obj,QEvent *event);
	private:
		QTextEdit *textEdit;	
}
MainWindow::MainWindow(){
	textEdit = new QTextEdit;
	setCenterWidget(textEdit);
	textEdit ->installEvent(this);
}
bool MainWindow::eventFilter(QObject *obj,QEvent *event){
	if(obj == textEdit){
		if(event ->type() == QEvent::KeyPress){
			QKeyEvent * keyEvent = static_case<QKeyEvent *>(event);
			qDebug() << keyEvent ->key();
			return true;
		}else{
			return false;
		}
	}else{
		return QMainWindow::eventFilter(obj,event);
	}
}
/*
	MainWindow 是我们定义一个类，重写eventFilter()函数，过滤特定组件上的事件，首先需要判断这个对象是不是我们感兴趣的组件
		是返回true 也就是过滤了这个事件， false 不关注的事件  其他组件则调用父类的函数处理
	eventFilter() 相当于创建了过滤器,可以通过removeEventFilter() 函数移除 过滤器
	installEventFilter() 如果一个对象存在多个事件过滤器 最后一个安装的会第一个执行，先进先执行的顺序


```
7. 文件系统：
```
/*
	QIODevice: 所有I/O 设备的父类
	QFileDevice: 提供文件操作的通用实现
	QFile: 访问本地文件或者嵌入资源
	QTemporaryFile: 创建和访问本地文件系统的临时文件
	QBuffer: 读写QbyteArray，内存文件
	QProcess： 运行外部程序，处理进程间通讯
	QAbstractSocket: 所有套接字类的父类
	QTcpSocket: Tcp 协议网络数据传输
	QUdpSocket: 传输UDP 报文
	QSslSocket: 使用SSL/TLS 传输数据
*/
int main(int argc,char *argv[]){
	QApplication app(argc,argv);
	QFile file("in.txt");
	if(!file.open(QIODevice::ReadOnly | QIODevice::Text)){
		qDebug() << "Open file failed";
		return -1;
	}else{
		while(!file.atEnd()){
			qDebug() << file.readLine();
		}
	}
	QFileInfo info(file);
	qDebug() << info.isDir();
	qDebug() << info.isExacutable();
	qDebug() << info.baseName();
	qDebug() << info.completeBaseName();
	qDebug() << info.suffix();
	qDebug() << info.completeSuffix();
	return app.exec();
}

```
8. 信号槽的重载：
```
面对信号函数重载，可以通过函数指针明确需要调用的具体信号函数

函数指针： 指向函数的指针
void (QSpinBox:: *spinBoxp)(int) = &QSpinBox::valueChanged;
 
connect(ui->spinBox, spinBoxp, [=](){
    
});
 
connect(ui->spinBox, spinBoxp, this, &QWidget::print);;


QSpinBox:: *spinBoxp 为函数的指针

函数指针需要在前面加上返回值，在后面加上参数类型

&QSpinBox::valueChanged 指名函数的名称

复习下函数指针：

程序中定义的函数，在编译系统中需要为他分配一段程序的存储空间，这段存储空间被成为函数的地址，而函数的名称指向的就是这个地址。

既然是地址，就可以用指针变量来存储，指向函数地址的指针就是函数指针。

函数指针有自己的特殊定义方式，不同于变量指针
void (*p)(int,int)

函数返回值类型 (* 指针变量名) (函数参数列表);
这就是函数指针的定义，一般还需要在函数指针变量名称前面加上作用域。
int Func(int x);   /*声明一个函数*/
int (*p) (int x);  /*定义一个函数指针*/
p = Func;          /*将Func函数的首地址赋给指针变量p*
 
调用函数时 可以通过*p(3,5); 实现对函数Func的调用

```



# 日常改动
2023 ：
0321：
1. 依据改动  AV_1297LW_53HW和AV_1307T_53HW
2. 6197W-65HW,蓝牙假连接问题，抓打印
开sdk层打印
修改defconfig文件（在application/config/对应的项目/platform/）修改等级为v
qt的clog.h开打印
连接minicom，上电后敲 logset ALOG_LEVEL v
/media/flash/nvm/goc/路径下的btsnoop_hci.clog文件
0322：
借dqa电源线，两种可以升级外置usb线（一个是插打印线那种，一个是卡扣的）

0324：
can模拟器改对应参数（开始位，size大小，报文长度（根据发送的表数总共多少个），周期），对应连接can线在主电源上（不行则接到尾线，H或L有可能接反）

0325：
了解qml与C++关系，改动ui要用上层的set，read
修改先看对象ID，看id的对象实现，找不到就看对象名字，搜寻一下

0327：
追踪点击language刷新返回键的翻译问题
q： 9寸10寸机子的logo应该放到config下哪个文件夹，更改Cmd_bootsp.c中show_normal_logo的下标参数具体哪个位置，），说明书咋制作
a: 修改点:
grep 'ENABLE_GUIDE' -r ./

ENABLE_GUIDE=1

guideImage

#define SUPPORT_LOGO_SWITCH    2    ////支持可选开机logo和设置数量
#define SETUP_SUPPORT_LOGO_LIST "Nissan"<<"Subaru"<<"Mitsubishi"

0328：
更改对应项目的homepage.ui（一页为1024，新增一页改宽度和坐标），外层qrc和图标，config里面的app_config(使能ENABLE_GUIDE=1 )，外层的guideImage文件夹(文件不能太大),还有头文件（打开宏）
copy： git log /home/chenshihao/8368-U-QT/application/reference_ui2/spLauncher/plugins/activity/guideactivity/guideview/guideview.cpp
 1784  git log 70659c872c5c7ee167beab0adb959ad1feba2715
 1785  nautilus ./
 1786  git log '/home/chenshihao/8368-U-QT/application/include/AV-1327-65DS-HW.h' 
 1787  git show 6180578460ba4efcee9c986bc3cad29026a1bada
 1788  git log '/home/chenshihao/8368-U-QT/application/include/AV-1327-65DS-HW.h' 
 1789  git show 2f4378c45fdb66d8f981200fbb7b1c6d0a2c3c96
 1790  git show --name-only  bf5bd5bcc062feee426e595de8f4b490984fce42
 1791  gedit application/reference_ui2/Makefile
 1792  gedit application/reference_ui2/build_qtap.sh
 1793  git show   bf5bd5bcc062feee426e595de8f4b490984fce42

0329：
用脚本更换开机logo，确保图片格式位24位256色的，不是该格式的话会黑屏显示

0330：
AVIN，Reverse，Camera
ls -F > cat1.txt   //输出文件名字到另一个文件夹
ls -R 表示递归输出子目录的文件和目录名称
  gedit cat1.txt 

0402：
主界面信息源的判断，在收音/usb界面，操作AA和CP，手机BT，主界面显示的源应该变化
0406：
针对开机升级黑屏，从显示屏开始追踪到APP升级到一半中断导致需要重新烧MCU（APP升级挂掉，原本要把里面的擦除重写，但此过程中断，烧完MCU后要强制升级APP，将尾线的方控Key1置地，但暂时没效果，需要检查一下烧录孔是否错误）

0407:
更换flash后正常

0410:
subwoofer Gain /add /user/return/点进去的各个源翻译不生效，没找到reverse mute和time alignment，device connect，eq的，classical，khz没换，多个翻译：av in/bt audio，把15kz去掉翻译
修改了user，还需classis，和fast guide，data &time，fader，time   alignment，解决文字超出框的问题
0411：
看Linux基础知识，更改以下文件，对策DQA翻译和部分设置问题

	    修改：     application/config/maxmade/AV_1297WT_53HW/etc/carplay/carplay_config_version_2.xml
        修改：     application/config/maxmade/AV_1297WT_53HW/etc/carplay/carplay_config_version_3.xml
        修改：     application/config/maxmade/AV_1297WT_53HW/guideImage/9.jpg
        修改：     application/config/maxmade/AV_1297WT_53HW/guideImage/A.jpg
        修改：     application/config/maxmade/AV_1297WT_53HW/language/lang_ar.qm
        新文件：   application/config/maxmade/AV_1297WT_53HW/language/lang_ar.ts
        修改：     application/config/maxmade/AV_1307WT_53HW/etc/carplay/carplay_config_version_2.xml
        修改：     application/config/maxmade/AV_1307WT_53HW/etc/carplay/carplay_config_version_3.xml
        修改：     application/config/maxmade/AV_1307WT_53HW/guideImage/9.jpg
        修改：     application/config/maxmade/AV_1307WT_53HW/guideImage/A.jpg
        修改：     application/config/maxmade/AV_1307WT_53HW/language/lang_ar.qm
        新文件：   application/config/maxmade/AV_1307WT_53HW/language/lang_ar.ts
        修改：     application/include/AV-1297WT-53HW.h
        修改：     application/include/AV-1307WT-53HW.h
        修改：     application/reference_ui2/spLauncher/commons/setupviews/src/UI_FIAT_BLUE_1024_600/froms/setupeq.ui
        修改：     application/reference_ui2/spLauncher/plugins/activity/homelauncher/homeview/homeview.cpp

0412：
修改光标溢出（调整字体大小和宽度）
	修改：     application/reference_ui2/spLauncher/commons/fileviews/src/UI_FIAT_BLUE_1024_600/froms/default/audioplaying.ui
	修改：     application/reference_ui2/spLauncher/plugins/activity/homelauncher/homeview/UI_FIAT_BLUE_1024_600/AV_1297WT_53HW/homepage.ui
	修改：     application/reference_ui2/spLauncher/plugins/activity/homelauncher/homeview/UI_FIAT_BLUE_1024_600/AV_1307WT_53HW/homepage.ui

0413：
对策右驾设置没用，默认左驾（改宏），蓝牙有字符显示不完整，将源的信息与主页保持一致，将进入aa将settitle置空
	修改：     application/include/AV-1297WT-53HW.h
	修改：     application/include/AV-1307WT-53HW.h
	修改：     application/reference_ui2/spLauncher/commons/fileviews/src/UI_FIAT_BLUE_1024_600/froms/default/audioplaying.ui
	修改：     application/reference_ui2/spLauncher/plugins/activity/btaudioactivity/btaudioview/btaudioview.cpp
	修改：     application/reference_ui2/spLauncher/plugins/activity/homelauncher/homeview/infopage.cpp

0414:
#define NO_VIDEO_SCREEN_AFTER_REVERSE  1//对策由于倒车界面的透明窗口，导致倒车结束后会瞬闪某些视频流   经测试8368u没效果

0417：

1.对策Right Hand Drive 开关无作用2.AA默认左驾3.对策蓝牙音乐有字符显示不完整4.源信息与主页保持一致
	修改：     application/config/maxmade/AV_1307WT_53HW/language/lang_ar.qm
	修改：     application/config/maxmade/AV_1307WT_53HW/language/lang_ar.ts
	修改：     application/include/AV-1297WT-53HW.h
	修改：     application/include/AV-1307WT-53HW.h
	修改：     application/reference_ui2/spLauncher/commons/fileviews/src/UI_FIAT_BLUE_1024_600/froms/default/audioplaying.ui
	修改：     application/reference_ui2/spLauncher/commons/setupviews/src/UI_FIAT_BLUE_1024_600/froms/setupdatetime.ui
	修改：     application/reference_ui2/spLauncher/commons/setupviews/src/UI_HYUNDAI_1024_600/froms/setupeq.ui
	修改：     application/reference_ui2/spLauncher/commons/setupviews/src/setupitems/commonitem.cpp
	修改：     application/reference_ui2/spLauncher/plugins/activity/btaudioactivity/btaudioview/btaudioview.cpp
	修改：     application/reference_ui2/spLauncher/plugins/activity/homelauncher/homeview/UI_FIAT_BLUE_1024_600/homepage.ui
	修改：     application/reference_ui2/spLauncher/plugins/activity/homelauncher/homeview/infopage.cpp
	修改：     application/reference_ui2/spLauncher/plugins/activity/radioactivity/radioview/UI_FIAT_BLUE_1024_600/RadioKeypad.ui
	修改：     application/reference_ui2/spLauncher/plugins/activity/radioactivity/radioview/UI_FIAT_BLUE_1024_600/default/RadioKeypad.ui


0419:
在手机点击music ,车机没有捕捉到这个信号，会不会是没在回调中存储到变量信息，
infocpp和homeview.cpp和homewight.cpp
会不会在module/androidautomodule/androidautomoduleimpl/androidautomoduleimpl.cpp和module/carplaymodule/carplaymodule.cpp
 //bool AndroidAutoModuleImpl::internalMainAudioRequest(int statetype,int action, b
                                        setAudioRes();// need set audio source before AA use

 ```
+#if defined (UI_NEW_TUCSON_1024_600)
+                    emit mediaInfoChangedSig(AUDIO_SOURCE_AA);
+#endif

```
//int CarplayModuleImpl::cpAudioSetup(int type)
```
+#if defined (UI_NEW_TUCSON_1024_600)
+        emit mediaInfoChangedSig(AUDIO_SOURCE_CP_MEDIA);
+#endif
```

0420：
flash镜像文件制作：

在连上打印线之后要先设置波特率115200
1B			//十六进制Esc,进入uboot模式，串口工具使用Hex格式发送
Esc			//进入uboot模式,可在minicom使用	
（如果是8368C还要重启一下，再按ESC进入Uboot）在开机起来的过程中按Esc进去uboot模式,15s后MCU会自动重启，重启时再次进入uboot就不会再重启了，此时插入USB
ispsp mtdparts_adj		//制作前必要步骤之调整flash块
（第一次无法识别，再输入一次）
snand_ghost usb 0 -sb -su	//8368U 从flash写出烧录文件到usb 0
ghost2snand usb 0 -sb		//8368U 从usb 0写入烧录文件到flash(软件验证)


snand_ghost_sb usb 0		//8368C 从flash写出烧录文件到usb 0



0421：
```
   <message>
        <source>AV In</source>
        <translation>ايه في انتل</translation>
    </message>
```
    <message>
        <source>USB</source>
        <translation>منفذ USB</translation>
    </message>

	    <message>
        <source>BT Audio</source>
        <translation>صوت بلوتوث</translation>
    </message>

	    <message>
        <source>Bluetooth</source>
        <translation>البلوتوث</translation>
    </message>
	在Bluetooth 增加无作用
	#define D_TRY_FIX_HANG_WHEN_CONNECT_CP_PHONE   1  //AV IN 播放界面,蓝牙通话中连接carplay，在蓝牙界面卡死  //没有项目用到这个宏

	0423：
	改对应页面的翻译，找到对应UI，根据周围定位所需
	找到控件的对象名字，搜索，看一下CPP文件，找到控件上面的函数或者槽，再搜一下哪个文件调用了这个函数
	

	0424：
	shell脚本中使用空格会起到分割参数的作用，有时候可能会造成混淆，请务必多加检查。
Bash中的字符串通过' 和 "分隔符来定义，但是它们的含义并不相同。以'定义的字符串为原义字符串，其中的变量不会被转义，而 "定义的字符串会将变量值进行替换。
```
foo=bar
echo "$foo"
打印 bar
echo '$foo'
打印 $foo
```

    $0 - 脚本名
    $1 到 $9 - 脚本的参数。 $1 是第一个参数，依此类推。
    $@ - 所有参数
    $# - 参数个数
    $? - 前一个命令的返回值
    $$ - 当前脚本的进程识别码
    !! - 完整的上一条命令，包括参数。常见应用：当你因为权限不足执行命令失败时，可以使用 sudo !!再尝试一次。
    $_ - 上一条命令的最后一个参数。如果你正在使用的是交互式 shell，你可以通过按下 Esc 之后键入 . 来获取这个值。


0425：
changePageSlot

 if (str == "prev")
    {
        qDebug()<<"kobe2";
        emit uiccToBasecontrol(UICC_PREV_TS, UICC_SHORT_PRESS);
    }
    else if (str == "next")
    {
        qDebug()<<"kobe3";
        emit uiccToBasecontrol(UICC_NEXT_TS, UICC_SHORT_PRESS);
    }


 #if defined (UI_NEW_TUCSON_1024_600)
    connect(ui->nextbtn, SIGNAL(btnClicked(QString)), this, SLOT(btnClickedSlot(QString)));
    connect(ui->prevbtn, SIGNAL(btnClicked(QString)), this, SLOT(btnClickedSlot(QString)));
#else
    connect(ui->prevbtn, SIGNAL(btnClicked(QString)), this, SLOT(changePageSlot(QString)));
    connect(ui->nextbtn, SIGNAL(btnClicked(QString)), this, SLOT(changePageSlot(QString)));
#endif

0426：

1297wt-53
1.对策开机反应卡顿问题 (加宏，设置GNSS初始波特率为9600)
2.对策ACC起来CP点击退出图标卡死问题(把字体只留下英语和阿拉伯语的缩小字体库，编译完后少了2.1M空间)
0428：
usb ：Volume was not properly unmounted. Some data may be corrupt. Please run fsck
Linux usb/U盘解除写保护：
tail -f /var/log/syslog
插入u盘
看自己是sdc1还是sdb别的
umount /media/chenshihao/HOUSE  (弹出u盘)
sudo dosfsck -v -a /dev/sdc1 

0505：
1.编译8388代码：
进入/Direct8388GitServer/linux/kernel/drivers/framebuffer 的makefile文件
修改SUPPORT_CHECK_CODING_STYLE=1 将1改为0
进行./mk      1
./mk      all
2.划词翻译pdf 网址：https://pdf.hakso.net/web/viewer.html
用火狐打开，并把要翻译的拖进去

0506:
关于回调函数的讲解：
https://blog.csdn.net/u011754972/article/details/116536698
https://blog.csdn.net/weixin_43056298/article/details/100520926
https://zhuanlan.zhihu.com/p/326902537
由于make_youtiao(10000)这个函数10分钟才能返回，你不想一直死盯着屏幕10分钟等待结果，那么一种更好的方法是让make_youtiao()这个函数知道制作完油条后该干什么，即，更好的调用make_youtiao的方式是这样的：“制作10000个油条，炸好后卖出去”，因此调用make_youtiao就变出这样了：

make_youtiao(10000, sell);

看到了吧，现在make_youtiao这个函数多了一个参数，除了指定制作油条的数量外还可以指定制作好后该干什么，第二个被make_youtiao这个函数调用的函数就叫回调，callback。

现在你应该看出来了吧，虽然sell函数是你定义的，但是这个函数却是被其它模块调用执行的

新的编程思维模式

让我们再来仔细的看一下这个过程。

程序员最熟悉的思维模式是这样的：

    调用某个函数，获取结果处理获取到的结果

res = request();
handle(res);

这就是函数的同步调用，只有request()函数返回拿到结果后，才能调用handle函数进行处理，request函数返回前我们必须等待，这就是同步调用
但是如果我们想更加高效的话，那么就需要异步调用了，我们不去直接调用handle函数，而是作为参数传递给request：

request(handle);

我们根本就不关心request什么时候真正的获取的结果，这是request该关心的事情，我们只需要把获取到结果后该怎么处理告诉request就可以了，因此request函数可以立刻返回，真的获取结果的处理可能是在另一个线程、进程、甚至另一台机器上完成。

这就是异步调用
从编程思维上看，异步调用和同步有很大的差别，如果我们把处理流程当做一个任务来的话，那么同步下整个任务都是我们来实现的，但是异步情况下任务的处理流程被分为了两部分：

    第一部分是我们来处理的，也就是调用request之前的部分第二部分不是我们处理的，而是在其它线程、进程、甚至另一个机器上处理的。

我们可以看到由于任务被分成了两部分，第二部分的调用不在我们的掌控范围内，同时只有调用方才知道该做什么，因此在这种情况下回调函数就是一种必要的机制了。

也就是说回调函数的本质就是“只有我们才知道做些什么，但是我们并不清楚什么时候去做这些，只有其它模块才知道，因此我们必须把我们知道的封装成回调函数告诉其它模块”。
对于一般的函数来说，我们自己编写的函数会在自己的程序内部调用，也就是说函数的编写方是我们自己，调用方也是我们自己。

但回调函数不是这样的，虽然函数编写方是我们自己，但是函数调用方不是我们，而是我们引用的其它模块，也就是第三方库，我们调用第三方库中的函数，并把回调函数传递给第三方库，第三方库中的函数调用我们编写的回调函数

而之所以需要给第三方库指定回调函数，是因为第三方库的编写者并不清楚在某些特定节点，比如我们举的例子油条制作完成、接收到网络数据、文件读取完成等之后该做什么，这些只有库的使用方才知道，因此第三方库的编写者无法针对具体的实现来写代码，而只能对外提供一个回调函数，库的使用方来实现该函数，第三方库在特定的节点调用该回调函数就可以了。

另一点值得注意的是，从图中我们可以看出回调函数和我们的主程序位于同一层中，我们只负责编写该回调函数，但并不是我们来调用的。

最后值得注意的一点就是回调函数被调用的时间节点，回调函数只在某些特定的节点被调用，就像上面说的油条制作完成、接收到网络数据、文件读取完成等，这些都是事件，也就是event，本质上我们编写的回调函数就是用来处理event的，因此从这个角度看回调函数不过就是event handler，因此回调函数天然适用于事件驱动编程event-driven，我们将会在后续文章中再次回到这一主题。
回调的类型

我们已经知道有两种类型的回调，这两种类型的回调区别在于回调函数被调用的时机。

注意，接下来会用到同步和异步的概念，对这两个概念不熟悉的同学可以参考上一盘文章《从小白到高手，你需要理解同步和异步》。

同步回调

这种回调就是通常所说的同步回调synchronous callbacks、也有的将其称为阻塞式回调blocking callbacks，或者什么修饰都没有，就是回调，callback，这是我们最为熟悉的回调方式。

当我们调用某个函数A并以参数的形式传入回调函数后，在A返回之前回调函数会被执行，也就是说我们的主程序会等待回调函数执行完成，这就是所谓的同步回调。
有同步回调就有异步回调。
回调对应的编程思维模式

让我们用简单的几句话来总结一下回调下与常规编程思维模式的不同。

假设我们想处理某项任务，这项任务需要依赖某项服务S，我们可以将任务的处理分为两部分，调用服务S前的部分PA，和调用服务S后的部分PB。

在常规模式下，PA和PB都是服务调用方来执行的，也就是我们自己来执行PA部分，等待服务S返回后再执行PB部分。

但在回调这种方式下就不一样了。

在这种情况下，我们自己来执行PA部分，然后告诉服务S：“等你完成服务后执行PB部分”。

因此我们可以看到，现在一项任务是由不同的模块来协作完成的。

即：

    常规模式：调用完S服务后后我去执行X任务，
    回调模式：调用完S服务后你接着再去执行X任务，

其中X是服务调用方制定的，区别在于谁来执行。
为什么异步回调这种思维模式正变得的越来越重要

在同步模式下，服务调用方会因服务执行而被阻塞暂停执行，这会导致整个线程被阻塞，因此这种编程方式天然不适用于高并发动辄几万几十万的并发连接场景，

针对高并发这一场景，异步其实是更加高效的，原因很简单，你不需要在原地等待，因此从而更好的利用机器资源，而回调函数又是异步下不可或缺的一种机制。
回调地狱，callback hell

有的同学可能认为有了异步回调这种机制应付起一切高并发场景就可以高枕无忧了。

实际上在计算机科学中还没有任何一种可以横扫一切包治百病的技术，现在没有，在可预见的将来也不会有，一切都是妥协的结果。

那么异步回调这种机制有什么问题呢？

实际上我们已经看到了，异步回调这种机制和程序员最熟悉的同步模式不一样，在可理解性上比不过同步，而如果业务逻辑相对复杂，比如我们处理某项任务时不止需要调用一项服务，而是几项甚至十几项，如果这些服务调用都采用异步回调的方式来处理的话，那么很有可能我们就陷入回调地狱中。

举个例子，假设处理某项任务我们需要调用四个服务，每一个服务都需要依赖上一个服务的结果，如果用同步方式来实现的话可能是这样的：

a = GetServiceA();
b = GetServiceB(a);
c = GetServiceC(b);
d = GetServiceD(c);

代码很清晰，很容易理解有没有。

我们知道异步回调的方式会更加高效，那么使用异步回调的方式来写将会是什么样的呢？

GetServiceA(function(a){
    GetServiceB(a, function(b){
        GetServiceC(b, function(c){
            GetServiceD(c, function(d) {
                ....
            });
        });
    });
});

我想不需要再强调什么了吧，你觉得这两种写法哪个更容易理解，代码更容易维护呢？

博主有幸曾经维护过这种类型的代码，不得不说每次增加新功能的时候恨不得自己化为两个分身，一个不得不去重读一边代码；另一个在一旁骂自己为什么当初选择维护这个项目。

异步回调代码稍不留意就会跌到回调陷阱中，那么有没有一种更好的办法既能结合异步回调的高效又能结合同步编码的简单易读呢？

幸运的是，答案是肯定的，我们会在后续文章中详细讲解这一技术。
总结

在这篇文章中，我们从一个实际的例子出发详细讲解了回调函数这种机制的来龙去脉，这是应对高并发、高性能场景的一种极其重要的编码机制，异步加回调可以充分利用机器资源，实际上异步回调最本质上就是事件驱动编程，这是我们接下来要重点讲解的内容。

我个人的理解是回调函数就是通过函数指针来调用的函数，为什么不直接调用函数是因为可以实现用普遍适用的函数来调用不同的回调函数。例如：系统层的程序猿会编写好接口供应用层的程序猿用，操作系统会调度这个接口，但应用程序猿只知道这是个函数指针，指针指向的函数是由他自己编写的，这一步叫做登记回调函数。这是回调函数/函数指针最重要的作用
同步和异步整体阅读下来感觉和线程有关，回调函数本身并不能实现异步，但异步的实现离不开回调函数。比如pthread_create(...)创建线程，其中一个参数便是函数指针


 git log
 1998  git pull
 1999  git log 
 2000  git branch -a
 2001  git checkout remotes/origin/8368XU_MaxmadeDevelop
 2002  git log 
 2003  git pull
 2004  git pull origin 8368XU_MaxmadeDevelop
 2005  git log
 2006  git log 
 2007  git branch -a
 2008  git pull
 2009  git pull origin 8368XU_MaxmadeRelease
 2010  git pull
 2011  git branch -a
 2012  git checkout 8368-XU-20220901
 2013  git log 
 2014  git branch -a
 2015  git pull
 2016  git checkout 8368XU_MaxmadeDevelop
 2017  git branch -a
 2018  git log
 2019  git pull
 2020  vim ui.cfg 
 2021  gedit ui.cfg 
 2022  history 


编译8368xu的平台代码命令：
./mk     2
./mk	 all
编译8368C平台代码命令：
首先/home/chenshihao/Direct8388GitServer/linux/kernel/drivers/framebuffer打开makefile，将1改为0（SUPPORT_CHECK_CODING_STYLE=0）
./mk   1
./mk    all
0508：
video][ VideoUiRender.cpp writeFrame 185] ERR: write frame failed, ret= 1
[2023-05-08 10:48:13] PE_ES_Feed fai


0511：
默认值不可以是局部变量，因为默认参数的函数调用是在编译时确定的，而局部变量的位置与值在编译时均无法确定。
0512:
快速打开Linux的svn命令：rabbitvcs browser

0515：
widget是包名，包含了继承自View的各个控件和相关的Adapter类什么的
View是类，显示在界面上的一切都和他有关
0516：
ui2->sp->搜索setupeq.cpp  352line
 if (isAutoHide)
    {
        autoHideTimerId = startTimer(AUTOHIDE_TIMER);
    }
    installEventFilter(this);
    //setGeometry(geometry);
	将setGeometry弄掉注释

0518：
在wps表格里面如果能选择的选项过少，需要增添 数据->有效性->允许的序列和信息来源：有多个表（=信息定义!$j$4:$j$13）意思是在分表格信息定义的第J列的第4行到第13行

0527:
刚开机快速打开svn： rabbitvcs browser