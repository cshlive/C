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
git  reset --hard  id  回退
git revert：撤销某个提交，做反向操作，生成新的commitId，原有提交记录保留。git revert commitId。
回退分两种情况：
   已 commit，未push到远程仓库。

    git reset --soft（撤销commit）。

    git reset --mixed（撤销 commit 和 add 两个动作）。

已 commit，并且push到了远程仓库。

    git reset --hard（撤销并舍弃版本号之后的提交记录）。

    git revert（撤销，但是保留了提交记录）。

git checkout .(清空工作区，恢复到刚pull下来的状态)
git revert基础用法
基础语法

git revert -n commit-id

    只会反做commit-id对应的内容，然后重新commit一个信息，不会影响其他的commit内容

反做多个commit-id

git revert -n commit-idA..commit-idB

    反做commit-idA到commit-idB之间的所有commit注意：使用-n是应为revert后，需要重新提交一个commit信息，然后在推送。如果不使用-n，指令后会弹出编辑器用于编辑提交信息

冲突的相关操作

    在git操作过程中，最不想看到的一种情况就是冲突，但是，冲突就是一个狗皮膏药，永远避免不了，revert也跑不了这个魔咒，那么我们改怎么处理这个情况

合并冲突后退出

git revert --abort

    当前的操作会回到指令执行之前的样子，相当于啥也没有干，回到原始的状态

合并后退出，但是保留变化

git revert --quit

    该指令会保留指令执行后的车祸现场

合并后解决冲突，继续操作

    如果遇到冲突可以修改冲突，然后重新提交相关信息

git add .
git commit -m "提交的信息"

总结
Git reset和git revert的区别

    git reset 是回滚到对应的commit-id，相当于是删除了commit-id以后的所有的提交，并且不会产生新的commit-id记录，如果要推送到远程服务器的话，需要强制推送-fgit revert 是反做撤销其中的commit-id，然后重新生成一个commit-id。本身不会对其他的提交commit-id产生影响，如果要推送到远程服务器的话，就是普通的操作git push就好了


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
把24位图重新命名为logo(请注意，此操作非常重要，不然经常黑屏没效果),找到项目底下目录的build/Tools/binary_gen，在此用终端打开，把焦点换到文件。把同名文件脚本拖到终端，再把bmp文件拖进去生成一个.bin文件（两个bin文件，可以将isp开头的的bin文件改为logo.bin），把这个文件拷贝到application/config/maxmade/项目名字，放到logo文件夹下并且rename文件为logo.bin
图片格式要求为24位bmp(不能为大写的BMP,否则会无法显示),颜色为256色的图片 (如何获取24位256色的图片,可将24位大于256色的图片让美工先转为256色8位的图片,再转回24位,这样将可将logo图片的颜色降为256色);实验可以将logo.bin放到out文件下，./mka....  rom编译看看是否有效
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
gedit 打开一个文本编辑器
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

* linux 终端命令：
 linux下自定义命令的几种实现方法
说明

在使用linux时，我们有很多时候可以把自己经常用到的一些脚本做成自己的指令，这样使得我们在用户全局都可以使用自定义的指令，那么实现自定指令的方法有哪些呢，今天在这里根据自己的经验稍微总结一下。
方法一:环境变量法

熟悉linux的都知道，大部分发行版都会判断用户目录下是否有bin目录，如果有就会将这个目录加入环境变量，也就是说，我们可以将一些脚本写好放到这个目录下，也就是$HOME/bin目录下，这样我们就可以在终端直接调用脚本了，上述判断bin目录是否存在的部分一般会放在$HOME/.profile,我的系统下这部分内容如下：
复制代码
```
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
fi

复制代码

 ```

 

当然，如果之前目录中没有bin目录，我们自己手动在$HOME目录下建立bin,这个时候需要我们注销后再登录才可以，或者执行source $HOME/.profile。
方法二:alias方法

bash下我们可以使用alias来为一些简单的命令定义别名，一般这个命令都放在$HOME/.bashrc文件下，如下所示：
复制代码

 1 # some more ls aliases
 2 #alias ll='ls -l'
 3 #alias la='ls -A'
 4 #alias l='ls -CF'
 5 #mywine
 6 alias mwine='WINEPREFIX=/home/yhp/.mywine/deepin_mywine deepin-wine'
 7 #个人华为云服务器
 8 alias mhw_server='ssh yhp@139.159.243.162'
 9 #挂载个人华为云服务器的 /home/yhp 文件夹到本地 /home/yhp/hw_work_space
10 alias mhw_mount='sshfs yhp@139.159.243.162:/home/yhp /home/yhp/hw_work_space'
11 alias mhw_umount='fusermount -u /home/yhp/hw_workspace'
12 #添加更人密码到个人密码管理库
13 alias mpasswd='sudo bash ~/.hp_passwd/hp_passwd.sh'

复制代码

 
方法三:建立fish shell一样的函数机制

上面两种方式不太好管理，而fish shell中自定义指令是使用函数的方式来实现的，一条自定义指令可以对应一个函数，于是我们可以借助fish shell的这种思路来在bash上实现。实现方法如下：

建立放置函数的文件夹
我的方法是在$HOME下建立.bash_func文件夹，可使用命令 mkdir -p $HOME/.bash_func实现。

在$HOME/.bashrc下添加加载函数的代码
在$HOME/.bashrc后面添加以下部分，
复制代码

1 if [ -d "$HOME/.bash_func" ]
2 then
3     if [[ $(ls $HOME/.bash_func | wc -c ) -gt 0 ]];then
4         for flist in $(ls $HOME/.bash_func) 
5         do
6             . $HOME/.bash_func/$flist
7         done
8     fi
9 fi

复制代码

 

这样以来，我们在~/.bash_func/下建立文件写函数，启动终端后，就能自动加载函数，之后就可以做为自定义的指令使用。

比如，我们建立t_func文件，文件内容如下：

1 function t_func(){
2     echo "hello,this is a demo!"
3 }

 

然后我们新打开一个终端，注意要新打开，或者你可以先把shell切换到sh，再切换到bash，使得.vimrc文件被加载，然后我们终端输入t_func可以看到效果！

需要注意的是，要写成函数的形式，虽然一个文件中可以写多个函数，但是建立一个文件写一个函数，一个函数就是一条自定义指令，这样方便管理！
总结比较
方法	优点	缺点
环境变量法 	管理方便，实现简单 	fork了子模块，注定有些你想要实现的实现起来可能比较复杂
alias法 	简单，明了 	如果要实现复杂的，将要写脚本，在赋别名，不好管理
函数法 	管理方便，实现简单，函数在终端启动时就加载完毕 	过多的函数可能造成启动终端较慢，单应该没有明显的迟钝

 

https://www.kancloud.cn/dlover/note2020/1796109


* linux平台调触摸屏的操作步骤
1.获取触屏坐标 
严格来说，我们只需使用GuitarTestPlatform.exe（防御量产测试工具文件夹中），检测触摸屏有无问题，若有问题（如某块地方无报点，原始值过低，触摸屏某通道损坏，等等），需通报给质量部和供应商，由供应商调好。当供应商给回触摸屏软件参数时，只需将参数刷进屏中即可。
刷参数步骤如下：
（1）参数名通常为xxx.cfg，打开调屏工具，选好调屏工具的配置（如GT911），点击 “选择文件”，选择所需参数文件，点击“开始测试”，等待参数全部刷入完成。

测试结束之后，若出现红色字体的内容，说明参数刷入成功，若出现了其他内容，说明参数刷入失败。可通过多次刷入参数来确认触摸屏是否出问题。（注意：每次在调触摸屏之前，将屏内原有参数保存，防止调试出错之后可再刷入原有参数。）
（2）点击原始值按钮，查看触摸屏的指标是否有变化，如原始值，刷新频率，工作频率等等，确认刷入成功，触摸屏各项指标正常，使用正常。（确认触摸屏触摸没问题的方法：画线不中断，每次点击都要报点，单点只报一个点，点击时点击区域内的最大差值要在100以上。）

调触摸屏时，我们只需关心三点：原点位置，可视区域分辨率，按键坐标范围。
使用调屏工具获取坐标，记录触摸屏按键坐标范围，确认可视区域分辨率为所需（通常是1024*600或800*480，需根据项目来）。
2.将按键坐标写入触摸屏驱动文件
（1）相关平台路径为：（以8388平台为例）
主路径 ：Direct8388GitServer/application/drivers/touch/
分路径1） /c-mmcommon，打开后修改gt9xx-common.h，gt9xx-common.c 文件的有关参数。
分路径2） /c-mmcommonLR02，单独作出该文件夹，是因为有的触摸屏将按键坐标和可视区域的坐标连成一块了（通常可视区域部分x坐标的范围时0～1024，按键的范围是其他）。以x轴为例，0～50，为左侧按键坐标范围，50～1060为可视区域范围，1060～1110为右侧按键范围。若直接将可视区域的坐标传回，会造成车机软件在触摸屏中显示出的按钮存在按键偏移。故需减去这个偏移范围（例如50个像素点）。其他分路径1类似。
3.编译生成xxx.ko文件
（举例如下）在linux环境下，从命令行进入到c-mmcommon文件夹中， 执行 “make”指令，编译成功后，可生成一个yyy.ko（yyy为某个名字）文件，改成所需的xxx.ko（自定义的名字），并将该文件拷至touch/ 目录下。若执行make不成功提示找不到编译工具链arm-none-linux-gnueabi-gcc，则需要声明项目所用到的gcc工具链添加到环境变量里(以8368-U为例，工具链位于8368-U-20200422/build/tools/arm-2014.05/bin目录下)：
1.家目录打开 gedit .bashrc
2.文本末添加
export PATH=xxx/8368-U-20200422/build/tools/arm-2014.05/bin:$PATH
export PATH=xxx/8368-U-20200422/:$PATH
umask 022
xxx为工程项目的绝对路径
(谭宏杰2021.07.06补充)
4.更改APP中的配置文件
更改对应项目（如Direct8388GitServer/application/config/maxmade/AN_2268_01/）的app_config文件，将APPCFG_TOUCH_DRIVER=xxx.ko（即改成自定义的名字），之后编译（执行 “make all”指令）时会自行载入。
（前四项主要为莫勇兴编写，法春鹏进行补充）
5.在TouchKey.cpp中增添对应触摸屏按键的功能
找到HandleTouchKeyDown(int nKey)和HandleTouchKeyUp(int nKey)两个函数，添加对应触摸屏按键的功能。
6.补充
（1）若需要调触摸屏的刷新率可查阅基频速查表V3.0，选取合适的基频





按F5，出现上图，更改划线位置的数值。若更改之后出现问题，可寻求供应商的帮助。

（2）另外，若新打样的触摸屏需要确认，需将屏内的参数保存，将该参数与之前保存的对应的触摸屏参数做对照，保证两次的参数一致。若该触摸屏是第一次打样，在保证触摸屏没问题的情况下，保存该参数并传到SVN上。

（3）提取按键坐标时，应尽量提取较大的按键范围，但前提是不干扰到其他按键或触摸区域。

* 高亮显示编译错误
在Linux中，可以使用一些工具来高亮显示编译错误信息，并将其翻译成中文。以下是一种常用的方法：

    安装gcc编译器和gettext工具：

复制代码
sudo apt-get install gcc gettext

    安装gccfilter工具：

复制代码
git clone https://github.com/nico/parse-analyzer.git
cd parse-analyzer
make
sudo make install

    配置gccfilter：

复制代码
sudo ln -s /usr/local/bin/gccfilter /usr/local/bin/cc
sudo ln -s /usr/local/bin/gccfilter /usr/local/bin/c++

    配置~/.bashrc文件，将以下内容添加到文件末尾：

复制代码
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export CC=/usr/local/bin/gccfilter
export CXX=/usr/local/bin/gccfilter

    保存并退出~/.bashrc文件，然后执行以下命令使配置生效：

复制代码
source ~/.bashrc

现在，当你使用gcc或g++编译代码时，错误信息将以高亮方式显示，并且错误信息也会被翻译成中文。
4.删除或重装

a) 删除 ~/.bashrc 后面的所有添加的 alias 别名，以免造成其他未知影响。
b) 删除 /usr/local/bin/color_compile 可执行程序

    1
    2

  sudo rm /usr/local/bin/color_compile

    1

其他情况：
1、gcc 版本为 4.9.0 以上时，可以使用 gcc 内置的高亮显示，加上参数 -fdiagnostics-color=auto 即可
2、需要修改其他颜色输出，只要修改 out_color_info.c 源码即可


# 讲解
指令修改文件中某个文本模式的操作。

具体解释如下：

    sed是一个流编辑器，用于对文本进行编辑和转换。
    -i选项表示直接修改文件，而不是输出到标准
1. 设计模式：

    分解
        人们面对复杂性有一个常见的做法：即分而治之，将大问题分解为多个小问题，将复杂问题分解为多个简单问题。
    抽象
        更高层次来讲，人们处理复杂性有一个通用的技术，即抽象。由于不能掌握全部的复杂对象，我们选择忽视它的非本质细节，而去处理泛化和理想化了的对象模型。

面向对象设计原则

    依赖倒置原则（DIP）

    高层模块(稳定)不应该依赖于低层模块(变化)，二者都应该依赖于抽象(稳定) 。
    抽象(稳定)不应该依赖于实现细节(变化) ，实现细节应该依赖于抽象(稳定)。

    开放封闭原则（OCP）

    对扩展开放，对更改封闭。
    类模块应该是可扩展的，但是不可修改。

    单一职责原则（SRP）

    一个类应该仅有一个引起它变化的原因。
    变化的方向隐含着类的责任。

    Liskov 替换原则（LSP）

    子类必须能够替换它们的基类(IS-A)。
    继承表达类型抽象。

    接口隔离原则（ISP）

    不应该强迫客户程序依赖它们不用的方法。
    接口应该小而完备。

    优先使用对象组合，而不是类继承

    类继承通常为“白箱复用”，对象组合通常为“黑箱复用” 。
    继承在某种程度上破坏了封装性，子类父类耦合度高。
    而对象组合则只要求被组合的对象具有良好定义的接口，耦合度低。

    封装变化点

    使用封装来创建对象之间的分界层，让设计者可以在分界层的一侧进行修改，而不会对另一侧产生不良的影响，从而实现层次间的松耦合。

    针对接口编程，而不是针对实现编程

    不将变量类型声明为某个特定的具体类，而是声明为某个接口。
    客户程序无需获知对象的具体类型，只需要知道对象所具有的接口。
    减少系统中各部分的依赖关系，从而实现“高内聚、松耦合”的类型设计方案。


2. 关于回调函数的讲解：
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

一 何为注册回调 

   注册回调简单解释就是一个高层调用底层，底层再回过头来调用高层，这个过程就叫注册回调， 连接高层和底层就叫注册回调函数。高层程序C1调用底层程序C2，而在底层程序C2 又调用了高层程序C2的callback函数，那么这个callback函数对于高层程序C1来说就是回调函数。 在设计模式中这个方式叫回调模式。





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
9. 注册回调函数
```

二 注册回调函数的实例：

//底层程序 C2

    #include<iostream>
     
    using namespace std;
     
    class CCallback
    {
    public:
    	virtual void onCallbackFunc(int value,int type) =0;	
    };
     
    class ClassA
    {
    public: 
    	ClassA(CCallback *pCallbackFunc)
    	{
    		m_pCallBack = pCallbackFunc;	
    	}
     
    	void showValue()
    	{
    		m_pCallBack->onCallbackFunc(15,0);
    		m_pCallBack->onCallbackFunc(17,1);
    	}
    private:
    	CCallback *m_pCallBack;
     
    };


//高层程序 C1

    #include<iostream>
    #include"ClassA.hpp"
    using namespace std;
     
    class ClassB : public CCallback
    {
    public:
    	ClassB()
    	{
    		m_ClassA = new ClassA(this);				
    	}
     
    	void onCallbackFunc(int value,int type)
    	{
    		if(type == 0)
    		{
    			cout<<"Typ_ZERO =  "<< value<<endl;
    		}
    		else
    		{
    			cout<<"Typ_Other =  "<< value<<endl;
    		}
    	}
     
    	void TestShowData()
    	{
    		m_ClassA->showValue();
    	}
    public:
    	ClassA * m_ClassA;
    };


//主程序 main 

    #include "stdafx.h"
    #include"ClassB.hpp"
     
     
    int _tmain(int argc, _TCHAR* argv[])
    {
     
    	ClassB *m_classB =new ClassB();
    	
    	m_classB->TestShowData();
     
    	system("pause:");
    	return 0;
    }


测试结果：



上面就是一个简单的注册回调的过程。


三 ： 注册回调有何作用

 注册回调 可以让调用者与被调用者分开。调用者不关心谁是被调用者，所有它需知道的，只是存在一个具有某种特定原型、某些限制条件（如返回值为int）的被调用函数。
 





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
用脚本更换开机logo，确保图片格式位24位256色的，不是该格式的话会黑屏显示，把24位图重新命名为logo(请注意，此操作非常重要，不然经常黑屏没效果)

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
如果是新的flash，可以先烧一个有对应flash型号文件或者同一平台其他flash，再用U盘升级，再来制作，避免强制升级


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
0530：
关于C++强制类型转换：https://blog.csdn.net/Bob__yuan/article/details/88044361

0607：
spcarplaymanager类：负责管理device的生命周期和carplay相关配置（配置路径，本机BT-address）
spcarplay类：负责管理与iPhone连接过程中的各种交互处理
0608：蓝牙自动化测试问题，看见是把定时器时间延长。DAB版本数据错乱，可能是发送命令太频繁或者是接受命令后的回复不够及时，后面经过黄朝望分析，是carplay模块占用太大，拖慢其他进程导致。XU的强制升级需要接尾线接方控(一根线接KEY1或者KEY2，另外一根接地)，按souce键长按5s，再松开1s，再长按5s

0609：
不过对于多设备通讯，无论上面是否有协议，其最终都是通过物理上的电缆，光纤或PCB布线上转换成电信号或光信号，甚至对于无线通讯来说转换成电磁波信号进行传输，这些数字->模拟->数字转换实现需要满足的连接引脚特性，电气特性，通讯时序和数据发送和接收的状态定义就是接口

作者：听心跳的声音
链接：https://zhuanlan.zhihu.com/p/344288542

C语言允许程序变量在定义时就确定内存地址，通过作用域，以及关键字extern，static，实现了精细的处理机制，按照在硬件的区域不同，内存分配有三种方式(节选自C++高质量编程)：1). 从静态存储区域分配。内存在程序编译的时候就已经分配好，这块内存在程序的整个运行期间都存在。例如全局变量，static 变量。2). 在栈上创建。在执行函数时，函数内局部变量的存储单元都可以在栈上创建，函数执行结束时这些存储单元自动被释放。栈内存分配运算内置于处理器的指令集中 ，效率很高，但是分配的内存容量有限。3). 从堆上分配，亦称动态内存分配。程序在运行的时候用 malloc 或 new 申请任意多少的内存，程序员自己负责在何时用 free 或 delete 释放内存。动态内存的生存期由程序员决定，使用非常灵活，但同时遇到问题也最多。

作者：听心跳的声音
链接：https://zhuanlan.zhihu.com/p/81054282

如果需要频繁申请内存块的场景，都会构建基于静态存储区和内存块分割的一套内存管理机制，一方面效率会更高(用固定大小的块提前分割，在使用时直接查找编号处理)，另一方面对于内存块的使用可控，可以有效避免内存碎片的问题，常见的如RTOS和网络LWIP都是采用这种机制，我个人习惯也采用这种方式，所以关于堆的细节不在描述，如果希望了解，可以参考<C Primer Plus>中关于存储相关的说明。

作者：听心跳的声音
链接：https://zhuanlan.zhihu.com/p/81054282



0615：
gedit .bashrc  配置快捷命令比如将升级文件拷到U盘并拔出
alias cpusb='/home/chenshihao/sh/democp.sh'
alias qtui=''/home/chenshihao/Qt5.3.2/5.3/gcc_64/bin/designer''	
logset   ALOG_LEVEL  v   开最高等级的打印

0617：
安装之前：
sudo apt-get update
sudo aptt update
解决依赖问题
    如果上述办法还是没有解决问题，依旧缺少很多依赖关系，可以循环使用下面两个命令进行安装

    sudo apt-get -f install
    sudo apt-get install 依赖关系名


0619:
chatgpt ：https://cat2.imiku.me/user
密钥：cat-lDG1wqCQOll67G4nbtvIbTqyAwo4zGcJBaAo80M3G27BHYtt

0626：
一 何为注册回调 

   注册回调简单解释就是一个高层调用底层，底层再回过头来调用高层，这个过程就叫注册回调， 连接高层和底层就叫注册回调函数。高层程序C1调用底层程序C2，而在底层程序C2 又调用了高层程序C2的callback函数，那么这个callback函数对于高层程序C1来说就是回调函数。 在设计模式中这个方式叫回调模式。


关于android auto：

这是一个关于Android Auto模块的程序流程，大致可以分为以下几个步骤：

    AAManagerCallback类继承SPAndroidAutoManagerCallback类，并在其中定义了deviceAttachSignal信号和androidautoAttached槽函数。当设备连接时，AAManagerCallback会发出deviceAttachSignal信号，然后调用androidautoAttached槽函数。

    在androidautoAttached槽函数中，新建AACallBack和AAAudioSessionCallback对象，并通过SPAndroidAutoManager类获取accessoryId，然后注册AACallBack回调函数。之后，检查蓝牙状态并告诉蓝牙AA状态，设置屏幕资源紧急优先级和增益。

    当AACallBack回调函数runningStateChangeHandler检测到状态变化时，会执行相应的操作，例如开始、探测开始、探测成功等。当探测成功时，会启动定时器并显示第一次连接提示框，然后获取屏幕资源并设置视频源，触发规则并记录AA可视状态。

    当AACallBack回调函数bluetoothPairingRequestHandler检测到需要蓝牙配对时，会请求蓝牙配对。

    最后，在androidAutoShow函数中，Android Auto模块会展示相关内容。

总体来说，这个程序流程涉及到了许多不同的类和对象，包括AAManagerCallback、AACallBack、AAAudioSessionCallback、SPAndroidAutoManager、ImplicitSource等。其中，AACallBack是最重要的一个对象，它负责处理Android Auto模块的各种状态变化和事件，并触发相应的操作。


0627：
TD平台更换logo后开机顺闪主界面，加#define WARNING_AND_NOWARING_INDEPENDENT_INI	1    //警告和无警告INI独立  
搜该套UI，对应型号的homeview，改ini,增加warning.ini，和style的homerc

0629：
关于android auto S21手机连AA有异常，其他手机无异常的情况，对比S9和pixel4的正常情况的AA版本，发现S21原来测试时的android auto版本是9.4版本，正常手机是9.7版本，现在将S21手机升级AA的版本升级到最新（9.8），则可以解决出现地图显示不完整问题

将位智地图更新app，则可以解决点击无响应的问题

是更新了什么接口，导致会有这种不兼容问题，那为什么出问题的手机能在别的机型上正常，软件连接流程上是否有什么不一样？为什么在别的机型不更新也能兼容，但是只有该机型会有问题



0705:
cp卡死：
basecontrol.cpp:
 case UICC_BT_HUNGUPCALL:
        {
            BASEC_D(__FUNCTION__<<__LINE__<<"  @@@UICC_BT_HUNGUPCALL");
            //zwh 20180915 for CarPlay reject call.
            if(spInfo->getSysState(SYS_INFO_NAME_CPPHONE_CALL).toBool())
            {
                BASEC_D(__FUNCTION__<<__LINE__);
                emit carplayKeyDispatch(KeyAngle, true);
                emit carplayKeyDispatch(KeyAngle, false);
                return;
            }


0706:
关于acc起来大灯无识别作用
1297-65HX可以  UI_HYUNDAI_1024_600
现在从头文件排除，实在没有只能是UI_FIAT_1024_600有问题
2267defconfig和appconfig,以及ui.cfg的pannal 修改无作用

#define SETUP_SELECT_PHONE_PAGE    1  //显示选择手机页面	
#define NO_START_WARNING_PAGE   1
#define D_PARKING_FUNC_DEFAULT_ON  1 //默认打开手刹
#define D_SETUP_REVERSE_ASSIST_HIDE_OFF    0    //倒车选择开关，为隐藏开关，0：开；1：关
#define BT_AUDIO_START_LAST_SOURCE			1	//断Acc之前是蓝牙音乐，acc起来继续启动蓝牙音乐(我也不知到为什么别的项目不记忆蓝牙音乐？)
#define FILTER_FREQUENT_KEY_RESPONSE_EVENT		1		//过滤频繁的按键响应事件
#define ENABLE_SHOW_WARNING 1
#define D_BT_DISCONNECT_AFTER_CONNECT_CP 1
#define D_SUPPORT_REVERSE_CALL_FULL_VOLUME 1
#define INFO_PICTURE_SUPORT_CHANGE_SOURCE 1
#define  DIALOG_RESOURSE_INDEPENDENTLY 1
#define WIRED_ASR_NO_DEVICE_TIPS 1
#define D_SUPPORT_REVERSE_STATE  0   //支持倒车镜像隐藏
#define D_DefaultTIMEZONE	-360//设置时区
#define SPEED_UP_RADIO_DATA_DISPLAY  1 //重新进入收音，加快收音显示
	
#define D_SUPPORT_REVERSE_STATE  0
#define SUPPORT_FIAT_FAST_GUIDE 1   //说明书
#define D_REVERSE_VOLUME_DEFAULT_TYPE 	0	//默认的倒车音量类型
#define D_DERCO_AREA_DEFAULT_TYPE	1	//歌斯达黎加
#define SUPPORT_DERCO_AREA	1	//设置内的区域切换为主界面derco图标内容的不同
#define SUPPORT_DERCO_AREA_SWITCH 2

//#define WIFI_CONFIG_CHANEL_SELECT "149,153,157,161,165"
#define PURE_COLOR_STYLE_MODULE_DIALOG 1
#define D_GNSS_MODULE_BAUD_RATE		9600
#define D_GNS_GET_FAIL_DATA_DELAY_NEW    1
#define D_TRY_TO_FIX_APP_HANG 1	


最后发现是#define FILTER_FREQUENT_KEY_RESPONSE_EVENT		1		//过滤频繁的按键响应事件
这个宏有问题


0710:
1297W-65M 新更新MCU方控无作用并且部分有反应但键值错位
恢复到最早送样的时候的MCU方控有作用但部分但键值移位
硬件用万用表排除了方控本身的问题
并且找了一台能使用该方控的机子，并不会有问题
进而确定是MCU问题


0711：

* 策略模式（strategy）：
动机：软件构建时某些对象里面使用的方法或者算法经常改变，软件运行时依据需要透明地更改对象使用算法，将对象和算法解耦分隔开来。
定义一系列算法，把它们一个个封装起来，并且使它们可互相替换（变化）。该模式使得算法可独立于使用它的客户程序(稳定)而变化（扩展，子类化）。 ——《设计模式》 GoF

要点总结

    Strategy及其子类为组件提供了一系列可重用的算法，从而可以使得类型在运行时方便地根据需要在各个算法之间进行切换。
    Strategy模式提供了用条件判断语句以外的另一种选择，消除条件判断语句，就是在解耦合。含有许多条件判断语句的代码通常都需要Strategy模式。
    如果Strategy对象没有实例变量，那么各个上下文可以共享同一个Strategy对象，从而节省对象开销。

* 装饰者模式（decorate）：
动机：过度使用继承来扩展对象的功能，继承引入静态特质让扩展缺乏灵活性，避免子类过多和膨胀。
动态（组合）地给一个对象增加一些额外的职责。就增加功能而言，Decorator模式比生成子类（继承）更为灵活（消除重复代码 & 减少子类个数）。 ——《设计模式》GoF

定义一个装饰者的基类（中间者的角色），后续在这个类不断继承，不影响当初最开始的基类（底层）

* 模板方法模式

动机：
    多个子类有公有的方法，并且逻辑基本相同时。
    重要、复杂的算法，可以把核心算法设计为模板方法，周边的相关细节功能则由各个 子类实现。
    重构时，模板方法模式是一个经常使用的模式，把相同的代码抽取到父类中，然后通过钩子方法约束其行为。




* 观察者模式：

定义对象间的一种一对多（变化）的依赖关系，以便当一个对象(Subject)的状态发生改变时，所有依赖于它的对象都得到通知并自动更新。 ——《 设计模式》 GoF
要点总结

    使用面向对象的抽象，Observer模式使得我们可以独立地改变目标与观察者，从而使二者之间的依赖关系达致松耦合。
    目标发送通知时，无需指定观察者，通知（可以携带通知信息作为参数）会自动传播。
    观察者自己决定是否需要订阅通知，目标对象对此一无所知。
    Observer模式是基于事件的UI框架中非常常用的设计模式，也是MVC模式的一个重要组成部分。

0712：

关于QT线程的问题：
Qt GUI 必须在主线程中运行。所有QWidget和几个相关的类，例如 QPixmap，在辅助线程中不起作用。辅助线程通常被称为“工作线程”。
与进程不同，线程共享相同的地址空间。

关于1297W-65M，点击语音弹出框问题，可以调整文字坐标  layout_textdialog
/home/chenshihao/8368-U-20200422/application/reference_td2/tdLauncher/view/resources/resources1024/Default_UI/etc/common

关于设置界面的麦克风选项：

修改头文件
//setup general 滚动区域高度
#define D_SETUP_GENERAL_SCROLL_AREA_HEIGHT 700

改setup.ini
common_list_scoll_win={
      type="window"
      x=56
      y=0
      w=909
      h=520
      style="common_sub_gback_style"
      flags={
        hide_scrollbar
        window_scroll_fix_bg
        window_scroll
        no_h_scroll
        scroll_grab_mouse
      }
改layout_comdialog.ini
 prompt_text={
     type="textarea"
-    x=258
+    x=288
     y=206
-    w=507
+    w=470
     h=100
     style="dialog_prompt_text"
     flags={
对策点击语音，字体显示不对称

0714：
对策出现蓝牙配对码后再点击语音键UI显示不完全
在头文件加上宏
#define SHOW_NOMAL_TIPS 1     //防止配对信息默认调整语音UI位置
/home/chenshihao/8368-U-20200422/application/reference_td2/tdLauncher/view/commons/comviews/base的dialog.cpp

void ComDialog::setDialogShowState(int nState)
case ShowChoiceState:
	{
		#if defined(UI_JENSEN_1024_600) || defined(UI_SUZUKI_1024_600)
		#if defined(SHOW_NOMAL_TIPS)
    	TWidget *prompttext = (TWidget *)TObjectGetFromName("prompt_text");
		TwMove(prompttext,288,206);
		#endif		

0718：
关于QT开发的一些经验：
https://github.com/feiyangqingyun/qtkaifajingyan


0719：
看发过来的CAN协议，首先要MCU把所需数据ID发给我们，开始字节数是（0-7）如果看到的stat bit超过8，说明已经转换好了，不用*8，
根据定位好的起始位和信号长度，确定哪些数值代表什么

0725：
dqa测试时夹具上的大灯无作用，电源转接线有问题


0729:
+#define        AA_CALLIDLE_TO_HOME_IN_TURER_OR_AUXIN   1       //如果在radio或auxin结束AA通话，则退出到主界面
+#define SUPPORT_FIAT_FAST_GUIDE 1                      //支持现代的说明书
Reversing camera
Reversing volume
Reverse the  camera
在setupview.cpp里面缺少项目宏导致(为什么缺少宏原因就是当时的宏前面有空格，导致替换时没搜到)
void SetupWidget::_setupShowHideItemFunc(void *obj, T_ID event, TTable *in, void *arg, TExist *exist)

7. AV-1297W-65RA-HX需要添加说明书
2267W修复西班牙语没插入usb弹出框
"    Actualmente ningún dispostivo está conectado "
点击面板没提示：某个UI宏里面没放逻辑
void BaseControl::handleMcuKey(int key, int val)
                 else
                 {
 #if defined(UI_RGBLUE_1024_600) || defined(UI_RGBLUE_ORANGE_1024_600) || defined(UI_RGBLUE_BLACK_1024_600) || defined(UI_RGBLUE_SUZUKI_1024_600)  || \
-        defined(AV_1297W_65RA)||defined(AV_1297W_65RA_HW)||defined(AV_1297W_65RA_HX)||defined(AV_1307W_65RA_HW) || defined(AV_2227W_92) || defined(AV_1307LW_65BQ_HW)||defined(AV_1307WSC_65BA_HX)||defined(AV_1297WSC_65X3_HW)
+        defined(AV_1297W_65RA)||defined(AV_1297W_65RA_HW)||defined(AV_1307W_65RA_HW) || defined(AV_2227W_92) || defined(AV_1307LW_65BQ_HW)||defined(AV_1307WSC_65BA_HX)||defined(AV_1297WSC_65X3_HW)
         #if defined(AV_R117W_58)
                 if(val == 0)
                     showSearchDeviceDialog(TwTrans("tr_searchDeviceHint"), 15000);

0803:
TD的ini文件，   caption="0"是指文本翻译为“0”的属性
equi的数字显示不全，且不居中
  eq_bar_value_6={
         type="button"
-        x=533
-        y=-9
+        x=534
+        y=-5
+        y=-5
         w=50
         h=50
         caption="0"

0804:
TD平台的cp,aa未连接时提示语或者图标置灰
在void HomeView::setEntryButtonStyle()
这个函数里面加UI宏
改2227W和2267W音量图标
改2227W和2267W翻译
"tr_NoDeviceConnected"="  Actualmente   ningún   dispostivo   está   conectado"

VOLUME_HINT_SHOW_DIFFERENT_ICON
关于修改频宽：
QT：
附件（networkmanager.7z）是频宽改成40M的bin档，请替换linux/sdk/out/appsdkfs/bin和linux/sdk/out/system/bin路径下对应文件；

         同时请将 linux/sdk/wifi/drivers/script/rtl8821cs/card0/WiFiDriver.sh 和 linux/sdk/wifi/drivers/script/rtl8821cs/card1/WiFiDriver.sh 中的rtw_vht_enable=2注释；

         softap.conf文件上也修改为ht_capab=[SHORT-GI-40][HT40+]

 

         WifiControlPrivate::initWifiAPconfig修改cfg.channel = xxx；softap.conf文件上也同步修改为相同的值，车机上电后查看softap.conf文件，channel值改变则表示修改到了

 

         “如果频宽改成40M的话信道是对应附件里frequency.png的40M+还是40M-的”

         -->选择40M+
TD：
修改国家码：
注:每个国家的国家码可从网上得到:
https://www.chinassl.net/country_code/
以哥斯达黎加为例,国家码为CR
根据ASCII码表得到16进制为: 0x43 0x52
0xFF,0XFF为默认的国家码,为中国
修改步骤:
1.获取需要修改的国家码;
2.获取国家码对应的16进制数;
3.找到linux/sdk/wifi/drivers/rtl8821cs/os_dep/linux/os_intfs.c文件内
char rtw_country_unspecified[] = {0xFF, 0xFF, 0x00}; 
行;
4.将其修改为对应的国家码16进制数,如:
char rtw_country_unspecified[] = {0x43, 0x52, 0x00}; 

5.重编软件,升级后查看打印
6.输入cat /proc/net/rtl8821cs/wlan0/country_code 命令可查看是否修改成功,修改成功返回:如:"CR", 0x34 ac,未修改过的返回为:unspecified.

修改频宽：
现已通过bash脚本检索项目头文件宏 来控制wifi频宽配置的相关文件，

#define Z_WIFI_MHZ 40

宏可以设置20/40  会设置20MHz和40MHz,宏设了其他值或者没有该宏会恢复成80MHz，

本地自测可以正常设置20/40/80MHz，暂不清楚其他电脑上是否会有权限问题，

具体实现可以看TD平台commit 098d1d51b9288a43a9c6a0e1654977e55045aaa3 或查看./ecos/auto_replace_wifi_MHz.sh


需要设置频宽的项目可以在头文件添加该宏#define Z_WIFI_MHZ  20/40 编译完建议wifi助手检查一遍 欢迎优化和反馈。

修改与查阅信道：
通过宏控制
这里有华为统计的世界各国支持的信道。
svn://192.168.10.9/软件研发中心/资料库/模块资料/WiFi/Wi-Fi资料/WLAN Country Codes and Channels Compliance.xlsx
通过wifi助手查阅

1435
xu
ubootMCU
屏蔽system reset和MT3360 reset引脚

0807:

来电时，加减音量，图标显示为媒体音频图标，不是通话音频图标(AA显示的是通话音频图标）
异常：07_icon_volume.png
正常：07_icon_phone.png
在volumeview.cpp
void ComVolumeWidget::updateVolIcon(string volId)
bt来电:S+BtRingtone_APP
AA来电:S+BtPhone_APP
cp来电:AUDIO_SOURCE_CP_ALERT S+CarPlayAlert_APP

0809:
倒车无信号提示:TwShow(s_pReverseView->reverser_noSignal_win


0815：
shared_ptr使用的注意事项:
1.不能使用一个原始地址初始化多个共享智能指针
2.函数不能返回管理了this的共享智能指针对象
3.共享智能指针不能循环引用

0816：
阻塞调用 当前窗口处理结束关闭之后 主窗口才能操作
非阻塞调用 当前窗口的执行状态不影响主窗口的操作

0817:

updatePanelBrightnesslightDefault
TwUpdateShow();


0821：
程序卡死可能有多种原因，其中访问非法内存地址只是其中之一。以下是一些常见的导致程序卡死的原因：

    死循环：如果程序中存在无限循环或条件不满足时无法跳出的循环，程序可能会陷入死循环状态，导致卡死。

    资源竞争：当多个线程或进程同时竞争同一个资源（如共享内存、锁等）时，可能会发生死锁或活锁现象，导致程序无法继续执行。

    阻塞IO操作：如果程序在执行阻塞式的输入/输出操作（如读取文件、网络通信等）时，如果IO操作长时间未完成或出现异常，可能会导致程序卡死。

    递归调用错误：如果程序中存在错误的递归调用，没有正确的终止条件或递归深度过大，可能会导致栈溢出或无限递归，使程序卡死。

    内存泄漏：如果程序中存在内存泄漏问题，即分配的内存没有被正确释放，随着时间的推移，可用内存逐渐减少，最终导致程序无法继续执行。

    硬件故障：在某些情况下，程序卡死可能是由于硬件故障引起的，如硬盘故障、内存错误等。

    多线程同步问题：如果程序中存在多个线程，并且没有正确地进行同步和互斥操作，可能会导致竞态条件或数据一致性问题，进而导致程序卡死。
当面临卡死问题时，以下是一些常见的操作步骤和方法，可以帮助您定位问题：

    使用调试器：
        在开发环境中打开调试器，并将程序加载到调试器中。
        设置断点：在怀疑问题出现的代码位置设置断点，以便在程序执行到该位置时暂停。
        逐步执行：使用调试器的单步执行功能，逐行或逐语句地执行代码，观察每一步的结果和状态变化。
        观察变量值：查看和监控关键变量的值，以确定是否符合预期。
        检查堆栈：检查函数调用堆栈，确认程序执行路径是否正确。

    日志输出：
        在代码中插入适当的日志语句，记录程序执行过程中的关键信息，如函数进入/退出、变量值等。
        根据日志输出来分析程序执行流程，查找异常或不符合预期的情况。
        可以使用不同级别的日志，以便在需要时进行详细的调试。

    代码审查：
        仔细检查相关代码，特别是与卡死问题相关的部分。
        查找潜在的逻辑错误、资源泄漏、竞态条件等。
        确保多线程代码正确地进行同步和互斥操作。

    分析内存使用：
        使用内存分析工具，检查内存分配和释放的情况。
        查找潜在的内存泄漏或过多的内存消耗。

    进行单元测试：
        编写单元测试用例，覆盖可能存在问题的代码路径。
        执行单元测试，并观察测试结果是否符合预期。
        单元测试可以帮助发现一些隐藏的问题，提高代码质量。

0822：
   sed -i -e 's/UART_OUTPUT=.*/UART_OUTPUT=y/g' linux/sdk/out/system/etc/log_service/log_default.cfg	
这是一个使用sed命令修改文件中某个文本模式的操作。

具体解释如下：

sed是一个流编辑器，用于对文本进行编辑和转换。
-i选项表示直接修改文件，而不是输出到标准输出。
-e选项表示后面接着的是一条编辑命令。
's/UART_OUTPUT=.*/UART_OUTPUT=y/g'是编辑命令的具体内容，用来将文件中以UART_OUTPUT=开头的行的值替换为UART_OUTPUT=y。
s表示替换(substitute)，后面是匹配模式和替换模式。
UART_OUTPUT=.*是匹配模式，表示以UART_OUTPUT=开头的行，后面可以是任意字符。
UART_OUTPUT=y是替换模式，表示将匹配到的行替换为UART_OUTPUT=y。
g是全局替换标志，表示对每一行中匹配到的内容都进行替换。

最终，该命令会修改log_default.cfg文件中以UART_OUTPUT=开头的行的值为UART_OUTPUT=y。

0826:
TD平台不想要AUXIN功能可以暴力的把.ini文件删掉关于auxin的控件，同时要注意把后面控件的坐标改一下顶替上来（不要用hide,用方控还是会选出来），另外在homeview.cpp的connectViewEventHandler可以试试加宏NO_NEED_AUXIN

0829：
关于CAN协议功能：

根据提供的协议，AM-688智能门锁协议是通过串口以16进制格式发送指令的。串口通信的默认设置如下：

波特率（Baud Rate）：38400
数据位（Data Bits）：8
停止位（Stop Bits）：1
校验位（Parity）：None

发送消息的基本格式为：8位长度，前2位表示消息的开始，接下来的4位表示消息代码，最后2位表示消息的结束。

回复消息的基本格式为：4位长度，第1位表示消息的开始，第2-3位表示接收到的命令，最后1位表示消息的结束。

不是所有发送的指令都需要接收到响应。下面是系统设置的不同指令及其功能的详细说明：

表示车辆锁定或解锁状态的指令，由AM-688模块发送的命令，该选项允许在车辆锁定时将收音机打开，并在车辆锁定时关闭。睡眠模式的默认时间应为7秒。

解锁车辆：| 23 | 20 | 03 | ST | 01 | DB | AA | FF |
ST：睡眠时间，表示ACC=OFF时收音机等待关闭的时间，睡眠模式的取值为3（7秒）、1E（30秒）和3C（60秒）。
07：睡眠模式7秒。
1E：睡眠模式30秒。
3C：睡眠模式60秒。
示例：表示30秒的睡眠模式时间：| 23 | 20 | 03 | 1E | 01 | DB | AA | FF |

收音机回应：| AB | 1E | 00 | FF |

锁定车辆：| 23 | 20 | 03 | 02 | 02 | DC | AA | FF |

收音机回应：| AB | 02 | 00 | FF |

该命令指示收音机应立即关闭。

允许或禁止门关闭功能的访问，由AM-688模块发送的命令：

允许访问该功能：| 23 | 20 | 03 | 04 | 04 | 01 | AA | FF |

收音机回应：| AB | 04 | 00 | FF |

在收音机上显示消息框：Para programar esta función, el vehículo debe estar apagado.（要设置此功能，车辆必须处于关闭状态。）

| 23 | 20 | 03 | 03 | 03 | 00 | AA | FF |

收音机回应：| AB | 03 | 00 | FF |

以上是根据提供的协议对AM-688智能门锁协议进行的解读。


0830:
无线AA断连之后缺乏判断，导致方控还处于AA那种模式跳过bt-audio（有线和CP都可以）
DeviceListview::signalSlotsDisconnect()
代码差不多，应该不是这里
caplaymoduleimpl.cpp里面：
void DisconnectCurrentWirelessCPDevice(unsigned long long int macid);
deleteCarePlayDevice
androidautomoduleimpl.cpp里面：
changeAADeviceConnectState
后续结果是在homeview.cpp里面的checkBtDevice(int index)
思路：先在homeview.cpp找到homeBtnList找到pushBackHomeBtn，focusCurrentSrc，switchActiveDevice，checkCurrentDeviceActive（找到关键词checkBtDevice），找到对应判断，修改判断状态

0901:
创建新样机
cat filepath.txt | while read line;do git add -Af $line; done


0905:
TD收音机刻度尺问题其实是更换图片


0906：
关于Linux快照：
https://blog.csdn.net/guyongqiangx/article/details/128494795

0911:
关于TD翻译，在app/config/对应项目改变量，如果没有则添加
关于QT翻译，改动是通过修改ts，找到安装qt文件夹里面的语言家，发布qm文件，修改后需要全部编译才会生效，不能单独编译app因为没有效果，关于ts，先找到原来英文的语句，在vscode里面搜一下.cpp文件，一般会在具体区域show出来，其实是对应的ui控件view或者form文件里面的区域翻译对应的地方


0913:
find -iname +文件名（找路径）
打开具体位置：nautilus /home/chenshihao/8368-XUCarSDK/application/reference_ui2/spLauncher/commons/comviews


0915:
搜索某种文件的关键词
： 1. find ./  -type f -name "*.cpp" -o -name "*.h"  | xargs grep -n --color "MSG_RECEIVE_KEYS" > grep_111.txt，这样不行
2.find ./  -type f -name "*.cpp" -o -name "*.h"  | xargs grep -n --color=always "Recevied" |  aha --black --title 'ls-with-colors' > ls-with-colors.html
3. find ./ -type f -name "*.cpp" -o -name "*.h" | xargs grep -n --color=always "switchBar"在当前目录底下搜索有关这个的.cpp和.h
0919:
dabview.cpp:
#elif  defined(UI_NEW_TUCSON_1024_600)
    m_PageSwitch->setGeometry(25, 472, 1024, 64);

1008:
卸载文件系统：
来查看哪些进程正使用特定的文件系统：
sudo lsof +f -- /mnt
停止使用文件系统的进程

一旦你确定了哪些进程在使用该文件系统，你就可以尝试停止它们。有些进程可能会在后台运行，你需要先使用kill命令将它们终止：

sudo kill -9 1234

如果进程仍然无法终止，你可以尝试使用fuser命令，它可以让系统为你查找出使用该文件系统的进程并将这些进程终止：

sudo fuser -km /mnt

以上命令将会终止所有使用/mnt目录下文件系统的进程。在这之后，你就可以试图再次卸载文件系统了。
https://cloud.tencent.com/developer/article/2328088#:~:text=%E5%9C%A8%E8%A7%A3%E5%86%B3%E6%97%A0%E6%B3%95%E5%8D%B8%E8%BD%BD%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F%E7%9A%84%E9%97%AE%E9%A2%98%E4%B9%8B%E5%89%8D%EF%BC%8C%E6%88%91%E4%BB%AC%E9%A6%96%E5%85%88%E9%9C%80%E8%A6%81%E4%BA%86%E8%A7%A3%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F%E7%9A%84%E7%8A%B6%E6%80%81%E3%80%82%20%E5%BD%93%E4%B8%80%E4%B8%AA%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F%E8%A2%AB%E6%89%93%E5%BC%80%E5%B9%B6%E6%AD%A3%E5%9C%A8%E4%BD%BF%E7%94%A8%E7%9A%84%E6%97%B6%E5%80%99%EF%BC%8C%E5%AE%83%E8%A2%AB%E6%A0%87%E8%AE%B0%E4%B8%BA%E2%80%9C%E7%B9%81%E5%BF%99%E2%80%9D%E7%9A%84%E7%8A%B6%E6%80%81%EF%BC%8C%E8%BF%99%E6%84%8F%E5%91%B3%E7%9D%80%E5%AE%83%E4%B8%8D%E8%83%BD%E8%A2%AB%E5%8D%B8%E8%BD%BD%E3%80%82%20%E5%A6%82%E6%9E%9C%E4%BD%A0%E8%AF%95%E5%9B%BE%E5%8D%B8%E8%BD%BD%E4%B8%80%E4%B8%AA%E7%B9%81%E5%BF%99%E7%9A%84%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F%EF%BC%8C%E4%BD%A0%E4%BC%9A%E5%BE%97%E5%88%B0%E4%B8%80%E4%B8%AA%E9%94%99%E8%AF%AF%E6%8F%90%E7%A4%BA%EF%BC%9A%20umount%3A,%2Fmnt%3A%20target%20is%20busy.
无法在双系统下正常挂载Windows文件夹
https://zhidao.baidu.com/question/1903494029219728140.html#:~:text=%E4%BE%9D%E6%AC%A1%E7%82%B9%E5%87%BB%E2%80%9C%E6%A3%80%E6%9F%A5%20%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F,%E2%80%9D%E5%92%8C%E2%80%9C%E4%BF%AE%E5%A4%8D%E6%96%87%E4%BB%B6%E7%B3%BB%E7%BB%9F%E2%80%9D%EF%BC%8C%E5%86%8D%E4%BB%8E%E6%96%87%E4%BB%B6%E4%B8%AD%E7%82%B9%E5%87%BB%E6%9C%AA%E6%8C%82%E8%BD%BD%E7%9A%84%E7%9B%98%E7%AC%A6%E8%87%AA%E5%8A%A8%E9%87%8D%E6%96%B0%E6%8C%82%E8%BD%BD%E3%80%82%20%E8%BF%9B%E5%85%A5%E4%BF%AE%E5%A4%8D%E5%90%8E%E7%9A%84%E6%9C%BA%E6%A2%B0%E7%A1%AC%E7%9B%98%E5%86%85%E7%9A%84%E2%80%9C%E6%96%87%E6%A1%A3%EF%BC%88%E5%88%86%E5%8C%BA6%EF%BC%89%E2%80%9D%EF%BC%8C%E5%B7%B2%E7%BB%8F%E9%87%8D%E6%96%B0%E5%8F%AF%E4%BB%A5%E6%AD%A3%E5%B8%B8%E4%BD%BF%E7%94%A8%E4%BA%86%E3%80%82

如果想要去除图标
qt项目：
1.可以把某个坐标拉到很远（拉到显示屏幕外）
2.直接删掉该控件
3.把该控件的高度宽度全都设为0（最安全，不会影响别的地方编译，有些直接去掉会报错）
TD项目：
把ini里面的控件删掉

1009:
n015usb视频切换到后台，进入设置点击切换语言会卡死
音频不会，AUXIN也不会
6255也不会
头文件和UI有差异，
检查了UIID，基本没有发现可疑的没翻译
现在正对fileview的pri更换成6255的看看，换完之后没有问题
对具体UI进行排除
l
最后排查到videomenu.ui有两个控件导致卡死，直接在qt里面点击取消翻译都会卡死，导致app到车机都会卡死




1010：
git log --author=suyq可以查看某个人的上传记录（例如suyq）


1019：
harman机器连接AA卡死（有线和无线都会），首先6255的机器的没有问题，确定是UI问题（排除头文件，appconfig等差异）把6255里面的ui都拷贝到外层来，排除的时候首先直接搜索该套UI，具体在哪些位置（问题有可能出现在这些地方），
在可疑pri的位置首先直接去除原有ui，走正常UI（一旦pri里面不走该套UI，代码里面也会走的正常UI的UI宏，会自动走加了UI宏的地方，所以UI控件问题特别容易编译报错），一旦不出现问题，可以锁定大体位置，想要更精准地地位出问题的UI，先用对比工具对比两套UI不同的地方，pri里面可以采用可疑位置和二分法结合，用正常UI替换走具体的UI，找到具体UI，对比多几套正常UI，看看是否有不一样的控件，有时候是缺少或者多了某些控件导致卡死。归根结底就是对该UI所走的流程出了差错

flash制作的时候不要改动设置项，会导致软件变动（比如别的语言改了默认英语，后面做的flash也会跟着改动，导致跟原先默认软件不一致）


1103:
快速打开某一路径的文件：nautilus application/reference_td2/tdLauncher/middleware/plugins/module/canmodule/


1106：
MCU转发can消息给app可以打断点去看里面的Buffer看看数据是不是一致的

1113:
关于空调手动退出，1.可以看一下手动关闭页面，定时器里面的槽有没有跑到，如果没跑到是不是多个页面导致，如果跑到看看为什么不生效 2.可以把顶栏隐藏掉，如果上面空一截，可以把整个ui界面往上提

VScode :ctrl+alt+"-"返回上一个操作

can的接收数据流动(air为例)：CAN_INFO_RX_AIR_INFO->CanImplNewDataSlot->UpdateCanInfoSig/OpenCanScreenSig（这个是展示一个页面）->UpdateCanInfoSlot->CanModuleNewDataSig->CanViewNewDataSlot

can的发出数据流动：CAN_INFO_RX_BASIC_INFO->CanImplNewDataSlot->canInfoUpdateSig->canInfoUpdateSlot(自己可以改写或者新增这个槽，这个槽已经定义了传进去的参数是0,1,2那种)


QT的常用快捷键：
QT:
    Ctrl+K: 快速搜索文件
    Ctrl+Tab: 在打开的文件之间进行切换
    Ctrl+Page Up: 切换到上一个打开的文件
    Ctrl+Page Down: 切换到下一个打开的文件
    Ctrl+K, Ctrl+O: 打开文件所在的目录
    Ctrl+K, Ctrl+P: 切换到上一个编辑过的文件
    F4: 定位到当前文件中选中的类或函数的定义
    F2: 定位到下一个错误或警告
    F12: 跳转到光标所在的函数或变量的定义
    Ctrl+F2: 在文件中查找当前选中的函数或变量的所有引用
    Ctrl+Shift+T: 在当前文件中切换 .h 和 .cpp 文件

VScode:
    Ctrl+Tab: 在打开的文件之间进行切换
    Ctrl+P: 快速打开文件
    Ctrl+P, @: 快速切换到符号（函数、变量等）定义的地方
    Ctrl+P, #: 快速切换到最近编辑的文件
    Ctrl+B: 打开/关闭侧边栏
    Ctrl+Shift+: 跳转到匹配的括号或标签
    F12: 跳转到定义
    Ctrl+Shift+O: 跳转到文件中的符号（函数、变量等）
    Ctrl+K, Ctrl+R: 在文件和资源管理器中显示当前文件
    Alt+Left/Right: 切换编辑历史记录
    Ctrl+K, Z: 进入 Zen 模式（全屏编辑）

1121:
一般这种缺少ui.h的报错，很大概率是pri里面走的逻辑有误

注意中英文差别：
℃（英文）
°C


1122:
gnu改变图片注意是要导出而不是保存
里面可以从图像去旋转和改变像素大小

1125:
TD:git apply
git apply - < <patchfile>
使用 - 参数可以从标准输入读取补丁文件。
1.应用补丁文件到当前工作目录：

git <patchfile>

增加config里面etc底下的一个文件log_default.cfg
增加的环境变量地址不对，要取车机地址：“/usr/local/etc/log_default.cfg”;
此时log会存储在默认路径：media/flash/nvm/log_service/currend/log.txt；
敲命令要在根目录敲
logset SHOW
logset COPY /mnt/sda1

串口通信：
睿志诚力度调节搞反了,后视镜折叠，力度，回家时间，can时间，空调调节（全部失效）
空调左右温度搞反了且多加了15度，而且无法调节，on，ac等有时候没作用，
风向有误，平行吹风变为下吹风，平行下吹风变成平行吹风，下变平下，前变前下
后视镜折叠，力度，回家时间，can时间，空调手动调节（全部失效）
后视镜折叠，力度，回家时间:0xC6
can时间：0xA6
空调手动调节：0xC7
目前已解决

1221:
uart 0 linux打印口
uart 1 MCU通讯口
uart 2 蓝牙模块通讯口
uart 3 GPS通讯口 （有时没有GNCSS功能，可改）
uart 4 GPS通讯口  （XU的ecos打印口）
api:
work:
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

1226：
8368P平台截图命令

    机器插入U盘的情况下，先执行ls /media 查看U盘的路径， 比如U盘路径是 /media/sda1

    则在串口执行

    screenshot -o /media/sda1

    就会在U盘生成 osd_fb-开头的截图文件。

  大家看看各种负责的项目在MaxmadeDevelop2.0分支上能否正常编译运行，如果不行，那可能需要重新执行

    make menuconfig对项目进行配置。（config底下的defconfig）

    md5sum filename 可以看和对比文件的MD5校验和

路由器相当于用户程序，插座相当于操作系统，墙相当于硬件，里面的电线相当于bootloader，裸机程序不用运行在操作系统但是类似main函数一样的运行入口，cpu系统会从这里开始运行第一段程序（bootloader是其中一种裸机程序），不同的cpu体系芯片会有不同的bootloader,想要运行在一块板子的程序移到另外一块板子，要修改bootloader程序（类似修改config）。bootloader的存在就是为了让操作系统启动，并且传递一些必要参数给操作系统的内核，等待内核完全掌握内存，bootloader像彻底死去了
bootloader（1）需要初始化硬件设备，比如EMMC，DDR，时钟，内核本质也是一段程序，需要硬件进行初始化
（2）建立内存空间的映射，程序是运行在内存上，这样内核才有“工作台”
（3）创建内核的需要某些信息，并且将信息通过相关的机制传递给内核（内核起来之后要做根文件系统等镜像，镜像烧录进去之后需要所在地址传递过来）
Uboot目录架结构：
api：Uboot的接口函数
arch：不同处理器架构的相关代码，对应了不同的初始化（某个选择而已）
board:为开发板定制的相关代码，支持板级差异
common：通用代码，大部分与uboot的命令行有关
disk：磁盘分区相关
doc：有readme.txt和一些开发板指南的文档
driver：驱动相关 一般保证赶紧开机，很少动，uboot增加太多功能影响开机时间，某些api里面接口基于这个目录的驱动去完成
examples:示例程序，接口怎么用看这个地方
fs：文件系统
lib：通用库
net:网络相关代码
post：上电自检程序，uboot的医生
tools：配套的编译器，连接器，检查器

0103:
连接串口通信的时候，需要检查连接线（tx绿色要接白色，rx白色要接绿色，要与机器连接相反才能到达收和发的效果），然后还要用固定的波特率
用cutecom发送时要注意发送的时候是按16进制去发（HEX）还是字符串（cr/rl）格式

0104:
8368P需要重新配置defconfig的时候（新分支编译失败，需要用sudo make menuconfig  改变设置保存到deconfig (make list不知道是干嘛的)）

 线程的优缺点？

线程的优点：

    一个进程中可以同时存在多个线程；
    各个线程之间可以并发执行；
    各个线程之间可以共享地址空间和文件等资源；

线程的缺点：

    当进程中的一个线程崩溃时，会导致其所属进程的所有线程崩溃（这里是针对 C/C++ 语言，Java语言中的线程奔溃不会造成进程崩溃，具体分析原因可以看这篇：线程崩溃了，进程也会崩溃吗？

举个例子，对于游戏的用户设计，则不应该使用多线程的方式，否则一个用户挂了，会影响其他同个进程的线程。

进程拥有一个完整的资源平台，而线程只独享必不可少的资源，如寄存器和栈；

0110:
1307wsc-65,动态倒车轨迹
d089-55,2.0分支新编译


0111:
可以从basecontrol.cpp去找

0112：
https://v2raya.org/en/docs/prologue/installation/debian/
https://github.com/233boy/v2ray/wiki/V2Ray%E6%90%AD%E5%BB%BA%E8%AF%A6%E7%BB%86%E5%9B%BE%E6%96%87%E6%95%99%E7%A8%8B
Method 2: Manually install the deb package

After downloading the deb package

, you can use graphical tools such as Gdebi, QApt to install, or you can use the command line:

sudo apt install /path/download/installer_debian_xxx_vxxx.deb ### Replace the actual path where the deb package is located by yourself

V2Ray and Xray debian packages can be found in APT Repo
Start v2rayA / Enable v2rayA start automatically

    From the 1.5 version, it will no longer default start v2rayA and set auto-start.

    Start v2rayA

sudo systemctl start v2raya.service

Set auto-start

    sudo systemctl enable v2raya.service

Use nftables

If you already have nftables firewall on your system, then v2rayA will use nft command first to create firewall rules. You can use the --nftables-support parameter or V2RAYA_NFTABLES_SUPPORT to control whether to enable nftables support.

程序段错误，指针指向未初始化的变量（非法访问地址）
以下是一些可能导致分段错误的原因和解决方法：

    空指针解引用： 在 C++ 中，对空指针进行解引用是导致分段错误的常见原因。在 SpIconButton::setDisplayText 中，确保没有对空指针进行解引用。

    内存越界： 确保你没有访问数组、指针或其他数据结构之外的内存。

    释放后继续使用： 确保没有在已经释放的内存上继续进行操作。

    多线程问题： 如果你的程序使用了多线程，确保在访问共享数据时进行适当的同步。

0118:
TD:gotoCurrentNormalSource->getLastSource()
TD的隐藏选项如果没show处理来，主要是因为_setupShowHideItemFunc这个函数没有正确的去show出来
与MCU有关的收发信息，大部分都是要到basecontrol里面去处理，可以在其他部分把关键数据截取存储下来转发到basecontrol进行判断

0123:
切换通道：DEFAULT_VIDEO_IN_CHANNEL	Auxin::VideoChannel1   	
mAuxinModule->setAVInMode(Auxin::AVIn, DEFAULT_AUDIO_IN_CHANNEL, DEFAULT_VIDEO_IN_CHANNEL);
AuxinModule::setAVInMode
switch(mode)
		{
			case AuxinModule::AVIn:
				mImpl->setAudioChannel(AudioInChannel,true);//mImpl->setAudioChannel(mImpl->curAudioInChannel,true);
				mImpl->setVideoChannel(VideoInChannel,true);//mImpl->setVideoChannel(mImpl->curVideoInChannel,true);
				break;
			case AuxinModule::CameraIn:
				mImpl->setVideoChannel(AuxinModule::VideoChannel0,true);
				break;
			case AuxinModule::ParkIn:
				mImpl->setVideoChannel(AuxinModule::VideoChannel0,true);
				break;
			default:
				break;
        }
int AuxinModuleImpl::setVideoChannel(AuxinModule::VideoChannel channel, bool force)


0124:
vscode :缩放crtl+tab+"+/-"变大或缩小

P079:二级菜单
Y039
D089：avm
N015：制作翻译，canbus，静态倒车线，删除部分设置选项，卡死

GDB调试

0129:
跟切源判断有关的函数
void HomeView::srcItemSelected(const QString &modeName)


0130:
1465机器没声音，通道换了，在/8368-XUCarSDK/application/tools/runtime_cfg_generator/pmGROUP的5_xu_demo改为
pmAUD_EXT_DAC_IFX0=3
pmAUD_EXT_DAC_IFX1=3
pmAUD_EXT_DAC_IFX2=3



    运行 lupdate 工具：Qt 提供了一个名为 lupdate 的工具，它用于从 Qt 项目中提取标记的文本，并生成 TS 文件。您可以通过命令行或 Qt Creator 的界面来运行它。在命令行中，可以执行以下命令：
qt的翻译：
lupdate your_project.pro

这将会根据项目文件 your_project.pro 中的配置生成 TS 文件。

    编辑 TS 文件：生成的 TS 文件包含了需要翻译的文本以及其上下文信息。您可以使用 Qt Linguist 工具来打开 TS 文件，进行翻译并保存。Qt Linguist 是一个用于本地化的可视化工具，您可以使用它来编辑 TS 文件并添加不同语言的翻译。

    生成二进制翻译文件：一旦您完成了翻译工作，您需要使用 lrelease 工具来生成二进制的翻译文件（QM 文件）。执行以下命令：

lrelease your_project.pro

这将根据项目文件 your_project.pro 中的配置生成 QM 文件，其中包含了翻译后的文本。

    在应用程序中加载翻译文件：最后，在您的 Qt 应用程序中加载生成的 QM 文件，以便在运行时切换不同的语言。可以使用 QTranslator 类来实现这一点。例如：

QTranslator translator;
translator.load("translations/myapp_en.qm"); // 加载英文翻译文件
qApp->installTranslator(&translator); // 安装翻译器


0201:
点击发送后，再点串口发送会不行

0204：
更改某些不生效的翻译，首先在代码定位翻译位置
然后看所处函数属于哪个类里面，把类名加一个新context的到ts，改qm文件，
如果用了QObject::tr，直接放QObject里面
makefile：
#grep "^[^#].*" ui.cfg //获取所有不以 # 开头的非注释行。^[^#].* 是一个正则表达式，表示以除了 # 之外的任何字符开头的行。sed "s/_/-/g"：这个部分使用 sed 命令，将每一行中的下划线 _ 替换为连字符 -。这里的 s/_/-/g 是一个替换操作，其中 s 表示替换，_ 是要被替换的字符，- 是替换后的字符，而 g 表示全局替换。sed "s/:.*//"：这个部分使用 sed 命令，将每一行中冒号 : 后面的内容删除，保留冒号之前的部分。这样做的目的是截取配置行的关键信息。
name=$(grep "^[^#].*" ui.cfg| sed  "s/_/-/g"| sed  "s/:.*//") 
wifiMHz=$(grep "^[^/][^/].*Z_WIFI_MHZ" application/include/$name.h | sed 's/.*Z_WIFI_MHZ\s*\([0-9]\+\).*/\1/')
//这个部分使用 grep 命令从名为 $name.h 的文件中获取匹配正则表达式 "^[^/][^/].*Z_WIFI_MHZ" 的行。这个正则表达式的意思是匹配以两个非斜杠字符开头，然后包含字符串 "Z_WIFI_MHZ" 的行。使用 sed 命令，从匹配到的行中提取与正则表达式 "Z_WIFI_MHZ" 后面的数字:
    .*Z_WIFI_MHZ：匹配任意字符，后跟 "Z_WIFI_MHZ"。
    \s*：匹配零个或多个空白字符。
    \([0-9]\+\)：使用圆括号捕获一个或多个数字。
    .*：匹配剩余的任意字符。
    \1：替换为之前捕获的数字。


0205：
调试的几种方法：
Core Dump：程序的“犯罪现场”
在Linux、Windows或Mac系统中，当程序异常终止时，操作系统会生成一份内存快照，即core dump。它记录了程序崩溃时的详细状态，就像留下了犯罪现场的线索。

高效调试的首步：日志与GDB
一般情况下，我们首先检查程序日志。如果日志无法提供有效信息，那么就需要借助GNU调试器（GDB）来加载core dump，查找程序崩溃的具体位置。这对于新手程序员而言，通常是寻找bug的“终点”。

迈向深度调试：Google Address Sanitizer (GAS)
然而，C/C++程序中常见的内存破坏类错误并非总是能通过GDB轻易定位。这时，Google Address Sanitizer（GAS）成为了一个强大的工具。它像在程序中安装了监控摄像头，帮助我们捕捉到内存破坏的瞬间，极大地简化了调试过程。

全面解析：Core Analyzer
当GDB和GAS无法完全解决问题时，Core Analyzer这款开源工具展现了其独特优势。它能遍历整个内存，识别出内存破坏的具体位置，甚至能够追踪多线程共享变量的问题，为深入调试提供了强大的支持。


0218:
1295WS-65HS的项目移植
主界面，设置

0220:
UI里面有这个控件，但没初始化，会访问到野指针卡死
UI里面有这个控件但调用了没有的某些函数，会直接编译报错

可以从appdata（.h或者.cpp）开始看，寻找有关的关键词(函数或者接口，变量)

0221：
F11 全屏，f5刷新

ctrl+alt+- vcs返回上一个步骤

0223:
* class: AVMModulePlugin
 * AVMModule的管理类，其它地方需要通过它才能，获取到AVMModule实例
 * class: AVMModuleImpl
 * AVMModule的具体实现类，这里做一下显示、声音资源的控制
 * class: AVMScreenTransferProgramCbk      
 * Resource Management
 * 其它源需要占用音频、显示资源时，比如倒车、拨打电话等，在这里做资源的切换。





















# 需求
展望：
*  学会makefile，编写新项目的快速脚本
*   烧录flash的快速脚本
*   读懂各种与can，dab模块通信的协议，如何处理mcu发过来的数据
*   物联网，处理语音（信号与解调）
*  与车载行业有关的can诊断通讯（uds），中控驱动屏幕，与电机有关的无刷电机（FOC算法）
* 搞一个与后续有关的合订本APP，

一、需求转换或者叫理解需求；

二、分配时间；

三、开发质量的问题；







1. pcQT完全重装（注册表），解决QT打包dll污染问题 
（该问题已经通过拷贝王云杰电脑的qt5.99成功解决了）
2. -65生产软件对策
1297w，1307W（两个加了宏，需要重新编译，但是其实速度已经是10s左右了，不算卡，实际不知道是否需要；2267W要重新编译，去了过滤事件的宏，对策acc起来识别不了大灯的情况）
3. Y-39-55完善CMMI文档
（接口那个文档暂时还没写）
4. 接过振昊空调CAN协议的的任务

5. 广汽项目的CAN模拟器(可以模仿前人脚步)

6. 缺少隐藏选项开关（ui宏前面不要带空格，脚本无法搜索替换，导致遗留部分流程代码）
7. 更换频宽和国家码
8. CPPCHECK和GOOGLE TEST框架结合起来自动测试单元测试：
你可以结合CPPcheck和单元测试框架来进行C++代码的自动化单元测试和静态代码分析。下面是一个示例的C++代码自动化单元测试脚本，其中包括对代码的静态分析：


#include <gtest/gtest.h>
#include <cppcheck/cppcheck.h>

TEST(MyTest, AdditionTest) {
    int result = 2 + 2;
    EXPECT_EQ(result, 4);
}

TEST(MyTest, SubtractionTest) {
    int result = 5 - 3;
    EXPECT_EQ(result, 2);
}

TEST(MyTest, StaticAnalysis) {
    const char* cppFiles[] = {"file1.cpp", "file2.cpp"};

    for (const char* file : cppFiles) {
        std::string errorMessage;
        if (!CppCheck::check(file, errorMessage)) {
            FAIL() << "Static analysis failed for file: " << file << "
"
                   << errorMessage;
        }
    }
}

int main(int argc, char** argv) {
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}

在上述示例中，我们在MyTest测试套件中增加了一个测试用例StaticAnalysis，用于进行静态代码分析。在该测试用例中，我们遍历了需要进行静态分析的C++源文件，然后使用CPPcheck进行静态分析。

在StaticAnalysis测试用例中，如果CPPcheck检测到错误，我们使用FAIL()宏来标记测试失败，并输出错误信息。这样，如果代码中有静态分析错误，测试框架会将其报告为测试失败。

你可以将以上代码与CPPcheck和Google Test框架一起编译和运行，以进行C++代码的自动化单元测试和静态代码分析。请确保已正确安装和配置CPPcheck，并将其可执行文件路径添加到系统的PATH环境变量中。

同时，你也可以根据需要自定义CPPcheck的参数和规则，以满足对代码进行更详细的静态分析的需求。


# work:
* 1295WS-65HS的项目移植
主界面，设置与未TD同步，GPStracker,smartlock,改分辨率

* Y039 :的倒车avm带辅助线（后续可能要加方向盘转角），
在 360画面增加设置 色彩 与 亮度可调，调后保存。
8368-PCarSDK/application/config/maxmade/AV_Y039_55/avm/params/avm3d    的auxiliaryInfo.xml文件里面
左右方向灯需要打开avm，打左需要发送左摄像头信号，右显示右摄像头，


* P079 smartlinkui

* AV-G019-G0A7:快速倒车的问题
：从appdata.h找到getIsReversing->basecontrol.cpp的handlemcukey里面有个UICC_CAMERA
：别的：找BASE_REVERSE_ENABLE到customEvent；找ENABLE_AVM到mainstart.cpp的getReverseState


* 1307wsc-65
通话状态下点击侧摄像头，直接死机
setLauncherEQorBTActivityName
setCurSource
   if (ActivityManager::self(mQueue)->checkActivityIsCur(HOME_ACTIVITY_NAME))
                {
                    printf("start  home setPreviousActivityName = %s\n",AppData::GetInstance()->GetCurSourceName().c_str());
                    setPreviousActivityName("home");
                    ActivityManager::self(mQueue)->start("airinfo", Permanent);
                }
                else if(AppData::GetInstance()->GetCurSourceName().compare("airinfo") != 0)
                {
                    printf("start  airinfo setPreviousActivityName = %s\n",AppData::GetInstance()->GetCurSourceName().c_str());
                    setPreviousActivityName(AppData::GetInstance()->GetCurSourceName());
                    ActivityManager::self(mQueue)->start("airinfo", Permanent);                    
                }

SYS_INFO_NAME_CPPHONE_CALL
目前对策方法是通话过程中切cam源直接退出，不进行判断

* 2308-02N（8368C）倒车usb问题

* 出货软件：
3.12:
N015-65
AV-1297WS-65HSE   
3.15
AV-1327G-65-HX
3.20
AV-1297-65G-HX
1297WS-65HD
* 样机
AV-1277SC-65HA-HS




# 实现思路
* 左右方向灯需要打开avm
根据您提供的协议描述，当进行左转或右转时，相应的数值会从1或2递减到0，并在此期间灯会闪烁。您想要实现一个判断机制来确定当前的转向灯状态。下面是一个可能的实现：

#include <iostream>

enum TurnSignal {
    TURN_SIGNAL_OFF = 0,
    TURN_SIGNAL_RIGHT = 1,
    TURN_SIGNAL_LEFT = 2,
    TURN_SIGNAL_BOTH = 3,
    TURN_SIGNAL_INVALID = 0xFF
};

// 模拟获取转向灯状态的函数
TurnSignal getTurnSignal() {
    // 这里模拟获取转向灯状态的代码，实际中可能需要调用硬件接口或者其他途径来获取实际状态
    static TurnSignal currentSignal = TURN_SIGNAL_OFF;
    return currentSignal;
}

int main() {
    // 检测转向灯状态
    TurnSignal prevSignal = TURN_SIGNAL_OFF;
    while (true) {
        TurnSignal currentSignal = getTurnSignal();

        if (currentSignal != prevSignal) {
            // 转向灯状态发生了改变
            if (currentSignal == TURN_SIGNAL_LEFT) {
                std::cout << "左转灯闪烁中" << std::endl;
            } else if (currentSignal == TURN_SIGNAL_RIGHT) {
                std::cout << "右转灯闪烁中" << std::endl;
            } else if (currentSignal == TURN_SIGNAL_BOTH) {
                std::cout << "两个方向的转向灯都亮了" << std::endl;
            } else {
                std::cout << "转向灯关闭" << std::endl;
            }
            prevSignal = currentSignal;
        }

        // 在此处添加任何其他处理逻辑

        // 模拟等待一段时间再次检测转向灯状态
        // 这里可以使用延时函数或者其他定时机制来实现
        // 为了简化示例，这里直接使用简单的循环来模拟延时
        for (int i = 0; i < 10000000; ++i) {}
    }

    return 0;
}

在这个示例中，getTurnSignal() 函数模拟了获取转向灯状态的过程。然后，程序会不断地轮询当前转向灯状态，并与上一次的状态进行比较，以检测转向灯状态的变化。根据不同的状态，可以执行相应的操作。







# 打印信息
* G019:
快速：
 I/SPVideoIn(  954): [GetInstance:158] SPVideoIn instance is created! mRefCount=1 +++++
[18:43:02:786] D/[QT]    (  954): [AuxinModuleImpl] get VideoIn instance finish.
[18:43:02:786] I/ResourceManager(  926): [SResourceManager]associate ,pid:[954] obj[1] index[8] 
[18:43:02:786] I/ResourceManager(  954): [CResourceManager]associate success,resource name:MainScreen 
[18:43:02:793] D/[QT]    (  954): [AuxinModuleImpl] Enter
[18:43:02:793] I/ResourceManager(  926): [SResourceManager]associate ,pid:[954] obj[1] index[9] 
[18:43:02:793] I/ResourceManager(  954): [CResourceManager]associate success,resource name:MainAudio 
[18:43:02:793] I/ResourceManager(  926): [SResourceManager]associate ,pid:[954] obj[1] index[10] 
[18:43:02:793] I/ResourceManager(  954): [CResourceManager]associate success,resource name:RearAudio 
[18:43:02:793] D/[QT]    (  954): [AuxinModuleImpl] AuxinModuleImpl line: 80 run
[18:43:02:793] D/[QT]    (  954): [AuxinModuleImpl] StreamOn and RevOn, remove BS.
[18:43:02:801] D/[QT]    (  954): ddddddddddddddddddddd5
[18:43:02:801] D/[QT]    (  954): [InfoModuleImpl] =================>>>>moduleAlready  "auxin"
[18:43:02:801] D/[QT]    (  954): [AuxinModuleImpl] enableVideoBlack
[18:43:02:801] D/[QT]    (  954): ddddddddddddddddddddd6
[18:43:02:801] D/[QT]    (  954): [InfoModuleImpl] "auxin" ready  QTime("01:00:31.725")
[18:43:02:801] D/[QT]    (  954): [SetupModule] moduleReady "auxin"
[18:43:02:801] D/[QT]    (  954): [SetupModule] avinModuleReady 246
[18:43:02:801] D/[QT]    (  954): ImplicitRuleManager PostEvent: eventId  0
[18:43:02:801] D/[QT]    (  954): [ModuleManager] "auxin" startup successful!
[18:43:02:807] D/[QT]    (  954): [basecontrol] customEvent 1005
[18:43:02:807] D/[QT]    (  954):  == BASE_REVERSE_ENABLE ==
[18:43:02:807] D/[QT]    (  954): [basecontrol] showReverseView 264 en: true , UIManager::isRightDrive(): false
[18:43:02:807] D/[QT]    (  954): [ActivityManagerImpl] start "avm" 1
[18:43:02:807] D/[QT]    (  954): waitDestroyActivity: "home"  newActivity: "avm"

等app初始化完之后倒车：
 D/[QT]    (  954): [AVMModuleImpl] [Debug] unsetVideoSrc [--OUT--]
[18:43:16:753] D/[QT]    (  954): [AVMModuleImpl] [Debug] setScreenRes [--IN--]
[18:43:16:753] D/[QT]    (  954): [AVMModuleImpl] [Debug] setScreenRes [--OUT--]
[18:43:16:753] D/[QT]    (  954): [AVMModule] [Debug] exitAVM [--OUT--]
[18:43:16:753] D/[QT]    (  954): ddddddddddddddddddddd15
[18:43:16:759] W/[QT]    (  954): [ActivityManagerImpl] line: 1391 startActivity line: 1391 not quit cur aty
[18:43:16:759] W/[QT]    (  954): [ActivityManagerImpl] line: 1422 startActivity line: 1422 start  aty
[18:43:16:759] D/[QT]    (  954): [HomeView] ============>>>>HomeView onStart  58
[18:43:16:759] D/[QT]    (  954): [HomeView] mediaInfoChangedSlot "home"
[18:43:16:759] D/[QT]    (  954): [CHERY_infopage] setTitle 92 ""
[18:43:16:759] D/[QT]    (  954): [HomeView] mediaInfoChangedSlot 3722 58
[18:43:16:759] D/[QT]    (  954): [CHERY_infopage] clearInfopage_Btn 208
[18:43:16:759] D/[QT]    (  954): [HomeView] ====================>>>mediaInfoChangedSlot  "home"
[18:43:16:766] D/[QT]    (  954): [HomeView] showEvent
[18:43:16:766] D/[QT]    (  954): ============>>>setCurActivityInfo  "home"
[18:43:16:774] D/[QT]    (  954): QWaylandWindow::handleNativeEvent()
[18:43:16:774] <0x1b>[0;1;31m[TS]  --> APP 1st Frame[n] 25684 ms(>0)<0x1b>[0m
[18:43:16:774] D/[QT]    (  954): [basecontrol] nativeEvent
[18:43:16:774] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 1 13078 16711680 16
[18:43:16:774] D/[QT]    (  954): [MAPPC_D] resolvePacket 260 Main app normal msg: 13078 16711680 256
[18:43:16:774] D/[QT]    (  954): sendMcuKeyPressedSignal 16711680 256
[18:43:16:774] D/[QT]    (  954): [basecontrol] Before emit mcuKeyPressed
[18:43:16:774] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 1 13078 16711680 16
[18:43:16:782] D/[QT]    (  954): [MAPPC_D] resolvePacket 260 Main app normal msg: 13078 16711680 1
[18:43:16:782] D/[QT]    (  954): sendMcuKeyPressedSignal 16711680 1
[18:43:16:782] D/[QT]    (  954): [basecontrol] Before emit mcuKeyPressed
[18:43:16:782] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 1 13078 16711680 16
[18:43:16:782] D/[QT]    (  954): [MAPPC_D] resolvePacket 260 Main app normal msg: 13078 16711680 512
[18:43:16:782] D/[QT]    (  954): sendMcuKeyPressedSignal 16711680 512
[18:43:16:782] D/[QT]    (  954): [basecontrol] Before emit mcuKeyPressed
[18:43:16:788] D/[QT]    (  954): [mediaplay] keyDispatch 16711680 256
[18:43:16:788] D/[QT]    (  954): [mediaplay] --------------------------------- getMediaPlayer
[18:43:16:788] D/[QT]    (  954): handleMcuKey 16711680 256
[18:43:16:788] D/[QT]    (  954): ==================>>>>setIsReversing false
[18:43:16:795] D/[QT]    (  954): [QT] [Warning] pAaInstance is Null! androidautomoduleimpl/androidautomoduleimpl.cpp 3891
[18:43:16:795] D/[QT]    (  954): [HomeView] mcuKeySlot 16711680 256
[18:43:16:802] D/[QT]    (  954): [QT] [Warning] pAaInstance is Null! androidautomoduleimpl/androidautomoduleimpl.cpp 3891
[18:43:16:802] D/[QT]    (  954): [HomeView] mcuKeySlot 16711680 1
[18:43:16:810] D/[QT]    (  954): handleMcuKey 16711680 512
[18:43:16:810] Recevied keycode from MCU 0x47 
[18:43:16:810]  UICC_FRONT_SRC!! = 0x2, 0x0
[18:43:16:810] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 1 529 13 16
[18:43:16:810] D/[QT]    (  954): [MAPPC_D] resolvePacket 260 Main app normal msg: 529 13 2
[18:43:16:810] D/[QT]    (  954): [ActivityManagerImpl] last is  2
[18:43:16:810] D/[QT]    (  954): HandleMCUSourceMsg startLastSource
[18:43:16:817] D/[QT]    (  954): [CarplayModule] --------- CP_VechileStatusChanged 493 1 0
[18:43:16:817] E/[QT]    (  954): [CarplayModuleImpl] line: 896 CP uiStatusIndex 1 Val:  0
[18:43:16:817] E/[QT]    (  954): [AndroidAutoModuleImpl] line: 3890 uiStatusIndex,Val: 1 0
[18:43:16:817] D/[QT]    (  954): [QT] [Warning] pAaInstance is Null! androidautomoduleimpl/androidautomoduleimpl.cpp 3891
[18:43:16:817] D/[QT]    (  954): illumi false illumi brightNess 18
[18:43:16:817] D/[QT]    (  954): [HomeView] mcuKeySlot 16711680 512
[18:43:16:817]  Recevied keycode from MCU 0x7a 
[18:43:16:817]  MSG_RECEIVE_KEYS!! = 0x7a, 0x0
[18:43:16:824] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 1 13078 122 16
[18:43:16:824] D/[QT]    (  954): [MAPPC_D] resolvePacket 260 Main app normal msg: 13078 122 0
[18:43:16:824] D/[QT]    (  954): sendMcuKeyPressedSignal 122 0
[18:43:16:824] D/[QT]    (  954): [basecontrol] Before emit mcuKeyPressed
[18:43:16:824] D/[QT]    (  954): [bluetoothmodule][bluetoothmodule.cpp  keyDispatch ][line is 4140] keyDispatch 4140
[18:43:16:824] D/[QT]    (  954): [mediaplay] keyDispatch 122 0
[18:43:16:824] D/[QT]    (  954): [mediaplay] --------------------------------- getMediaPlayer
[18:43:16:824] D/[QT]    (  954): handleMcuKey 122 0
[18:43:16:831] D/[QT]    (  954): [basecontrol] HandleMcuFakerPowerInfo false val 0
[18:43:16:831] D/[QT]    (  954): sendMcuKeyPressedSignal 62 0
[18:43:16:831] D/[QT]    (  954): [basecontrol] Before emit mcuKeyPressed
[18:43:16:831] D/[QT]    (  954): [bluetoothmodule][bluetoothmodule.cpp  keyDispatch ][line is 4140] keyDispatch 4140
[18:43:16:831] D/[QT]    (  954): [mediaplay] keyDispatch 62 0
[18:43:16:831] D/[QT]    (  954): [mediaplay] --------------------------------- getMediaPlayer
[18:43:16:831] D/[QT]    (  954): handleMcuKey 62 0
[18:43:16:831] D/[QT]    (  954): [basecontrol] --pAD->curAudioSource()  58
[18:43:16:838] D/[QT]    (  954): [HomeView] mcuKeySlot 62 0
[18:43:16:838] D/[QT]    (  954): [DisplayControl] set cvbs out disable success! out state: true
[18:43:17:389] D/[QT]    (  954): SetTimeSlot 1654 "01:00 AM" "AM"
[18:43:17:392] D/[QT]    (  954): SetTimeSlot 1668 0 1 0 2023 1 1 0
[18:43:17:411] D/[QT]    (  954): [HomeView] check Device Status after FileDeviceParser create
[18:43:17:411] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:17:411] D/[QT]    (  954): CanImplNewDataSlot 399 32
[18:43:17:411] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:17:411] D/[QT]    (  954): [Audiocontrol] playRadarWarningSound
[18:43:17:431] D/[QT]    (  954): [AVMView] setRadarlevel 485 0
[18:43:17:431] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:17:431] D/[QT]    (  954): CanImplNewDataSlot 399 33
[18:43:18:415] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:18:415] D/[QT]    (  954): CanImplNewDataSlot 399 32
[18:43:18:427] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:18:427] D/[QT]    (  954): [Audiocontrol] playRadarWarningSound
[18:43:18:427] D/[QT]    (  954): [AVMView] setRadarlevel 485 0
[18:43:18:427] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:18:427] D/[QT]    (  954): CanImplNewDataSlot 399 33
[18:43:19:102] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 1 13078 16711680 16
[18:43:19:106] D/[QT]    (  954): [MAPPC_D] resolvePacket 260 Main app normal msg: 13078 16711680 256
[18:43:19:106] D/[QT]    (  954): sendMcuKeyPressedSignal 16711680 256
[18:43:19:106] D/[QT]    (  954): [basecontrol] Before emit mcuKeyPressed
[18:43:19:106] D/[QT]    (  954): [mediaplay] keyDispatch 16711680 256
[18:43:19:116] D/[QT]    (  954): [mediaplay] --------------------------------- getMediaPlayer
[18:43:19:116] D/[QT]    (  954): handleMcuKey 16711680 256
[18:43:19:116] D/[QT]    (  954): ==================>>>>setIsReversing false
[18:43:19:116] D/[QT]    (  954): [CarplayModule] --------- CP_VechileStatusChanged 493 2 0
[18:43:19:116] E/[QT]    (  954): [CarplayModuleImpl] line: 896 CP uiStatusIndex 2 Val:  0
[18:43:19:116] E/[QT]    (  954): [AndroidAutoModuleImpl] line: 3890 uiStatusIndex,Val: 2 0
[18:43:19:116] D/[QT]    (  954): [QT] [Warning] pAaInstance is Null! androidautomoduleimpl/
[18:43:19:127] D/[QT]    (  954): [HomeView] mcuKeySlot 16711680 256
[18:43:19:461] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:19:461] D/[QT]    (  954): CanImplNewDataSlot 399 32
[18:43:19:461] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:19:461] D/[QT]    (  954): [Audiocontrol] playRadarWarningSound
[18:43:19:461] D/[QT]    (  954): [AVMView] setRadarlevel 485 0
[18:43:19:484] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:19:484] D/[QT]    (  954): CanImplNewDataSlot 399 33
[18:43:19:629] W/AudioService(  855): [~PerformanceChecker][37][PerformanceChecker.cpp]src/ServerPropertyUtils.cpp:xmlSaveFile:128, limit=2ms, real=3ms, 
[18:43:19:646] W/AudioService(  855): [~PerformanceChecker][37][PerformanceChecker.cpp]src/ServerPropertyUtils.cpp:xmlSaveFile:104, limit=5ms, real=8ms, 
[18:43:20:466] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:20:466] D/[QT]    (  954): CanImplNewDataSlot 399 32
[18:43:20:466] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:20:478] D/[QT]    (  954): [Audiocontrol] playRadarWarningSound
[18:43:20:478] D/[QT]    (  954): [AVMView] setRadarlevel 485 0
[18:43:20:478] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:20:478] D/[QT]    (  954): CanImplNewDataSlot 399 33
[18:43:20:950] [BRT]file /media/flash/nvm/TL.INI size : -179861360
[18:43:20:950] [BRT]file /media/flash/nvm/TL.INI size < 100
[18:43:20:960] [BRT]bt_snoop_delay:do not need to save other
[18:43:20:966] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:20:976] D/[QT]    (  954): CanImplNewDataSlot 399 24
[18:43:20:976] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:20:985] D/[QT]    (  954): CanImplNewDataSlot 399 10
[18:43:21:026] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 88 88
[18:43:21:026] D/[QT]    (  954): CanImplNewDataSlot 399 52
[18:43:21:026] D/[QT]    (  954): CanImplNewDataSlot 642
[18:43:21:026] D/[QT]    (  954): CanImplNewDataSlot 651 72
[18:43:21:475] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:21:475] D/[QT]    (  954): CanImplNewDataSlot 399 32
[18:43:21:497] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:21:497] D/[QT]    (  954): [Audiocontrol] playRadarWarningSound
[18:43:21:497] D/[QT]    (  954): [AVMView] setRadarlevel 485 0
[18:43:21:497] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:21:497] D/[QT]    (  954): CanImplNewDataSlot 399 33
[18:43:21:940] 2222222222222222222222222222222222
[18:43:21:941] /bin/ash: 2222222222222222222222222222222222: not found
[18:43:21:948] root@Gemini:/# 
[18:43:21:948] root@Gemini:/# D/[QT]    (  954): [basecontrol] ===============>BaseControl::systemHeartbeatTimerSlot
[18:43:22:246] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 1 13144 79 16
[18:43:22:246] D/[QT]    (  954): [MAPPC_D] resolvePacket 260 Main app normal msg: 13144 79 76
[18:43:22:246] D/[QT]    (  954): [MAPPC_D] resolvePacket 296 ==========>MSG_M2A_MCU_TYPE: O tuner type:  L
[18:43:22:390] D/[QT]    (  954): SetTimeSlot 1654 "01:00 AM" "AM"
[18:43:22:406] D/[QT]    (  954): SetTimeSlot 1668 0 1 0 2023 1 1 0
[18:43:22:485] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:22:485] D/[QT]    (  954): CanImplNewDataSlot 399 32
[18:43:22:508] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:22:508] D/[QT]    (  954): [Audiocontrol] playRadarWarningSound
[18:43:22:508] D/[QT]    (  954): [AVMView] setRadarlevel 485 0
[18:43:22:508] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:22:508] D/[QT]    (  954): CanImplNewDataSlot 399 33
[18:43:23:170] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:23:170] D/[QT]    (  954): CanImplNewDataSlot 399 24
[18:43:23:170] D/[QT]    (  954): sendMcuKeyPressedSignal 16711680 0
[18:43:23:170] D/[QT]    (  954): [basecontrol] Before emit mcuKeyPressed
[18:43:23:191] D/[QT]    (  954): [QT] [Warning] pAaInstance is Null! androidautomoduleimpl/androidautomoduleimpl.cpp 3891
[18:43:23:191] D/[QT]    (  954): [HomeView] mcuKeySlot 16711680 0
[18:43:23:214] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:23:230] D/[QT]    (  954): CanImplNewDataSlot 399 24
[18:43:23:515] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 21 21
[18:43:23:515] D/[QT]    (  954): CanImplNewDataSlot 399 32
[18:43:23:515] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:23:527] D/[QT]    (  954): [Audiocontrol] playRadarWarningSound
[18:43:23:527] D/[QT]    (  954): [AVMView] setRadarlevel 485 0
[18:43:23:527] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:23:527] D/[QT]    (  954): CanImplNewDataSlot 399 33
[18:43:23:527] D/[QT]    (  954): [basecontrol] CanInfoUpdateSlot 6879
[18:43:23:527] D/[QT]    (  954): [AVMView] setRadarlevel 485 1
[18:43:23:537] D/[QT]    (  954): [MAPPC_D] loop 99 MAINAPP:RX CMD: 3 0 18 18
[18:43:23:537] D/[QT]    (  954): CanImplNewDataSlot 399 31
[18:43:23:700] I/VideoInImpl(  856): Skip reverse image and RAL display
[18:43:23:703] D/[QT]    (  954): [AuxinModuleImpl] Enter
[18:43:23:703] D/[QT]    (  954): [AuxinModuleImpl] StreamOn and RevOn, remove BS.
[18:43:23:703] D/[QT]    (  954): ddddddddddddddddddddd5
[18:43:23:703] D/[QT]    (  954): [AuxinModuleImpl] enableVideoBlack
[18:43:23:703] D/[QT]    (  954): ddddddddddddddddddddd6
[18:43:23:725] D/[QT]    (  954): ImplicitRuleManager PostEvent: eventId  0
[18:43:23:725] D/[QT]    (  954): [CarPlayResourceManager] reverseGear 939 true
[18:43:23:725] D/[QT]    (  954): [AndroidAutoModuleImpl] reverseGear line: 3822 run
[18:43:23:725] D/[QT]    (  954): [AndroidAutoModuleImpl] reverseGear start: true
[18:43:23:725] D/[QT]    (  954): [basecontrol] customEvent 1005
[18:43:23:725] D/[QT]    (  954):  == BASE_REVERSE_ENABLE ==
[18:43:23:725] D/[QT]    (  954): [basecontrol] showReverseView 264 en: true , UIManager::isRightDrive(): false
[18:43:23:725] D/[QT]    (  954): [ActivityManagerImpl] start "avm" 1
[18:43:23:743] D/[QT]    (  954): waitDestroyActivity: "home"  newActivity: "avm"


怀疑：
AuxinModule::setAVInMode
AVMModule::enterAVM
[basecontrol] showReverseView