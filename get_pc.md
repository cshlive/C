

# 软考
关键路径长度是网络活动图中最耗时的最长路径








# 网站
1.接码：https://sms-activate.org/cn/freePrice#activation
2.ip查询：https://whatismyipaddress.com/
3.ip纯净度：https://scamalytics.com/ip/103.84.219.18
4.sms接码：https://sms-activate.org/cn/freePrice#activation
4.api：https://platform.openai.com/api-keys
















# 日常知识

* linux系统负载：
uptime 系统平均负载
nproc 输出有多少颗核心可以用（逻辑核心）

怎么通过进程id找到线程id
使用 ps -Lp <进程ID> 命令查找进程ID对应的线程ID。其中，-L 选项表示显示线程ID，-p 选项后跟进程ID。
使用 top -H -p <进程ID> 命令查找进程ID对应的线程ID。其中，-H 选项表示显示线程信息，-p 选项后跟进程ID。

Linux怎么样如何通过线程id找到调用栈信息、
打开终端，输入gdb <可执行文件路径>命令，启动gdb调试器。
输入attach <进程ID>命令，将gdb调试器附加到进程中。
输入info threads命令，查看进程中所有线程的ID。
输入thread <线程ID>命令，切换到指定线程。
输入bt命令，查看当前线程的调用栈信息。

学习一点shell基础：

echo： 是Shell的一个内部指令，用于在屏幕上打印出指定的字符串。
```
echo arg 
echo -e arg #执行arg里的转义字符。echo加了-e默认会换行
echo arg > myfile #显示结果重定向至文件，会生成myfile文件

#注意，echo后单引号和双引号作用是不同的。单引号不能转义里面的字符。双引号可有可无，单引号主要用在原样输出中。
```

read： 命令行从输入设备读入内容

定义变量时，变量名不加美元符号（$）
注意，变量名和等号之间不能有空格，这可能和你熟悉的所有编程语言都不一样。有空格会出错。
```
首个字符必须为字母（a-z，A-Z）。
中间不能有空格，可以使用下划线（_）。
不能使用标点符号。
不能使用bash里的关键字（可用help命令查看保留关键字）。

注意：变量中间不能有空格，如果手误写错(例如 var = test)，刚好要使用rm -rf $var/删除这个目录，实际删除的是/！
```
使用一个定义过的变量，只要在变量名前面加美元符号（$）即可，
推荐给所有变量加上花括号，这是个好的编程习惯。

在变量前面加readonly 命令可以将变量定义为只读变量，只读变量的值不能被改变
使用 unset 命令可以删除变量
变量被删除后不能再次使用；unset 命令不能删除只读变量。

运行shell时，会同时存在三种变量： 局部变量 局部变量在脚本或命令中定义，仅在当前shell实例中有效，其他shell启动的程序不能访问局部变量。

 环境变量 所有的程序，包括shell启动的程序，都能访问环境变量，有些程序需要环境变量来保证其正常运行。必要的时候shell脚本也可以定义环境变量。

 shell变量 shell变量是由shell程序设置的特殊变量。shell变量中有一部分是环境变量，有一部分是局部变量，这些变量保证了shell的正常运行。

特殊变量
前面已经讲到，变量名只能包含数字、字母和下划线，因为某些包含其他字符的变量有特殊含义，这样的变量被称为特殊变量。

变量	含义
$0	当前脚本的文件名
$n	传递给脚本或函数的参数。n 是一个数字，表示第几个参数。例如，第一个参数是$1，第二个参数是$2。
$#	传递给脚本或函数的参数个数。
$*	传递给脚本或函数的所有参数。
$@	传递给脚本或函数的所有参数。被双引号(" ")包含时，与 $* 稍有不同
$?	上个命令的退出状态，或函数的返回值。
$$	当前Shell进程ID。对于 Shell 脚本，就是这些脚本所在的进程ID。


* GDB:
编译的时候加上 -g 打开gdb打印
b +具体文件行数： break 在具体位置打上断点
l:会简单显示部分行
n:next,继续的意思 
p：printf 打印变量啥的  info local 打印当前局部变量
s:step 跳进函数里面去
bt:back,回溯，如果报错了可以看部分出错堆栈信息里面有函数信息
ref:reflash 刷新，有时候要信息多按几下回车
b if x == 1 :条件断点，当x=1时继续并中断
set var pt = &value:将pt的值改为value的地址










# 日常记录
*  深入学习计算机系统

讲解很棒：图解：https://xiaolincoding.com/os/1_hardware/how_to_make_cpu_run_faster.html#cpu-cache-%E7%9A%84%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84%E5%92%8C%E8%AF%BB%E5%8F%96%E8%BF%87%E7%A8%8B%E6%98%AF%E4%BB%80%E4%B9%88%E6%A0%B7%E7%9A%84

（1.）关于cpu操作流程：
当 CPU 要读写内存数据的时候，一般需要通过下面这三个总线：

首先要通过「地址总线」来指定内存的地址；
然后通过「控制总线」控制是读或写命令；
最后通过「数据总线」来传输数据；

CPU 想要操作「内存地址」就需要「地址总线」：

如果地址总线只有 1 条，那每次只能表示 「0 或 1」这两种地址，所以 CPU 能操作的内存地址最大数量为 2（2^1）个（注意，不要理解成同时能操作 2 个内存地址）；
如果地址总线有 2 条，那么能表示 00、01、10、11 这四种地址，所以 CPU 能操作的内存地址最大数量为 4（2^2）个。
那么，想要 CPU 操作 4G 大的内存，那么就需要 32 条地址总线，因为 2 ^ 32 = 4G。
那 CPU 执行程序的过程如下：

第一步，CPU 读取「程序计数器」的值，这个值是指令的内存地址，然后 CPU 的「控制单元」操作「地址总线」指定需要访问的内存地址，接着通知内存设备准备数据，数据准备好后通过「数据总线」将指令数据传给 CPU，CPU 收到内存传来的数据后，将这个指令数据存入到「指令寄存器」。
第二步，「程序计数器」的值自增，表示指向下一条指令。这个自增的大小，由 CPU 的位宽决定，比如 32 位的 CPU，指令是 4 个字节，需要 4 个内存地址存放，因此「程序计数器」的值会自增 4；
第三步，CPU 分析「指令寄存器」中的指令，确定指令的类型和参数，如果是计算类型的指令，就把指令交给「逻辑运算单元」运算；如果是存储类型的指令，则交由「控制单元」执行；
代大多数 CPU 都使用来流水线的方式来执行指令，所谓的流水线就是把一个任务拆分成多个小任务，于是一条指令通常分为 4 个阶段，称为 4 级流水线，
四个阶段的具体含义：

CPU 通过程序计数器读取对应内存地址的指令，这个部分称为 Fetch（取得指令）；
CPU 对指令进行解码，这个部分称为 Decode（指令译码）；
CPU 执行指令，这个部分称为 Execution（执行指令）；
CPU 将计算结果存回寄存器或者将寄存器的值存入内存，这个部分称为 Store（数据回写）；
上面这 4 个阶段，我们称为指令周期（Instrution Cycle），CPU 的工作就是一个周期接着一个周期，周而复始。

CPU 的硬件参数都会有 GHz 这个参数，比如一个 1 GHz 的 CPU，指的是时钟频率是 1 G，代表着 1 秒会产生 1G 次数的脉冲信号，每一次脉冲信号高低电平的转换就是一个周期，称为时钟周期。

对于 CPU 来说，在一个时钟周期内，CPU 仅能完成一个最基本的动作，时钟频率越高，时钟周期就越短，工作速度也就越快。
时钟周期时间就是我们前面提及的 CPU 主频，主频越高说明 CPU 的工作速度就越快，比如我手头上的电脑的 CPU 是 2.4 GHz 四核 Intel Core i5，这里的 2.4 GHz 就是电脑的主频，时钟周期时间就是 1/2.4G。
因此，要想程序跑的更快，优化这三者即可：

指令数，表示执行程序所需要多少条指令，以及哪些指令。这个层面是基本靠编译器来优化，毕竟同样的代码，在不同的编译器，编译出来的计算机指令会有各种不同的表示方式。
每条指令的平均时钟周期数 CPI，表示一条指令需要多少个时钟周期数，现代大多数 CPU 通过流水线技术（Pipeline），让一条指令需要的 CPU 时钟周期数尽可能的少；
时钟周期时间，表示计算机主频，取决于计算机硬件。有的 CPU 支持超频技术，打开了超频意味着把 CPU 内部的时钟给调快了，于是 CPU 工作速度就变快了，但是也是有代价的，CPU 跑的越快，散热的压力就会越大，CPU 会很容易奔溃。

CPU 内部嵌入了 CPU Cache（高速缓存），它的存储容量很小，但是离 CPU 核心很近，所以缓存的读写速度是极快的，那么如果 CPU 运算时，直接从 CPU Cache 读取数据，而不是从内存的话，运算速度就会很快。

但是，大多数人不知道 CPU Cache 的运行机制，以至于不知道如何才能够写出能够配合 CPU Cache 工作机制的代码，一旦你掌握了它，你写代码的时候，就有新的优化思路了。

CPU 在从 CPU Cache 读取数据的时候，并不是读取 CPU Cache Line 中的整个数据块，而是读取 CPU 所需要的一个数据片段，这样的数据统称为一个字（Word）。那怎么在对应的 CPU Cache Line 中数据块中找到所需的字呢？答案是，需要一个偏移量（Offset）。

提升数据缓存的命中率
这种不连续性、跳跃式访问数据元素的方式，可能不能充分利用到了 CPU Cache 的特性，从而代码的性能不高。

提升指令缓存的命中率
么，如果分支预测可以预测到接下来要执行 if 里的指令，还是 else 指令的话，就可以「提前」把这些指令放在指令缓存中，这样 CPU 可以直接从 Cache 读取到指令，于是执行速度就会很快。

当数组中的元素是随机的，分支预测就无法有效工作，而当数组元素都是是顺序的，分支预测器会动态地根据历史命中数据对未来进行预测，这样命中率就会很高。

因此，先排序再遍历速度会更快，这是因为排序之后，数字是从小到大的，那么前几次循环命中 if < 50 的次数会比较多，于是分支预测就会缓存 if 里的 array[i] = 0 指令到 Cache 中，后续 CPU 执行该指令就只需要从 Cache 读取就好了。
(相当于砍柴手里刀还没放下)

当有多个同时执行「计算密集型」的线程，为了防止因为切换到不同的核心，而导致缓存命中率下降的问题，我们可以把线程绑定在某一个 CPU 核心上，这样性能可以得到非常可观的提升。

在 Linux 上提供了 sched_setaffinity 方法，来实现将线程绑定到某个 CPU 核心这一功能
内存地址映射到 CPU Cache 地址里的策略有很多种，其中比较简单是直接映射 Cache，它巧妙的把内存地址拆分成「索引 + 组标记 + 偏移量」的方式，使得我们可以将很大的内存地址，映射到很小的 CPU Cache 地址里。

* 并发编程
学会多线程编程可以让你更好地利用计算机的多核处理能力，提高程序的性能和响应性。下面是一些学习多线程编程的步骤和建议：

理解并发编程的基本概念：在开始学习多线程编程之前，了解并发编程的基本概念是非常重要的。学习并发编程的基本原理，如线程、进程、锁、条件变量、同步、互斥等概念，可以为后续的学习打下坚实的基础。

选择合适的编程语言和工具：多线程编程可以使用各种编程语言来实现，如Java、Python、C++等。选择一门你熟悉或者感兴趣的编程语言，并掌握该语言提供的多线程编程相关的库和工具。

学习线程的创建和管理：学习如何创建和管理线程是多线程编程的基础。掌握线程的创建、启动、暂停、恢复、终止等操作，以及线程间的通信和同步机制，如互斥锁、条件变量等。

理解线程安全性和数据共享：在多线程编程中，正确处理数据共享和同步是非常重要的。学习如何保护共享数据的一致性和完整性，如使用互斥锁、读写锁、原子操作等技术来保护共享数据的访问。

掌握线程调度和性能优化：学习线程调度和性能优化可以帮助你更好地利用计算机的多核处理能力，提高程序的性能。了解线程调度的原理，并学习如何合理地划分任务和调度线程，以及如何避免线程之间的竞争和阻塞。

实践和练习：多线程编程是需要实践和练习的。尝试编写一些多线程的小程序，如并发计算、并发任务调度等，以加深对多线程编程的理解和掌握。

学习多线程编程的最佳实践：多线程编程有一些最佳实践，如避免死锁、避免资源竞争、避免线程泄漏等。学习并遵循这些最佳实践可以帮助你编写更高质量、更可靠的多线程程序。

学习多线程编程的高级主题：一旦掌握了基本的多线程编程知识，可以进一步学习一些高级的多线程编程主题，如线程池、并发集合、并发算法等。

总之，学习多线程编程需要理解基本概念、选择合适的编程语言和工具、掌握线程的创建和管理、理解线程安全性和数据共享、掌握线程调度和性能优化、实践和练习，并学习多线程编程的最佳实践和高级主题。通过不断地实践和学习，你将逐渐掌握多线程编程的技巧和经验。

线程间的通信和同步机制是多线程编程中非常重要的概念。下面介绍几种常见的线程间通信和同步机制：

锁机制：使用锁机制可以实现线程的互斥访问。在访问共享资源前，线程需要获取锁，如果锁已被其他线程占用，则需要等待。常见的锁机制有互斥锁（mutex）和读写锁（read-write lock）。

条件变量：条件变量用于在线程间传递信号。一个线程可以通过等待某个条件变量来阻塞自己的执行，而另一个线程可以通过发送信号来唤醒等待的线程。常见的条件变量实现有信号量（semaphore）和条件变量（condition variable）。

信号量：信号量是一种计数器，用于控制同时访问某个资源的线程数量。当信号量的值大于0时，线程可以访问资源并将信号量的值减1；当信号量的值为0时，线程需要等待。常见的信号量有二进制信号量和计数信号量。

管道和队列：管道和队列可以用于在线程间传递数据。管道是一个单向的通信通道，其中的数据按照先进先出的顺序进行传递。队列是一个双向的通信通道，其中的数据按照先进先出的顺序进行传递。

信号（信号量）：信号是一种异步通信机制，用于通知进程发生了某个事件。进程可以通过注册信号处理函数来处理接收到的信号。常见的信号有中断信号（SIGINT）和终止信号（SIGTERM）。

这些线程间通信和同步机制可以帮助我们有效地控制多个线程之间的并发执行，避免数据竞争和不一致的状态。在多线程编程中，根据具体的需求选择合适的机制进行线程间的通信和同步是非常重要的。

* QT的线程
槽函数执行在哪个线程取决于发出信号的对象和槽函数的对象是哪个线程构造的，要想保证成员类的槽函数都执行在子线程，也就是成员类要以指针的方式组合

* FFMPEG:
//ffmpeg命令行 从mp4视频文件提取aac 音频文件
ffmpeg -i test.mp4 -vn -acodec aac test.aac
备注：-i 表示输入文件
-vm disable video / 丢掉视频
-acodec 设置音频编码格式

//ffmpeg 从aac音频文件解码为pcm音频文件
ffmpeg -i test.aac -f s16le test.pcm
备注：-i 表示输入文件
-f 表示输出格式

//ffplay 播放.pcm音频文件
ffplay -ar 44100 -ac 2 -f s16le -i test.pcm
备注：-i 表示指定的输入文件
-f 表示强制使用的格式
-ar 表示播放的音频数据的采样率
-ac 表示播放的音频数据的通道数
//60s长包含音频的video-60.mp4，和30s长的音频audio-30.mp3 合并。audio-30.mp3内的音频会替换到video-60.mp4的音频。
ffmpeg -i video-60.mp4 -i audio-30.mp3 -c:v copy -c:a aac -strict experimental -map 0:v:0 -map 1:a:0 out.mp4

//60s长包含音频的video-60.mp4，和30s长的音频audio-30.mp3 合并。合并后的out.mp4包含两路音频。
ffmpeg -i video-60.mp4 -i audio-30.mp3 -filter_complex "amix=inputs=2:duration=first:dropout_transition=0" -c:v "libx264" -c:a "aac" -y out.mp4










# 复制粘贴
2023-10-04
1. 李跳跳规则：
[
	{
		"-1835777899": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"common_confirm_dialog_center_layout\",\"action\":\"common_confirm_dialog_cancel\"},{\"id\":\"打开定位\",\"action\":\"我知道了\"},{\"id\":\"及时获取&消息\",\"action\":\"取消\"},{\"id\":\"tv_love_sub_title\",\"action\":\"iv_close_love_tips\"},{\"id\":\"打开通知\",\"action\":\"iv_notice_close\"}]}"
	},
	{
		"320552729": "{\"popup_rules\":[{\"id\":\"立即更新\",\"action\":\"稍后更新\"}]}"
	},
	{
		"-330301876": "{\"popup_rules\":[{\"id\":\"native_ad_container\",\"action\":\"topon_btn_close\"},{\"id\":\"csj_ad_logo\",\"action\":\"csj_btn_close\"},{\"id\":\"| 跳过\",\"action\":\"| 跳过\"},{\"id\":\"再看&可领奖励\",\"action\":\"坚持退出\"}],\"click_way_popup\":1}"
	},
	{
		"2130042610": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"1386065562": "{\"popup_rules\":[{\"id\":\"init_top_img\",\"action\":\"init_time_text\"}]}"
	},
	{
		"960022320": "{\"popup_rules\":[{\"id\":\"给您发送通知\",\"action\":\"不接收\"}]}"
	},
	{
		"361910168": "{\"popup_rules\":[{\"id\":\"lpk\",\"action\":\"关闭\"},{\"id\":\"=广告\",\"action\":\"=更多\"},{\"id\":\"=关闭此条广告\",\"action\":\"=关闭此条广告\"},{\"id\":\"=立即前往\",\"action\":\"close\"}]}"
	},
	{
		"-1518567568": "{\"popup_rules\":[{\"id\":\"请评价我们的产品\",\"action\":\"下次再说\"}]}"
	},
	{
		"239830085": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"稍后更新\"},{\"id\":\"限时&星币购买\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"关注我\",\"action\":\"b3p\"},{\"id\":\"推送通知&开启\",\"action\":\"dhf\"}]}"
	},
	{
		"706813998": "{\"popup_rules\":[{\"id\":\"打开推送通知\",\"action\":\"暂不开启\"},{\"id\":\"开启通知权限\",\"action\":\"取消\"},{\"id\":\"打开通知权限\",\"action\":\"暂不开启\"},{\"id\":\"main_iv_limit_confirm\",\"action\":\"main_iv_limit_close\"},{\"id\":\"host_lockscreen_guide_alert_dialog_rich_confirm_title_tv\",\"action\":\"host_lockscreen_guide_alert_dialog_rich_confirm_cancel_btn\"},{\"id\":\"host_layout_vote_title\",\"action\":\"host_timeline_card_close\"},{\"id\":\"main_x_play_anchor_shop_cover\",\"action\":\"main_x_play_anchor_shop_close_btn\"},{\"id\":\"live_iv_bottom_close\",\"action\":\"live_iv_bottom_close\"},{\"id\":\"立即抽奖\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"有通行证奖励可领取\",\"action\":\"引导关闭按钮\"},{\"id\":\"liveExitDialogBg\",\"action\":\"liveBtnExit\"},{\"id\":\"main_ad_broadside_img\",\"action\":\"main_ad_broadside_close\"}]}"
	},
	{
		"-2028968188": "{\"popup_rules\":[{\"id\":\"iv_home_ad_bg\",\"action\":\"iv_home_ad_close\"},{\"id\":\"iv_invite_icon\",\"action\":\"iv_invite_close\"}]}"
	},
	{
		"-103523392": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"进入直播间热聊\",\"action\":\"稍后再说\"},{\"id\":\"开启地理位置权限\",\"action\":\"拒绝\"}]}"
	},
	{
		"1695025949": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"847156324": "{\"popup_rules\":[{\"id\":\"=立即更新\",\"action\":\"=取消\"},{\"id\":\"ad_time_view\",\"action\":\"=关闭\"},{\"id\":\"关闭广告\",\"action\":\"=不感兴趣\"},{\"id\":\"不感兴趣&举报广告\",\"action\":\"=不感兴趣\"},{\"id\":\"coolapk_card_view\",\"action\":\"close_view\"}]}"
	},
	{
		"-833566134": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"下次再说\"}]}"
	},
	{
		"-1864872766": "{\"popup_rules\":[{\"id\":\"恭喜获得&红包\",\"action\":\"unused_res_a\"},{\"id\":\"狠心离开&去看看\",\"action\":\"狠心离开\"},{\"id\":\"=logo\",\"action\":\"=close\"}]}"
	},
	{
		"-558836051": "{\"popup_rules\":[{\"id\":\"reaper_ad_source_layout\",\"action\":\"close\"},{\"id\":\"adv_main\",\"action\":\"iv_close\"}]}"
	},
	{
		"-2114933808": "{\"popup_rules\":[{\"id\":\"ksad_interstitial_native\",\"action\":\"ksad_auto_close_btn\"},{\"id\":\"ad_area\",\"action\":\"close_btn\",\"delay_popup\":5000},{\"id\":\"img_native\",\"action\":\"img_native_close\"},{\"id\":\"iv_apk_icon\",\"action\":\"iv_close\"},{\"id\":\"广告\",\"action\":\"跳过\"},{\"id\":\"tv_feedback_submit\",\"action\":\"iv_feedback_close\"}]}"
	},
	{
		"1893781697": "{\"popup_rules\":[{\"id\":\"新版体验邀请\",\"action\":\"bt_cancel_experience\"},{\"id\":\"tv_red_envelop_main_title\",\"action\":\"img_cf_view_close\"},{\"id\":\"img_floating_ad_cmb\",\"action\":\"img_close_floating_ad_cmb\"},{\"id\":\"定位服务\",\"action\":\"btn_mid_center_couple_negative\"},{\"id\":\"真的要放弃吗\",\"action\":\"残忍离开\"},{\"id\":\"img_cmb_drag_pendant_close\",\"action\":\"img_cmb_drag_pendant_close\"}]}"
	},
	{
		"342704719": "{\"popup_rules\":[{\"id\":\"升级提醒\",\"action\":\"稍后再说\"}]}"
	},
	{
		"-1488821919": "{\"popup_rules\":[{\"id\":\"打开通知\",\"action\":\"iv_close\"}]}"
	},
	{
		"-811421306": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"mLinSignBg\",\"action\":\"imgSignClone\"},{\"id\":\"打开&推送通知\",\"action\":\"以后再说\"}]}"
	},
	{
		"114295028": "{\"popup_rules\":[{\"id\":\"updata_title\",\"action\":\"update_close\"}]}"
	},
	{
		"2053958218": "{\"popup_rules\":[{\"id\":\"允许&推送通知\",\"action\":\"取消\"},{\"id\":\"dialog_card\",\"action\":\"dialog_close\"}]}"
	},
	{
		"-895263099": "{\"popup_rules\":[{\"id\":\"更新提示\",\"action\":\"取消\"}]}"
	},
	{
		"332614644": "{\"popup_rules\":[{\"id\":\"首次答题特权\",\"action\":\"iv_remind_close\"}]}"
	},
	{
		"1143986695": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"tv_ignore_this_version\"},{\"id\":\"开启系统日历的访问权限\",\"action\":\"取消\"}]}"
	},
	{
		"-796004189": "{\"popup_rules\":[{\"id\":\"想给你发送通知\",\"action\":\"不允许\"}]}"
	},
	{
		"-1053900032": "{\"popup_rules\":[{\"id\":\"suite_completed_ads_container\",\"action\":\"suite_completed_close_ad_button\"}]}"
	},
	{
		"-895188853": "{\"popup_rules\":[{\"id\":\"huyaui_float_notify_count_close\",\"action\":\"huyaui_float_notify_count_close\"},{\"id\":\"开启通知，不错过订阅的主播开播\",\"action\":\"iv_right\"},{\"id\":\"push_popup_sec_txt\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"1875899872": "{\"popup_rules\":[{\"id\":\"开启定位权限\",\"action\":\"home_close_img\"}]}"
	},
	{
		"1319538838": "{\"popup_rules\":[{\"id\":\"开启推送\",\"action\":\"push_set_close_img\"},{\"id\":\"完善昵称有利于收获更多的粉丝\",\"action\":\"close_img\"}]}"
	},
	{
		"-1031558479": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"送你&新人购物券\",\"action\":\"GLOBAL_ACTION_BACK\"},]}"
	},
	{
		"1219698816": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"pop_youngset_know_txt\"},{\"id\":\"newuser_fuli_img_intent\",\"action\":\"newuser_fuli_img_closed\"},{\"id\":\"tv_notice_content\",\"action\":\"tv_notice_content\"}]}"
	},
	{
		"-557467920": "{\"popup_rules\":[{\"id\":\"开启消息通知\",\"action\":\"取消\"}]}"
	},
	{
		"-747700391": "{\"popup_rules\":[{\"id\":\"立即免费领取\",\"action\":\"ivClose\"},{\"id\":\"新用户福利仅一次\",\"action\":\"放弃福利\"},{\"id\":\"开通会员&特惠\",\"action\":\"ivClose\"}]}"
	},
	{
		"-189732215": "{\"popup_rules\":[{\"id\":\"banner_image\",\"action\":\"image_close_banner\"}]}"
	},
	{
		"1765779203": "{\"popup_rules\":[{\"id\":\"red_packet_content\",\"action\":\"red_packet_close\"},{\"id\":\"bn_\",\"action\":\"bs3\"},{\"id\":\"添加桌面小组件\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"502255059": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"开启消息通知\",\"action\":\"arg\"}]}"
	},
	{
		"2091464343": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"以后再说\"},{\"id\":\"获取&剪切板\",\"action\":\"不允许\"},{\"id\":\"开启推送通知\",\"action\":\"取消\"},{\"id\":\"drag_img\",\"action\":\"close_btn\"},{\"id\":\"图片跳转\",\"action\":\"此图片未加标签\"},{\"id\":\"ad_image\",\"action\":\"close_btn\"},{\"id\":\"img_advertlogo\",\"action\":\"iv_close_top\"}]}"
	},
	{
		"991562021": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"-322418038": "{\"popup_rules\":[{\"id\":\"upgrade_dialog_cancel\",\"action\":\"upgrade_dialog_cancel\"}]}"
	},
	{
		"-1709882794": "{\"popup_rules\":[{\"id\":\"update_title\",\"action\":\"btn_close\"},{\"id\":\"bottom_center_close_button\",\"action\":\"bottom_center_close_button\"},{\"id\":\"订单已满&优惠换购\",\"action\":\"放弃机会\"},{\"id\":\"恭喜你获得以下权益\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"popContentImg\",\"action\":\"popCloseBtn\"}]}"
	},
	{
		"1536737232": "{\"popup_rules\":[{\"id\":\"打开通知，及时收到互动消息\",\"action\":\"right_icon\"},{\"id\":\"选择通知类型\",\"action\":\"暂不开启\"},{\"id\":\"bottom_process_tv\",\"action\":\"close\"},{\"id\":\"使用您的位置信息\",\"action\":\"以后再说\"},{\"id\":\"tv_tips\",\"action\":\"iv_close_icon\"},{\"id\":\"不感兴趣&为何会看到此广告\",\"action\":\"不感兴趣\"},{\"id\":\"tv_tips\",\"action\":\"iv_close_icon\"},{\"id\":\"不感兴趣&屏蔽此博主\",\"action\":\"不感兴趣\"},{\"id\":\"left_img_ad_tag\",\"action\":\"close\"},{\"id\":\"关注你感兴趣的超话\",\"action\":\"iv_close\"},{\"id\":\"定位服务未开启\",\"action\":\"以后再说\"},{\"id\":\"点击签到\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"给我们评分\",\"action\":\"不了，谢谢\"},{\"id\":\"card_view\",\"action\":\"right_top_tag\"},{\"id\":\"不感兴趣&内容质量差\",\"action\":\"不感兴趣\"},{\"id\":\"错过了&爆词&查看详情\",\"action\":\"mIvRight\"}]}"
	},
	{
		"560468770": "{\"popup_rules\":[{\"id\":\"openAlertText\",\"action\":\"btn_close_update_setting\"}]}"
	},
	{
		"1984799751": "{\"popup_rules\":[{\"id\":\"da_container\",\"action\":\"closeAd\"},{\"id\":\"itah_layout\",\"action\":\"closeAd\"},{\"id\":\"iltas_ad_layout\",\"action\":\"closeAd\"}]}"
	},
	{
		"1596265335": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"fl_newcomer_gift\",\"action\":\"iv_close\"},{\"id\":\"banner_icon_iv\",\"action\":\"colse_iv\"},{\"id\":\"tv_usercenter_notify_title\",\"action\":\"iv_usercenter_notify_close\"},{\"id\":\"VIP限时超低价\",\"action\":\"icon_close_popup\"},{\"id\":\"ad_name_tv\",\"action\":\"ad_close_iv\"},{\"id\":\"free_mode_dialog_image\",\"action\":\"dialog_close_btn\"}]}"
	},
	{
		"1073158053": "{\"popup_rules\":[{\"id\":\"新版本\",\"action\":\"取消\"},{\"id\":\"dialog_full_image\",\"action\":\"dialog_full_image_close\"}]}"
	},
	{
		"1683280386": "{\"popup_rules\":[{\"id\":\"发现&新版本&立即升级\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"-1960346768": "{\"popup_rules\":[{\"id\":\"ad_content\",\"action\":\"btnClose\"}]}"
	},
	{
		"1272214412": "{\"popup_rules\":[{\"id\":\"想给您发送通知\",\"action\":\"暂不\"}]}"
	},
	{
		"725735704": "{\"popup_rules\":[{\"id\":\"青少年守护模式\",\"action\":\"tv_confirm\"}]}"
	},
	{
		"-733096426": "{\"popup_rules\":[{\"id\":\"更新Telegram\",\"action\":\"请稍后提醒我\"}]}"
	},
	{
		"-1414602254": "{\"popup_rules\":[{\"id\":\"恭喜！你收到新人现金红包\",\"action\":\"dtj\"},{\"id\":\"朋友推荐\",\"action\":\"close\"},{\"id\":\"朋友推荐\",\"action\":\"不感兴趣\"},{\"id\":\"朋友推荐\",\"action\":\"关闭\"},{\"id\":\"青少年模式\",\"action\":\"关闭\"},{\"id\":\"资料完善度&继续完善\",\"action\":\"关闭\"}]}"
	},
	{
		"651433099": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"暂不更新\"},{\"id\":\"开启消息通知\",\"action\":\"notice_dialog_cancel_iv\"},{\"id\":\"打开消息通知\",\"action\":\"close\"},{\"id\":\"订阅微信通知\",\"action\":\"cancel_iv\"},{\"id\":\"写好评，鼓励一下\",\"action\":\"不了，谢谢\"}]}"
	},
	{
		"28505069": "{\"popup_rules\":[{\"id\":\"dialog_once_price_iv_buy\",\"action\":\"dialog_once_price_iv_cancel\"}]}"
	},
	{
		"-1854575849": "{\"popup_rules\":[{\"id\":\"查看&分享的文件\",\"action\":\"立即查看\"}]}"
	},
	{
		"-1730999113": "{\"popup_rules\":[{\"id\":\"开启&终端管理\",\"action\":\"暂不开启\"}]}"
	},
	{
		"876496474": "{\"popup_rules\":[{\"id\":\"立即领现金\",\"action\":\"unused_res_a\"},{\"id\":\"unused_res_a\",\"action\":\"=关闭\"}]}"
	},
	{
		"-30728625": "{\"popup_rules\":[{\"id\":\"立即更新\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"打开通知权限\",\"action\":\"取消\"},{\"id\":\"精选内容\",\"action\":\"Close\"}]}"
	},
	{
		"1877659010": "{\"popup_rules\":[]}"
	},
	{
		"2078928257": "{\"popup_rules\":[{\"id\":\"activity_guide_animation\",\"action\":\"跳过\"},{\"id\":\"打开通知权限\",\"action\":\"取消\"}]}"
	},
	{
		"1276497535": "{\"popup_rules\":[{\"id\":\"有新版本&升级\",\"action\":\"暂不升级\"},{\"id\":\"bar_close\",\"action\":\"bar_close\"}]}"
	},
	{
		"293886959": "{\"popup_rules\":[{\"id\":\"抢先体验\",\"action\":\"取消\"}]}"
	},
	{
		"1799462192": "{\"popup_rules\":[{\"id\":\"ad_title\",\"action\":\"ad_close_btn\"}]}"
	},
	{
		"1366626055": "{\"popup_rules\":[{\"id\":\"tv_teen_dialog_title\",\"action\":\"young_dialog_close_img\"},{\"id\":\"txt_push_open_title\",\"action\":\"btn_open_cancel\"},{\"id\":\"七猫新人红包\",\"action\":\"iv_close_bonus\"},{\"id\":\"red_packet_img\",\"action\":\"close_red_packet\"},{\"id\":\"imageView\",\"action\":\"imageView_close\"},{\"id\":\"read_view\",\"action\":\"close\"},{\"id\":\"ad_privacy_view\",\"action\":\"iv_ad_direct_close\"},{\"id\":\"ll_ad_bottom_remind_group\",\"action\":\"ad_direct_close\"}]}"
	},
	{
		"-1544055932": "{\"popup_rules\":[{\"id\":\"青少年守护模式\",\"action\":\"我知道了\"},{\"id\":\"head_img\",\"action\":\"close\"},{\"id\":\"tv_name\",\"action\":\"iv_del\"}]}"
	},
	{
		"1907791813": "{\"popup_rules\":[{\"id\":\"button_open_continue_pay\",\"action\":\"close\"},{\"id\":\"新功能\",\"action\":\"btn_close\"}]}"
	},
	{
		"-524269385": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"widget_close_icon\",\"action\":\"widget_close_icon\"},{\"id\":\"关注Ta\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"2092879561": "{\"popup_rules\":[{\"id\":\"青少年守护\",\"action\":\"已满14岁\"},{\"id\":\"cancelButton\",\"action\":\"cancelButton\"},{\"id\":\"去&应用市场&评价\",\"action\":\"取消\"}]}"
	},
	{
		"229330387": "{\"popup_rules\":[{\"id\":\"=开启推送通知\",\"action\":\"以后再说\"},{\"id\":\"+开启推送通知\",\"action\":\"bn0\"},{\"id\":\"青少年模式\",\"action\":\"=我知道了\"}]}"
	},
	{
		"201325446": "{\"popup_rules\":[{\"id\":\"打开消息推送通知\",\"action\":\"ivCloseAlert\"},{\"id\":\"llJbpFirstPopContent\",\"action\":\"ivJbpFirstPopClose\"},{\"id\":\"把聚宝盆添加到桌面快捷方式\",\"action\":\"之后再说\"},{\"id\":\"apperience_enter\",\"action\":\"apperience_close\"},{\"id\":\"rlRedPop\",\"action\":\"ivClose\"},{\"id\":\"iv_pop_content\",\"action\":\"iv_pop_close\"},{\"id\":\"ivPromotion\",\"action\":\"btnClose\"}]}"
	},
	{
		"-527086868": "{\"popup_rules\":[{\"id\":\"gift_img\",\"action\":\"gift_close\"},{\"id\":\"打开系统通知\",\"action\":\"iv_close\"}]}"
	},
	{
		"-524659007": "{\"popup_rules\":[{\"id\":\"不感兴趣\",\"action\":\"不感兴趣\",\"times\":5}]}"
	},
	{
		"-328022007": "{\"popup_rules\":[{\"id\":\"广告\",\"action\":\"跳过\"},{\"id\":\"main_ad_alert\",\"action\":\"main_ad_alert_close\"},{\"id\":\"slideshowView\",\"action\":\"ivClose\"}]}"
	},
	{
		"1174097286": "{\"popup_rules\":[{\"id\":\"icon_cart_egg_close\",\"action\":\"icon_cart_egg_close\"},{\"id\":\"弹窗\",\"action\":\"关闭按钮\"},{\"id\":\"发现新版本\",\"action\":\"取消\"}]}"
	},
	{
		"2029054607": "{\"popup_rules\":[{\"id\":\"tt_splash_ad_logo\",\"action\":\"tt_splash_skip_btn\"}]}"
	},
	{
		"1519628819": "{\"popup_rules\":[{\"id\":\"tt_splash_ad_logo\",\"action\":\"tt_splash_skip_btn\"}]}"
	},
	{
		"313184810": "{\"popup_rules\":[{\"id\":\"检测到更新\",\"action\":\"以后再说\"},{\"id\":\"青少年模式\",\"action\":\"关闭\"},{\"id\":\"朋友推荐\",\"action\":\"close\"},{\"id\":\"隐藏\",\"action\":\"h7e\"},{\"id\":\"开启朋友通知\",\"action\":\"暂不\"},{\"id\":\"朋友推荐 标题\",\"action\":\"qpb\"},{\"id\":\"及时获得消息提醒\",\"action\":\"暂不开启\"},{\"id\":\"想访问你的通讯录\",\"action\":\"拒绝\"}]}"
	},
	{
		"-1667428321": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"忽略\"},{\"id\":\"byr\",\"action\":\"byr\",\"times\":5},{\"id\":\"page-title\",\"action\":\"avq\"},],\"click_way_popup\":1}"
	},
	{
		"195210534": "{\"popup_rules\":[{\"id\":\"升级版本\",\"action\":\"关闭\"},{\"id\":\"收到一个现金红包\",\"action\":\"关闭\"}]}"
	},
	{
		"-1220851267": "{\"popup_rules\":[{\"id\":\"layout_young_tips\",\"action\":\"ok_btn\"},{\"id\":\"授权地理位置权限\",\"action\":\"btn_cancel\"}]}"
	},
	{
		"125486076": "{\"popup_rules\":[{\"id\":\"有新版本啦\",\"action\":\"imageView_close\"}]}"
	},
	{
		"-1991835185": "{\"popup_rules\":[{\"id\":\"开启通知\",\"action\":\"不允许\"},{\"id\":\"ad_image\",\"action\":\"ad_close\"}]}"
	},
	{
		"-973170826": "{\"popup_rules\":[{\"id\":\"广告\",\"action\":\"feedbackIcon\"},{\"id\":\"dislike&feedbackBtn\",\"action\":\"不感兴趣\"},{\"id\":\"isdismatch&isduplicate&isbadad\",\"action\":\"与我无关\"}]}"
	},
	{
		"167193980": "{\"popup_rules\":[{\"id\":\"javascript:;\",\"action\":\"javascript:;\"},{\"id\":\"定位服务授权\",\"action\":\"取消\"},{\"id\":\"64c8cbcb30036\",\"action\":\"close\"}]}"
	},
	{
		"-1239952740": "{\"popup_rules\":[{\"id\":\"为什么不希望看到这条推广\",\"action\":\"不感兴趣\"}]}"
	},
	{
		"2138257400": "{\"popup_rules\":[{\"id\":\"打开消息通知\",\"action\":\"close_icon\"}]}"
	},
	{
		"1511151769": "{\"popup_rules\":[{\"id\":\"获取消息通知\",\"action\":\"暂不开启\"}]}"
	},
	{
		"-1491765371": "{\"popup_rules\":[{\"id\":\"开启青少年模式\",\"action\":\"知道了\"}]}"
	},
	{
		"1970409442": "{\"popup_rules\":[{\"id\":\"监护人同意\",\"action\":\"已满14岁\"}]}"
	},
	{
		"-358087111": "{\"popup_rules\":[{\"id\":\"push_on_notify_bar\",\"action\":\"push_on_notify_delete\"}]}"
	},
	{
		"-173873869": "{\"popup_rules\":[{\"id\":\"iv_tg_ad\",\"action\":\"iv_tg_ad\"},{\"id\":\"btn_open_notification\",\"action\":\"iv_close_notification_guide\"},{\"id\":\"forum_ad_imageview\",\"action\":\"iv_close_community_ad\"},{\"id\":\"iv_recommend_ad_image\",\"action\":\"iv_close_ad\"}]}"
	},
	{
		"-1665025453": "{\"popup_rules\":[{\"id\":\"为了安全着想，请开启安全守护\",\"action\":\"放弃\"},{\"id\":\"准备中\",\"action\":\"准备中\",\"times\":0},{\"id\":\"检测中\",\"action\":\"检测中\",\"times\":0},{\"id\":\"继续更新\",\"action\":\"继续更新\",\"times\":3},{\"id\":\"继续安装\",\"action\":\"继续安装\",\"times\":3},{\"id\":\"继续\",\"action\":\"继续\",\"times\":3},{\"id\":\"安装中\",\"action\":\"安装中\",\"times\":0},{\"id\":\"完成\",\"action\":\"完成\"}],\"unite_popup_rules\":true,\"ltt_service\":true}"
	},
	{
		"-2096096381": "{\"popup_rules\":[{\"id\":\"pop_advertisement_content\",\"action\":\"iv_close\"}]}"
	},
	{
		"-1478231696": "{\"popup_rules\":[{\"id\":\"iv_peer_exchange_fhr\",\"action\":\"iv_peer_exchange_close_fhr\"},{\"id\":\"打开系统通知\",\"action\":\"bt_tip_close\"}]}"
	},
	{
		"588474247": "{\"popup_rules\":[{\"id\":\"更新\",\"action\":\"取消\"}]}"
	},
	{
		"-1206397310": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"=我知道了\"},{\"id\":\"ivFloatAd\",\"action\":\"ivAdClose\"},{\"id\":\"layout_ad_layout\",\"action\":\"native_ad_close\"},{\"id\":\"ad_flag_source_layout\",\"action\":\"iv_close\"},{\"id\":\"native_ad_image\",\"action\":\"native_ad_close\"},{\"id\":\"native_ad_title\",\"action\":\"native_ad_close\"}]}"
	},
	{
		"199342455": "{\"popup_rules\":[{\"id\":\"开启推送通知\",\"action\":\"iv_close\"},{\"id\":\"tv_nps_title\",\"action\":\"img_nps_close\"}]}"
	},
	{
		"-766051647": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"放弃更新\"}]}"
	},
	{
		"-1527971724": "{\"popup_rules\":[{\"id\":\"iv_notification_tip_icon\",\"action\":\"cv_cancel_notification_tip\"},{\"id\":\"cl_top\",\"action\":\"bt_close\"}]}"
	},
	{
		"1600359417": "{\"popup_rules\":[{\"id\":\"新版本\",\"action\":\"稍后更新\"}]}"
	},
	{
		"992705457": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"知道了\"},{\"id\":\"开启消息通知\",\"action\":\"暂不开启\"},{\"id\":\"不要错过重要消息，试试个性化管理吧\",\"action\":\"bce\"}]}"
	},
	{
		"1979515232": "{\"popup_rules\":[{\"id\":\"updateVersionTitle\",\"action\":\"md_dialog_cm_close_btn\"},{\"id\":\"访问您的位置\",\"action\":\"取消\"}]}"
	},
	{
		"-1869705199": "{\"popup_rules\":[{\"id\":\"删除所有广告\",\"action\":\"跳过\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"}],\"click_way_popup\":1}"
	},
	{
		"-1902185409": "{\"popup_rules\":[{\"id\":\"首次成功发布沸点\",\"action\":\"iv_close\"}]}"
	},
	{
		"-1567553486": "{\"popup_rules\":[{\"id\":\"ux_program_title\",\"action\":\"confirm_cancel\"},{\"id\":\"GuideModalConfirmBtn\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"开启通知\",\"action\":\"close\"}]}"
	},
	{
		"818881643": "{\"popup_rules\":[{\"id\":\"=广告\",\"action\":\"跳过\"}]}"
	},
	{
		"863298512": "{\"popup_rules\":[{\"id\":\"threeImageBaPing\",\"action\":\"close_ba_ping\"},{\"id\":\"imageBaPingFullScreen\",\"action\":\"closeBaPingFull\"},{\"id\":\"baPing_small_icon\",\"action\":\"baPing_small_close\"}]}"
	},
	{
		"-1877153607": "{\"popup_rules\":[{\"id\":\"给您发送通知\",\"action\":\"不接收\"}]}"
	},
	{
		"616434203": "{\"popup_rules\":[{\"id\":\"“快影”想给您发送通知\",\"action\":\"sy\"}]}"
	},
	{
		"-357699061": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"知道了\"}]}"
	},
	{
		"-243402277": "{\"popup_rules\":[{\"id\":\"iv_activities_banner\",\"action\":\"iv_close\"}]}"
	},
	{
		"1032792361": "{\"popup_rules\":[{\"id\":\"新人专属月卡\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"1047154881": "{\"popup_rules\":[{\"id\":\"确认加购\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"270344886": "{\"popup_rules\":[{\"id\":\"iv_poster\",\"action\":\"iv_close\"}]}"
	},
	{
		"991394745": "{\"popup_rules\":[{\"id\":\"home_ad_dialog_pager\",\"action\":\"iv_home_ad_close\"},{\"id\":\"homeLocationPermissionTipsTitle\",\"action\":\"homeLocationPermissionClose\"},{\"id\":\"开启消息通知\",\"action\":\"close\"}]}"
	},
	{
		"-2003752385": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"ok_tv\"},{\"id\":\"bg_iv\",\"action\":\"close_iv\"},{\"id\":\"notification_open_lay\",\"action\":\"close_lay_btn\"}]}"
	},
	{
		"1091754941": "{\"popup_rules\":[{\"id\":\"新人专属福利\",\"action\":\"iv_close\"},{\"id\":\"hbv\",\"action\":\"iv_close\"},{\"id\":\"开启推送通知\",\"action\":\"iv_cancel\"}]}"
	},
	{
		"-1652150487": "{\"popup_rules\":[{\"id\":\"检测到更新\",\"action\":\"以后再说\"},{\"id\":\"青少年模式\",\"action\":\"关闭\"},{\"id\":\"收到现金红包\",\"action\":\"bci\"},{\"id\":\"授权提示\",\"action\":\"我再想想\"},{\"id\":\"授权通讯录\",\"action\":\"拒绝\"},{\"id\":\"资料完善度&继续完善\",\"action\":\"关闭\"},{\"id\":\"朋友推荐\",\"action\":\"关闭\"},{\"id\":\"简介支持@功能，快来试试吧\",\"action\":\"关闭\"}]}"
	},
	{
		"-7542465": "{\"popup_rules\":[{\"id\":\"advert_creative_head_title_v3\",\"action\":\"advert_creative_head_img_text_layout_close_btn_v3\"}]}"
	},
	{
		"-1065232334": "{\"popup_rules\":[{\"id\":\"iv_opera\",\"action\":\"iiv_close\"},{\"id\":\"mantine-r4-body\",\"action\":\"upload\"}]}"
	},
	{
		"662377423": "{\"popup_rules\":[{\"id\":\"ll_book_recommend\",\"action\":\"gift_close\"},{\"id\":\"gift_container\",\"action\":\"gift_close\"},{\"id\":\"daily_container\",\"action\":\"daily_close\"}]}"
	},
	{
		"1062801388": "{\"popup_rules\":[{\"id\":\"iv_bg\",\"action\":\"iv_close\"},{\"id\":\"iv_ad\",\"action\":\"tv_close_ad\"}]}"
	},
	{
		"2009078134": "{\"popup_rules\":[{\"id\":\"新用户限时特惠\",\"action\":\"知道了\"}]}"
	},
	{
		"652719697": "{\"popup_rules\":[{\"id\":\"layoutOpenVip\",\"action\":\"ivVipBannerClose\"}]}"
	},
	{
		"1590102142": "{\"popup_rules\":[{\"id\":\"极速版小助理&求关注\",\"action\":\"拒绝\"},{\"id\":\"item_timeline_ad_sign\",\"action\":\"关闭广告\"},{\"id\":\"屏蔽信息流广告\",\"action\":\"不感兴趣\"}]}"
	},
	{
		"-1520738335": "{\"popup_rules\":[{\"id\":\"暂不更新\",\"action\":\"update_title_tv\"}]}"
	},
	{
		"378881071": "{\"popup_rules\":[{\"id\":\"懂车帝有更新啦\",\"action\":\"以后再说\"}]}"
	},
	{
		"1429484426": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"正在试听，完整播放需要开通VIP\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"270694045": "{\"popup_rules\":[{\"id\":\"开启消息通知\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"648308836": "{\"popup_rules\":[{\"id\":\"升级体验\",\"action\":\"取消\"},{\"id\":\"home_float_close\",\"action\":\"home_float_close\"},{\"id\":\"不再提醒\",\"action\":\"tv_never\"}]}"
	},
	{
		"-1930444755": "{\"popup_rules\":[{\"id\":\"riv_poplayer_image\",\"action\":\"iv_close_poplayer_image\"}]}"
	},
	{
		"1488133239": "{\"popup_rules\":[{\"id\":\"开始发图\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"签到成功\",\"action\":\"close\"}]}"
	},
	{
		"1788138577": "{\"popup_rules\":[{\"id\":\"关注服务号\",\"action\":\"close_btn\"}]}"
	},
	{
		"232580377": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"scratch_show_view\",\"action\":\"scratch_close_float\"},{\"id\":\"push_content\",\"action\":\"push_remind_close\"},{\"id\":\"tvVersion\",\"action\":\"not_update\"},{\"id\":\"swiper_list\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"tv_sign_in\",\"action\":\"iv_sign_in_close\"},{\"id\":\"image_avatar\",\"action\":\"image_close\"},{\"id\":\"iv_tag_ad\",\"action\":\"tedium\"},{\"id\":\"feedback_general_text\",\"action\":\"不喜欢广告主\"}]}"
	},
	{
		"752555548": "{\"popup_rules\":[{\"id\":\"的广告\",\"action\":\"×\"},{\"id\":\"zhConstraintLayout\",\"action\":\"dismiss\"}]}"
	},
	{
		"238075641": "{\"popup_rules\":[{\"id\":\"iv_image\",\"action\":\"close\"},{\"id\":\"iv_listitem_image\",\"action\":\"iv_list_item_dislike\"},{\"id\":\"不感兴趣&无法关闭&举报广告\",\"action\":\"不感兴趣\"},{\"id\":\"look_reward\",\"action\":\"reject\"}]}"
	},
	{
		"953551389": "{\"popup_rules\":[{\"id\":\"使用您的位置\",\"action\":\"暂不\"}]}"
	},
	{
		"1388849156": "{\"popup_rules\":[{\"id\":\"V&立即升级\",\"action\":\"arg\"},{\"id\":\"授权微信通知\",\"action\":\"arg\"},{\"id\":\"会员随机现金奖励\",\"action\":\"狠心放弃\"},{\"id\":\"添加智行桌面小组件\",\"action\":\"arg\"},{\"id\":\"手机定位服务或定位权限未开启\",\"action\":\"arg\"}]}"
	},
	{
		"-662871885": "{\"popup_rules\":[{\"id\":\"更新提示\",\"action\":\"取消\"}]}"
	},
	{
		"-822811590": "{\"popup_rules\":[{\"id\":\"item_channel_item_title\",\"action\":\"item_channel_item_close\",\"times\":5},{\"id\":\"item_channel_item_image_layout\",\"action\":\"item_channel_item_close\",\"times\":5}]}"
	},
	{
		"-1979924692": "{\"popup_rules\":[{\"id\":\"tv_join\",\"action\":\"iv_cancle\"}]}"
	},
	{
		"644871869": "{\"popup_rules\":[{\"id\":\"update_title\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"947418797": "{\"popup_rules\":[{\"id\":\"banner\",\"action\":\"close_btn\"}]}"
	},
	{
		"-76821059": "{\"popup_rules\":[{\"id\":\"开启通知服务\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"明日来领&金币\",\"action\":\"我知道了\"}]}"
	},
	{
		"101952197": "{\"popup_rules\":[{\"id\":\"btn_open_notify\",\"action\":\"not_open_notify\"}]}"
	},
	{
		"-54547863": "{\"popup_rules\":[{\"id\":\"显示通知\",\"action\":\"取消授权\"},{\"id\":\"ivAdv\",\"action\":\"ivClose\"}]}"
	},
	{
		"1855462465": "{\"popup_rules\":[{\"id\":\"浮层内部图片\",\"action\":\"浮层关闭按钮\"},{\"id\":\"热区\",\"action\":\"关闭按钮\"},{\"id\":\"限时福利砸中你\",\"action\":\"关闭按钮\"}]}"
	},
	{
		"2016444138": "{\"popup_rules\":[{\"id\":\"看视频领取&会员权益\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"1380298910": "{\"popup_rules\":[{\"id\":\"立即升级\",\"action\":\"稍后再说\"},{\"id\":\"bud\",\"action\":\"bud\"}]}"
	},
	{
		"-1717626045": "{\"popup_rules\":[{\"id\":\"pay_vip_bt\",\"action\":\"close_bt\"},{\"id\":\"new_user_promotion_card\",\"action\":\"icon_close_button\"},{\"id\":\"完善资料领&VIP\",\"action\":\"iv_close\"},{\"id\":\"vip_retain_window_iv\",\"action\":\"close_button\"}]}"
	},
	{
		"-1556709909": "{\"popup_rules\":[{\"id\":\"supportBt\",\"action\":\"closeBt\"}]}"
	},
	{
		"-1447059102": "{\"popup_rules\":[{\"id\":\"img_ads\",\"action\":\"iv_close\"},{\"id\":\"float_ad_img\",\"action\":\"close_float_ad_img\"},{\"id\":\"video_view\",\"action\":\"iv_close\"}]}"
	},
	{
		"-1109425407": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"取消\"}]}"
	},
	{
		"345365066": "{\"popup_rules\":[{\"id\":\"新人签到礼\",\"action\":\"close_btn\"},{\"id\":\"打开通知权限\",\"action\":\"再考虑下\"},{\"id\":\"百度文库&评分\",\"action\":\"score_close\"},{\"id\":\"开启消息通知\",\"action\":\"close_btn\"},{\"id\":\"limit-red-packet-img-title\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"read_gif_iv\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"act_style_content_bg_iv\",\"action\":\"act_style_iv_close\"}]}"
	},
	{
		"-1255577144": "{\"popup_rules\":[{\"id\":\"青少年保护\",\"action\":\"okButton\"},{\"id\":\"关注&公众号\",\"action\":\"残忍拒绝\"}]}"
	},
	{
		"-156204975": "{\"popup_rules\":[{\"id\":\"live_update_title\",\"action\":\"live_update_close_img\"},{\"id\":\"青少年守护\",\"action\":\"iknow_alert_dialog_button2\"},{\"id\":\"live_ad_dialog_image\",\"action\":\"live_ad_dialog_close\"}]}"
	},
	{
		"-1502821745": "{\"popup_rules\":[{\"id\":\"单车&天骑&单&立即领取\",\"action\":\"actionDialogClose\"},{\"id\":\"hbDialogLayout\",\"action\":\"actionDialogClose\"},{\"id\":\"gENrrooPRRSKS2nmR644j\",\"action\":\"gENrrooPRRSKS2nmR644j\"},{\"id\":\"resize,w_933\",\"action\":\"OcAed8BaQIDrlsAAAAASUVORK5CYII=\"}]}"
	},
	{
		"132785423": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"iv_cancel\"},{\"id\":\"开启&通知\",\"action\":\"暂不开启\"},{\"id\":\"签到成功\",\"action\":\"iv_close\"}]}"
	},
	{
		"195266379": "{\"popup_rules\":[{\"id\":\"你收到一个现金红包\",\"action\":\"blb\"},{\"id\":\"开启推送通知，及时获取互动消息\",\"action\":\"关闭\"},{\"id\":\"授权抖音朋友\",\"action\":\"拒绝\"}]}"
	},
	{
		"-2086095549": "{\"popup_rules\":[{\"id\":\"版本更新\",\"action\":\"取消\"}]}"
	},
	{
		"-1079643320": "{\"popup_rules\":[{\"id\":\"抽奖机会\",\"action\":\"放弃福利\"},{\"id\":\"1分钟小调研\",\"action\":\"iv_cancel\"},{\"id\":\"应用内更新权限\",\"action\":\"buttonDefaultNegative\"}]}"
	},
	{
		"473713875": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"你可能感兴趣的人\",\"action\":\"关闭\"}]}"
	},
	{
		"497239884": "{\"popup_rules\":[{\"id\":\"开启系统通知\",\"action\":\"暂不开启\"}]}"
	},
	{
		"-945730221": "{\"popup_rules\":[{\"id\":\"open_notification_button\",\"action\":\"close_image_view\"},{\"id\":\"location_tip_tv\",\"action\":\"location_tip_close\"}]}"
	},
	{
		"-1657078324": "{\"popup_rules\":[{\"id\":\"新版本\",\"action\":\"tv_update_after\"}]}"
	},
	{
		"1791072826": "{\"popup_rules\":[{\"id\":\"百度网盘更新啦\",\"action\":\"下次再说\"},{\"id\":\"开启消息通知\",\"action\":\"dialog_cancel\"},{\"id\":\"banner_item_close\",\"action\":\"banner_item_close\"},{\"id\":\"close\",\"action\":\"close\"},{\"id\":\"close_clean_guide\",\"action\":\"close_clean_guide\"},{\"id\":\"close_notification_tip\",\"action\":\"close_notification_tip\"},{\"id\":\"iv_yike_close\",\"action\":\"iv_yike_close\"},{\"id\":\"yike_guide_exit\",\"action\":\"yike_guide_exit\"},{\"id\":\"cl_content\",\"action\":\"iv_close\"}]}"
	},
	{
		"-528715135": "{\"popup_rules\":[{\"id\":\"teenagers_desc\",\"action\":\"teenagers_i_know_layout\"}]}"
	},
	{
		"-2069018544": "{\"popup_rules\":[{\"id\":\"尚未设置安全问题验证\",\"action\":\"iv_close\"},{\"id\":\"大学生兼职安全试炼题\",\"action\":\"还是算了\"}]}"
	},
	{
		"255610818": "{\"popup_rules\":[{\"id\":\"第一桶金\",\"action\":\"img_close\"},{\"id\":\"line_push\",\"action\":\"img_push_close\"},{\"id\":\"恭喜获得现金\",\"action\":\"img_close\"}]}"
	},
	{
		"2123438483": "{\"popup_rules\":[{\"id\":\"iv_coupon\",\"action\":\"iv_close\"}]}"
	},
	{
		"-146860486": "{\"popup_rules\":[{\"id\":\"点击成为VIP，立享高级功能\",\"action\":\"close_btn\"},{\"id\":\"获取地理位置\",\"action\":\"dialog_close\"}]}"
	},
	{
		"-1606001344": "{\"popup_rules\":[{\"id\":\"playing_tv_redeem_title\",\"action\":\"playing_ic_close\"}]}"
	},
	{
		"325847140": "{\"popup_rules\":[{\"id\":\"打开推送通知\",\"action\":\"不允许\"}]}"
	},
	{
		"-69877540": "{\"popup_rules\":[{\"id\":\"新版本&升级\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"感兴趣商品再试一件\",\"action\":\"关闭弹窗\"},{\"id\":\"专属现金红包\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"每日签到得现金\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"满&元可用&优惠券\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"你的专属&福利\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"-84768776": "{\"popup_rules\":[{\"id\":\"立即提现\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"马上领取\",\"action\":\"残忍退出\"}]}"
	},
	{
		"-612834190": "{\"popup_rules\":[{\"id\":\"关闭弹框按钮\",\"action\":\"关闭弹框按钮\"},]}"
	},
	{
		"-894368837": "{\"popup_rules\":[{\"id\":\"开启超级保险箱\",\"action\":\"close\"},{\"id\":\"touch_bottom_bar_bubble_main_title_tv\",\"action\":\"touch_bottom_bar_bubble_close_iv\"},{\"id\":\"touch_dlg_main_title_tv\",\"action\":\"touch_dlg_close_iv\"},{\"id\":\"touch_dlg_main_title_tv\",\"action\":\"close_btn\"},{\"id\":\"移动积分别浪费，迅雷会员抢先兑\",\"action\":\"放弃支付\"},{\"id\":\"老用户专属，劲爆惊喜价\",\"action\":\"放弃优惠\"},{\"id\":\"xl_download_guide_tip_close\",\"action\":\"xl_download_guide_tip_close\"},{\"id\":\"close-circle\",\"action\":\"close-circle\"},{\"id\":\"签到成功\",\"action\":\"知道了\"},{\"id\":\"tv_notification_title\",\"action\":\"iv_notification_tips_close\"},{\"id\":\"立即签到\",\"action\":\"iv_close\"},{\"id\":\"hermes_ad_banner_recycler\",\"action\":\"hermes_ad_banner_negative\"},{\"id\":\"feedback_not_interested_text\",\"action\":\"不感兴趣\"}]}"
	},
	{
		"-1781124388": "{\"popup_rules\":[{\"id\":\"tv_notify_title\",\"action\":\"iv_close\"},{\"id\":\"签到&天&获得&车币\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"开启消息推送\",\"action\":\"iv_close\"}]}"
	},
	{
		"1197124177": "{\"popup_rules\":[{\"id\":\"tm_ad_page_tips_text\",\"action\":\"tm_ad_page_tips_close\"}]}"
	},
	{
		"1620159901": "{\"popup_rules\":[{\"id\":\"tv_chat_top_bar_notice_text\",\"action\":\"iv_top_bar_close_icon\"},{\"id\":\"iv_action_icon\",\"action\":\"iv_close\"},{\"id\":\"tv_submersible_recall_title\",\"action\":\"关闭\"}]}"
	},
	{
		"884834226": "{\"popup_rules\":[{\"id\":\"own_render_ad_icon\",\"action\":\"close_render_ad\"}]}"
	},
	{
		"1589164968": "{\"popup_rules\":[{\"id\":\"ivClose\",\"action\":\"ivClose\"}]}"
	},
	{
		"495814814": "{\"popup_rules\":[{\"id\":\"设置未成年人模式\",\"action\":\"我知道了\"},{\"id\":\"imgCloseHomePageDialog\",\"action\":\"imgCloseHomePageDialog\"},{\"id\":\"让我们提醒你运动\",\"action\":\"暂不需要\"}]}"
	},
	{
		"1773314214": "{\"popup_rules\":[{\"id\":\"权限申请\",\"action\":\"取消\"}]}"
	},
	{
		"-807718193": "{\"popup_rules\":[{\"id\":\"rl_banner_close\",\"action\":\"rl_banner_close\"},{\"id\":\"iv_ignore\",\"action\":\"iv_ignore\"},{\"id\":\"ivHomeIndexItemNearbyClose\",\"action\":\"ivHomeIndexItemNearbyClose\"}]}"
	},
	{
		"-1531462240": "{\"popup_rules\":[{\"id\":\"ad_icon\",\"action\":\"closeAd\"}]}"
	},
	{
		"5992780": "{\"popup_rules\":[{\"id\":\"支持 RAR 开发\",\"action\":\"放弃\"}]}"
	},
	{
		"1868020298": "{\"popup_rules\":[{\"id\":\"upgrade_title\",\"action\":\"bn_cancel\"},{\"id\":\"开启&通知\",\"action\":\"不要福利\"},{\"id\":\"view_pager\",\"action\":\"iv_close\"},{\"id\":\"iv_logo\",\"action\":\"iv_close\"},{\"id\":\"viewpager\",\"action\":\"iv_home_delete\"},{\"id\":\"马上领取\",\"action\":\"暂不需要\"},{\"id\":\"view_flipper\",\"action\":\"close_iv\"}]}"
	},
	{
		"-2116363580": "{\"popup_rules\":[{\"id\":\"立即更新\",\"action\":\"negativeButton\"},{\"id\":\"内容推荐服务\",\"action\":\"以后再说\"}]}"
	},
	{
		"300761806": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"giftPackImg\",\"action\":\"closeImg\"},{\"id\":\"sign_bg\",\"action\":\"signClose\"}]}"
	},
	{
		"1644138715": "{\"popup_rules\":[{\"id\":\"为你推荐\",\"action\":\"jkr\"},{\"id\":\"不再显示推荐电台\",\"action\":\"关闭推荐\"}]}"
	},
	{
		"188162078": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"common_dialog_ok_btn\"}]}"
	},
	{
		"1314748790": "{\"popup_rules\":[{\"id\":\"update_dlg_title\",\"action\":\"tvCancel\"},{\"id\":\"开启消息通知权限\",\"action\":\"暂不开启\"},{\"id\":\"index_drag_ad_iv\",\"action\":\"index_drag_ad_iv_close\"},{\"id\":\"banner\",\"action\":\"close_banner\"}]}"
	},
	{
		"1511326008": "{\"popup_rules\":[{\"id\":\"打开通知功能\",\"action\":\"取消\"},{\"id\":\"pic\",\"action\":\"close\"}]}"
	},
	{
		"-1943382780": "{\"popup_rules\":[{\"id\":\"新人礼包\",\"action\":\"ezz\"},{\"id\":\"d6f\",\"action\":\"ba3\"},{\"id\":\"测一测可赚收益\",\"action\":\"ba9\"},{\"id\":\"开启推送通知\",\"action\":\"dqp\"},{\"id\":\"限时补贴券\",\"action\":\"ba5\"},{\"id\":\"请开启转转消息通知\",\"action\":\"知道了\"}]}"
	},
	{
		"-920735187": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"开启推送\",\"action\":\"closeBtn\"},{\"id\":\"新人专属大礼包\",\"action\":\"ivClose\"},{\"id\":\"参加新人活动&免费领点币\",\"action\":\"ivClose\"},{\"id\":\"ivAd\",\"action\":\"ivAdClose\"},{\"id\":\"imgBKT\",\"action\":\"imgClose\"},{\"id\":\"开启推送\",\"action\":\"ivClose\"},{\"id\":\"签到成功&获得&章节卡碎片\",\"action\":\"fClose\"},{\"id\":\"签到&天\",\"action\":\"fClose\"},{\"id\":\"newAudioDialogTvTitle\",\"action\":\"newAudioDialogNoPicCloseBtn\"}]}"
	},
	{
		"-360330826": "{\"popup_rules\":[{\"id\":\"青少年守护计划\",\"action\":\"已满14周岁\"}]}"
	},
	{
		"949069732": "{\"popup_rules\":[{\"id\":\"番茄发来的红包\",\"action\":\"f\"},{\"id\":\"buo\",\"action\":\"buo\"},{\"id\":\"c55\",\"action\":\"c56\"}]}"
	},
	{
		"810513273": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"确定\"}]}"
	},
	{
		"1575109845": "{\"popup_rules\":[{\"id\":\"开启系统通知\",\"action\":\"iv_close\"}]}"
	},
	{
		"1539906291": "{\"popup_rules\":[{\"id\":\"tt_splash_ad_logo\",\"action\":\"tt_splash_skip_btn\"}]}"
	},
	{
		"-862766679": "{\"popup_rules\":[{\"id\":\"青少年守护计划\",\"action\":\"已满14周岁\"},{\"id\":\"banner_image\",\"action\":\"iv_close\"},{\"id\":\"iv_float_icon\",\"action\":\"iv_float_close\"},{\"id\":\"appraise_positive_btn\",\"action\":\"appraise_cancel_btn\"},{\"id\":\"popWindowPic\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"-2119218027": "{\"popup_rules\":[{\"id\":\"设置最右消息通知类型\",\"action\":\"暂不开启\"},{\"id\":\"lottie_view\",\"action\":\"iv_delete\"},{\"id\":\"+开启通知\",\"action\":\"tips_close\"},{\"id\":\"账号绑定手机号可以提升安全性\",\"action\":\"btn_close\"}]}"
	},
	{
		"630814885": "{\"popup_rules\":[{\"id\":\"rl_center\",\"action\":\"iv_close\"},{\"id\":\"iv_news\",\"action\":\"iv_close\"},{\"id\":\"开启消息通知\",\"action\":\"iv_tip_close\"}]}"
	},
	{
		"-759128068": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"ivClose\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"tvBottomFloatViewDesc\",\"action\":\"ivBottomFloatViewClose\"},{\"id\":\"奖品免费包邮到家\",\"action\":\"放弃领取\"},{\"id\":\"你可能感兴趣的人\",\"action\":\"ivRemove\",\"times\":5},{\"id\":\"anim_view\",\"action\":\"closeIcon\"},{\"id\":\"新人超值好物\",\"action\":\"ivClose\"},{\"id\":\"新人限时福利\",\"action\":\"ivClose\"}]}"
	},
	{
		"-1692253156": "{\"popup_rules\":[{\"id\":\"novelad_banner_ad_text\",\"action\":\"novel_banner_ad_close\"},{\"id\":\"lottieAnimationView\",\"action\":\"关闭弹层\"}]}"
	},
	{
		"1890818956": "{\"popup_rules\":[{\"id\":\"开启新消息通知\",\"action\":\"取消\"}]}"
	},
	{
		"-1637701853": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"以后再说\"},{\"id\":\"儿童模式\",\"action\":\"知道了\"},{\"id\":\"开启重要消息通知\",\"action\":\"以后再说\"}]}"
	},
	{
		"-660055062": "{\"popup_rules\":[{\"id\":\"tv_authorize_dlg_title\",\"action\":\"btn_close_auth_dlg\"},{\"id\":\"tv_location_title\",\"action\":\"iv_location_close\"}]}"
	},
	{
		"-103524201": "{\"popup_rules\":[{\"id\":\"vp_guide_add\",\"action\":\"iv_close\"},{\"id\":\"开启要闻通知\",\"action\":\"忽略\"}]}"
	},
	{
		"-1979578047": "{\"popup_rules\":[{\"id\":\"ad_title\",\"action\":\"ad_close\"}]}"
	},
	{
		"891862624": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"不开启\"},{\"id\":\"iv_vip_order_tip\",\"action\":\"iv_vip_order_close\"},{\"id\":\"gdt_media_view\",\"action\":\"gdt_btn_close\"}]}"
	},
	{
		"1661249612": "{\"popup_rules\":[{\"id\":\"升级到最新版本\",\"action\":\"img_close\"},{\"id\":\"查看青少年模式\",\"action\":\"知道了\"},{\"id\":\"设置引力签\",\"action\":\"关闭弹窗\"}]}"
	},
	{
		"157540905": "{\"popup_rules\":[{\"id\":\"tt_ad_logo\",\"action\":\"tt_video_ad_close_layout\"},{\"id\":\"tt_bu_title\",\"action\":\"tt_bu_close\"},{\"id\":\"不感兴趣&举报广告\",\"action\":\"不感兴趣\"}]}"
	},
	{
		"-1623425929": "{\"popup_rules\":[{\"id\":\"更新消息\",\"action\":\"vision_btn_cancel\"}]}"
	},
	{
		"1337821420": "{\"popup_rules\":[{\"id\":\"请开启消息通知\",\"action\":\"暂不开启\"}]}"
	},
	{
		"321803898": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"-1930986565": "{\"popup_rules\":[{\"id\":\"新版本\",\"action\":\"dialog_pic_close\"}]}"
	},
	{
		"1185278458": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"sdv_right_bottom_pic\",\"action\":\"iv_right_bottom_close\"},{\"id\":\"sdv_big_pic\",\"action\":\"iv_big_close\"}]}"
	},
	{
		"-1500338227": "{\"popup_rules\":[{\"id\":\"tt_splash_ad_logo\",\"action\":\"tt_splash_skip_btn\"}]}"
	},
	{
		"-1969724936": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"取消\"}]}"
	},
	{
		"1662102643": "{\"popup_rules\":[{\"id\":\"更新提示\",\"action\":\"取消\"},{\"id\":\"应用升级提醒\",\"action\":\"取消\"}]}"
	},
	{
		"1546297161": "{\"popup_rules\":[{\"id\":\"iv_right_bottom_ad\",\"action\":\"iv_close\"}]}"
	},
	{
		"1000776385": "{\"popup_rules\":[{\"id\":\"update_cancel\",\"action\":\"update_cancel\"},{\"id\":\"iv_body\",\"action\":\"iv_close\"},{\"id\":\"img_ad\",\"action\":\"img_ad_close\"}]}"
	},
	{
		"1667762191": "{\"popup_rules\":[{\"id\":\"日&必得&金币\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"650999717": "{\"popup_rules\":[{\"id\":\"使用此文件夹\",\"action\":\"使用此文件夹\"},{\"id\":\"要允许\",\"action\":\"允许\"}],\"unite_popup_rules\":true,\"ltt_service\":true}"
	},
	{
		"-921040269": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"-1635328017": "{\"popup_rules\":[{\"id\":\"马上升级\",\"action\":\"不再提醒\"},{\"id\":\"抢先体验&不再提醒\",\"action\":\"不再提醒\"},{\"id\":\"关闭,按钮\",\"action\":\"关闭,按钮\"},{\"id\":\"关闭新特性弹窗\",\"action\":\"关闭新特性弹窗\"},{\"id\":\"关闭按钮\",\"action\":\"关闭按钮\"}]}"
	},
	{
		"-379148275": "{\"popup_rules\":[{\"id\":\"=跳过\",\"action\":\"=跳过\"}],\"click_way_popup\":1}"
	},
	{
		"-1703768290": "{\"popup_rules\":[{\"id\":\"tv_teenager_content\",\"action\":\"btn_teenager_i_know\"},{\"id\":\"新用户专属奖励\",\"action\":\"iv_new_player_dialog_close\"},{\"id\":\"立即签到\",\"action\":\"iv_close\"},{\"id\":\"开启系统通知\",\"action\":\"close\"}]}"
	},
	{
		"-744842507": "{\"popup_rules\":[{\"id\":\"ad_container\",\"action\":\"btn_close\"},{\"id\":\"fl_container\",\"action\":\"iv_delete\"}]}"
	},
	{
		"-1731486278": "{\"popup_rules\":[{\"id\":\"iv_ad\",\"action\":\"close\"},{\"id\":\"邀您体验新版本\",\"action\":\"残忍拒绝\"},{\"id\":\"允许获取位置信息\",\"action\":\"取消\"},{\"id\":\"iv_notification_reminder_dialog\",\"action\":\"iv_notification_reminder_dialog_close\"},{\"id\":\"iv_switch\",\"action\":\"iv_skip\"},{\"id\":\"开启定位服务\",\"action\":\"暂时不了\"}]}"
	},
	{
		"-103532384": "{\"popup_rules\":[{\"id\":\"允许&发送通知\",\"action\":\"以后再说\"}]}"
	},
	{
		"-1357050264": "{\"popup_rules\":[{\"id\":\"定位服务&开启\",\"action\":\"关闭\"},{\"id\":\"活动图片\",\"action\":\"关闭\"}]}"
	},
	{
		"-918490570": "{\"popup_rules\":[{\"id\":\"tv_upgrade_title\",\"action\":\"iv_upgrade_btn_ignore\"},{\"id\":\"广告弹窗\",\"action\":\"关闭弹窗\"},{\"id\":\"共享&广告标识\",\"action\":\"不允许\"},{\"id\":\"开启通知提醒\",\"action\":\"im_feed_tip_close\"}]}"
	},
	{
		"1889695195": "{\"popup_rules\":[{\"id\":\"授权&位置信息\",\"action\":\"关闭\"}]}"
	},
	{
		"-191341086": "{\"popup_rules\":[{\"id\":\"有新版本\",\"action\":\"暂不升级\"},{\"id\":\"以后再说\",\"action\":\"以后再说\"}]}"
	},
	{
		"-1185078240": "{\"popup_rules\":[{\"id\":\"收到&现金红包\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"1836227312": "{\"popup_rules\":[{\"id\":\"iv_ads\",\"action\":\"iv_close\"}]}"
	},
	{
		"1013943789": "{\"popup_rules\":[{\"id\":\"新人&见面礼\",\"action\":\"GLOBAL_ACTION_BACK\"}]}"
	},
	{
		"1516206044": "{\"popup_rules\":[{\"id\":\"iv_head\",\"action\":\"返回首页\"},{\"id\":\"允许地理位置权限\",\"action\":\"不允许\"}]}"
	},
	{
		"-30315083": "{\"popup_rules\":[{\"id\":\"有新版本\",\"action\":\"取消\"}]}"
	},
	{
		"744792033": "{\"popup_rules\":[{\"id\":\"cancel_update\",\"action\":\"cancel_update\"},{\"id\":\"yellow_banner_close\",\"action\":\"yellow_banner_close\"},{\"id\":\"close_btn\",\"action\":\"close_btn\"},{\"id\":\"operational_activities_content_close\",\"action\":\"operational_activities_content_close\"}]}"
	},
	{
		"354525348": "{\"popup_rules\":[{\"id\":\"立即支付 解锁全部功能\",\"action\":\"下次再说\"}]}"
	},
	{
		"-530247198": "{\"popup_rules\":[{\"id\":\"=跳过\",\"action\":\"=跳过\"},{\"id\":\"gdt_ad_custom_count_down\",\"action\":\"close_button\"}]}"
	},
	{
		"515982662": "{\"popup_rules\":[{\"id\":\"开启定位权限\",\"action\":\"locate_iv_close\"},{\"id\":\"marquee\",\"action\":\"关闭\"},{\"id\":\"fortune_adv\",\"action\":\"关闭\"}]}"
	},
	{
		"-245593387": "{\"popup_rules\":[{\"id\":\"skip_other_info_tv\",\"action\":\"skip_time_change_tv\"}],\"search_times_popup\":5,\"click_way_popup\":1}"
	},
	{
		"1966418623": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"暂不升级\"}]}"
	},
	{
		"2037736697": "{\"popup_rules\":[{\"id\":\"ad_container\",\"action\":\"splash_ad_skip\"}]}"
	},
	{
		"1983218619": "{\"popup_rules\":[{\"id\":\"授权提示\",\"action\":\"拒绝\"},{\"id\":\"=数字人\",\"action\":\"=关闭\"},{\"id\":\"my_imageview\",\"action\":\"close\"}]}"
	},
	{
		"-1898417322": "{\"popup_rules\":[{\"id\":\"single_banner\",\"action\":\"close\"},{\"id\":\"=广告\",\"action\":\"closeGray\"}]}"
	},
	{
		"1391684449": "{\"popup_rules\":[{\"id\":\"tvTip\",\"action\":\"iv_guanbi\"}]}"
	},
	{
		"-103524794": "{\"popup_rules\":[{\"id\":\"立即升级\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"需要通知权限\",\"action\":\"取消\"},{\"id\":\"关闭按钮\",\"action\":\"=关闭按钮\"}],\"times\":5}"
	},
	{
		"-2002547408": "{\"popup_rules\":[{\"id\":\"新版本升级\",\"action\":\"下次提醒\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"ads_image\",\"action\":\"feedback_close\"},{\"id\":\"选择理由，优化你的广告\",\"action\":\"诱导点击\"},{\"id\":\"ads_label\",\"action\":\"feedback_close\"}]}"
	},
	{
		"2056863498": "{\"popup_rules\":[{\"id\":\"iv_content_ad\",\"action\":\"iv_close_tableScreenAd\"},{\"id\":\"iv_ad\",\"action\":\"iv_close\"},{\"id\":\"安装完整版日历\",\"action\":\"iv_close\"},{\"id\":\"iv_pic\",\"action\":\"iv_delte\"}]}"
	},
	{
		"-1161240227": "{\"popup_rules\":[{\"id\":\"upgrade_title\",\"action\":\"upgrade_cancel\"},{\"id\":\"lciv_img\",\"action\":\"lciv_close\"},{\"id\":\"开启手机定位\",\"action\":\"下次再说\"}]}"
	},
	{
		"914144235": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"知道了\"},{\"id\":\"bv7\",\"action\":\"h1_\"},{\"id\":\"开启消息通知\",\"action\":\"暂不开启\"},{\"id\":\"不&错过重要消息\",\"action\":\"fmk\"}]}"
	},
	{
		"-179660078": "{\"popup_rules\":[{\"id\":\"开启位置权限\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"notice_title_txt\",\"action\":\"notice_close_txt\"}]}"
	},
	{
		"-1865688240": "{\"popup_rules\":[{\"id\":\"view_ad_title\",\"action\":\"view_ad_close\"}]}"
	},
	{
		"-198019159": "{\"popup_rules\":[{\"id\":\"audio_vip_skip\",\"action\":\"audio_vip_close\"},{\"id\":\"item_ad_title\",\"action\":\"item_ad_close\"},{\"id\":\"mAdTitle\",\"action\":\"mAdClose\"}]}"
	},
	{
		"-1215205363": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"1254578009": "{\"popup_rules\":[{\"id\":\"立即升级\",\"action\":\"iv_close\"},{\"id\":\"版本升级\",\"action\":\"取消\"},{\"id\":\"msgbox_popup_clear\",\"action\":\"msgbox_popup_clear\"}]}"
	},
	{
		"-1895428968": "{\"popup_rules\":[{\"id\":\"=跳过\",\"action\":\"=跳过\"}]}"
	},
	{
		"1085732649": "{\"popup_rules\":[{\"id\":\"开启通知\",\"action\":\"close_btn\"},{\"id\":\"查看活动详情\",\"action\":\"关闭\"},{\"id\":\"txt_streamAd_title\",\"action\":\"ad_feedback_dots\"},{\"id\":\"关闭广告\",\"action\":\"不感兴趣\"}]}"
	},
	{
		"1744979357": "{\"popup_rules\":[{\"id\":\"rl_content\",\"action\":\"iv_vip_close\"},{\"id\":\"打开社区消息通知\",\"action\":\"iv_message_close\"}]}"
	},
	{
		"1884443122": "{\"popup_rules\":[{\"id\":\"想要读取剪切板\",\"action\":\"始终拒绝\"}]}"
	},
	{
		"-405478795": "{\"popup_rules\":[{\"id\":\"ads_imageview\",\"action\":\"btn_cancel\"},{\"id\":\"rlEnvelope\",\"action\":\"ivCancel\"}]}"
	},
	{
		"-54120092": "{\"popup_rules\":[{\"id\":\"dlg_login_guide_thanks\",\"action\":\"dlg_iv_login_guide_close\"}]}"
	},
	{
		"-532693094": "{\"popup_rules\":[{\"id\":\"=更新\",\"action\":\"=取消\"}]}"
	},
	{
		"1937929252": "{\"popup_rules\":[{\"id\":\"adv_mask_container\",\"action\":\"close_btn\"},{\"id\":\"operating_activity_entrance\",\"action\":\"operating_activity_close\"},{\"id\":\"开启消息通知\",\"action\":\"close\"},{\"id\":\"打开消息通知\",\"action\":\"close_im\"}]}"
	},
	{
		"-1046965711": "{\"popup_rules\":[{\"id\":\"体验 Google Play Pass，免费试用 1 个月\",\"action\":\"以后再说\"}]}"
	},
	{
		"-874484145": "{\"popup_rules\":[{\"id\":\"index_pop_img\",\"action\":\"img_cancel\"},{\"id\":\"打开推送通知\",\"action\":\"iv_close_notification_alert\"},{\"id\":\"tv_notif\",\"action\":\"iv_close\"}]}"
	},
	{
		"-1161217159": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"id_back_img\",\"action\":\"id_close_btn\"},{\"id\":\"打开通知\",\"action\":\"iv_close\"}]}"
	},
	{
		"641733616": "{\"popup_rules\":[{\"id\":\"版本更新\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"开启通知\",\"action\":\"不再提示\"},{\"id\":\"tv_text_match\",\"action\":\"iv_heart_match_x\"},{\"id\":\"定位权限\",\"action\":\"拒绝\"},{\"id\":\"iv_gift_info\",\"action\":\"iv_close\"}]}"
	},
	{
		"-1830100133": "{\"popup_rules\":[{\"id\":\"开启消息通知\",\"action\":\"再想想\"},{\"id\":\"lottery_popup_view_img\",\"action\":\"lottery_popup_view_close\"}]}"
	},
	{
		"-91332804": "{\"popup_rules\":[{\"id\":\"开启推送通知\",\"action\":\"下次再说\"}]}"
	},
	{
		"1144086404": "{\"popup_rules\":[{\"id\":\"updateVersionTitle\",\"action\":\"md_dialog_cm_close_btn\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"1557402977": "{\"popup_rules\":[{\"id\":\"开启消息通知权限\",\"action\":\"取消\"}]}"
	},
	{
		"1994036591": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"ic_notice\",\"action\":\"ic_action\"},{\"id\":\"=广告\",\"action\":\"more_icon\"},{\"id\":\"屏蔽广告\",\"action\":\"不感兴趣\"},{\"id\":\"+会员购\",\"action\":\"more_icon\"},{\"id\":\"屏蔽推广\",\"action\":\"不感兴趣\"},{\"id\":\"corner_hint\",\"action\":\"more_icon\"}]}"
	},
	{
		"1657185137": "{\"popup_rules\":[{\"id\":\"新版本\",\"action\":\"忽略\"}]}"
	},
	{
		"-1534473421": "{\"popup_rules\":[{\"id\":\"clean_adv_image\",\"action\":\"iv_close\"},{\"id\":\"iv\",\"action\":\"iv_cancel\"}]}"
	},
	{
		"-2092209424": "{\"popup_rules\":[{\"id\":\"青少年守护\",\"action\":\"已满14岁\"},{\"id\":\"开启消息推送通知\",\"action\":\"close_img\"}]}"
	},
	{
		"-1346391036": "{\"popup_rules\":[{\"id\":\"mUpgradeTitle\",\"action\":\"mUpgradeDialogCancel\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"开启消息推送\",\"action\":\"closeIv\"}]}"
	},
	{
		"2049668591": "{\"popup_rules\":[{\"id\":\"closeButtonIcon\",\"action\":\"closeButtonIcon\"},{\"id\":\"推荐广告\",\"action\":\"关闭\"}]}"
	},
	{
		"1651531703": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"img_cancle\"},{\"id\":\"dialog_teenager_tv_tip\",\"action\":\"dialog_teenager_tv_iKnow\"},{\"id\":\"newVipUser_tv_tip\",\"action\":\"main_newVipUser_close\"},{\"id\":\"开通消息通知\",\"action\":\"iv_close\"},{\"id\":\"签到成功\",\"action\":\"iv_close\"},{\"id\":\"image_ad\",\"action\":\"iv_close\"}]}"
	},
	{
		"-2145732654": "{\"popup_rules\":[{\"id\":\"home_ad_image\",\"action\":\"home_ad_close\"}]}"
	},
	{
		"-1513662963": "{\"popup_rules\":[{\"id\":\"next_points_tv\",\"action\":\"close_iv\"},{\"id\":\"flow_qxb_we_chat_src_iv\",\"action\":\"flow_qxb_we_chat_close_iv\"}]}"
	},
	{
		"886316827": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"cancel\"},{\"id\":\"开启推送通知\",\"action\":\"取消\"}]}"
	},
	{
		"2138010815": "{\"popup_rules\":[{\"id\":\"青少年守护模式\",\"action\":\"我知道了\"},{\"id\":\"notification_tip_container\",\"action\":\"close_notification_bar\"},{\"id\":\"打开推送\",\"action\":\"close_btn\"}]}"
	},
	{
		"841170930": "{\"popup_rules\":[{\"id\":\"iv_suspend\",\"action\":\"iv_page_suspend_close\"}]}"
	},
	{
		"1659293491": "{\"popup_rules\":[{\"id\":\"reminder_push_guide_tv\",\"action\":\"reminder_push_guide_close\"},{\"id\":\"你可能感兴趣的人\",\"action\":\"关闭\"}]}"
	},
	{
		"-1839413884": "{\"popup_rules\":[{\"id\":\"interact_ad_root\",\"action\":\"iv_close\"}]}"
	},
	{
		"-1892077856": "{\"popup_rules\":[{\"id\":\"检测到新版本\",\"action\":\"取消\"},{\"id\":\"banner_ad\",\"action\":\"iv_ad_close\"}]}"
	},
	{
		"1827421494": "{\"popup_rules\":[{\"id\":\"iv_ad_img\",\"action\":\"iv_close\"},{\"id\":\"开启消息提醒\",\"action\":\"取消\"},{\"id\":\"tv_tips_indexNoticeMsgFragment\",\"action\":\"iv_tipsClose_indexNoticeMsgFragment\"}]}"
	},
	{
		"460049591": "{\"popup_rules\":[{\"id\":\"开启青少年模式\",\"action\":\"知道了\"}]}"
	},
	{
		"1335515207": "{\"popup_rules\":[{\"id\":\"开启消息通知\",\"action\":\"icft_close\"}]}"
	},
	{
		"1014178734": "{\"popup_rules\":[{\"id\":\"msAdView\",\"action\":\"ams_icon_single_close\"}]}"
	},
	{
		"1175536078": "{\"popup_rules\":[{\"id\":\"签到领取奖励\",\"action\":\"GLOBAL_ACTION_BACK\"},{\"id\":\"=下载\",\"action\":\"enu\"},{\"id\":\"推送通知&开启\",\"action\":\"apt\"}]}"
	},
	{
		"1620268914": "{\"popup_rules\":[{\"id\":\"版本升级\",\"action\":\"忽略\"}]}"
	},
	{
		"1238325805": "{\"popup_rules\":[{\"id\":\"发现新版本\",\"action\":\"btn_dismiss\"},{\"id\":\"青少年模式\",\"action\":\"iv_close\"},{\"id\":\"iv_close_icon\",\"action\":\"iv_close_icon\"}]}"
	},
	{
		"265439280": "{\"popup_rules\":[{\"id\":\"青少年守护\",\"action\":\"已满18周岁\"},{\"id\":\"打开通知\",\"action\":\"取消\"}]}"
	},
	{
		"-1367717479": "{\"popup_rules\":[{\"id\":\"开启通知\",\"action\":\"close_tip_btn\"}]}"
	},
	{
		"-629891177": "{\"popup_rules\":[{\"id\":\"开启位置权限\",\"action\":\"取消\"}]}"
	},
	{
		"1056984291": "{\"popup_rules\":[{\"id\":\"update_content\",\"action\":\"image_cancel\"},{\"id\":\"iv_notice\",\"action\":\"ib_close\"}]}"
	},
	{
		"978047406": "{\"popup_rules\":[{\"id\":\"+开启定位\",\"action\":\"qmapapi_guide_close\"},{\"id\":\"h_explore_rn|NewPopUp|DrawLotteryPopup|Touchable\",\"action\":\"h_explore_rn|NewPopUp|DrawLotteryPopup|Touchable\"}]}"
	},
	{
		"-248012079": "{\"popup_rules\":[{\"id\":\"tv_version\",\"action\":\"下次再说\"},{\"id\":\"开启通知\",\"action\":\"iv_close\"},{\"id\":\"打开消息推送\",\"action\":\"ivClose\"}]}"
	},
	{
		"-396646979": "{\"popup_rules\":[{\"id\":\"umeng_update_id_ok\",\"action\":\"umeng_update_id_cancel\"},{\"id\":\"青少年模式\",\"action\":\"我知道了\"}]}"
	},
	{
		"2128193854": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"知道了\"}]}"
	},
	{
		"1659335438": "{\"popup_rules\":[{\"id\":\"iv_drop_cnl_close\",\"action\":\"iv_drop_cnl_close\"},{\"id\":\"共享文件夹\",\"action\":\"稍后再说\"}]}"
	},
	{
		"-1163495604": "{\"popup_rules\":[{\"id\":\"打开通知\",\"action\":\"new_user_download_right_view\"}]}"
	},
	{
		"1751022005": "{\"popup_rules\":[{\"id\":\"系统公告\",\"action\":\"确定\"}]}"
	},
	{
		"1268902986": "{\"popup_rules\":[{\"id\":\"系统位置服务未开启\",\"action\":\"iv_image_close\"}]}"
	},
	{
		"-506597855": "{\"popup_rules\":[{\"id\":\"版本更新\",\"action\":\"取消\"}]}"
	},
	{
		"-133843480": "{\"popup_rules\":[{\"id\":\"clean_adv_image\",\"action\":\"iv_close\"},{\"id\":\"main_image_600x400\",\"action\":\"close\"},{\"id\":\"确定放弃VIP会员\",\"action\":\"close\"}]}"
	},
	{
		"559984781": "{\"popup_rules\":[{\"id\":\"iv_delete\",\"action\":\"iv_delete\"}]}"
	},
	{
		"1305029671": "{\"popup_rules\":[{\"id\":\"版本更新\",\"action\":\"关闭\"},{\"id\":\"签到成功\",\"action\":\"关闭\"}]}"
	},
	{
		"-1846921724": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"iv_dialog_main_activity_bg\",\"action\":\"iv_dialog_main_activity_close\"},{\"id\":\"radiance\",\"action\":\"iv_dialog_live_room_gift_bag_close\"}]}"
	},
	{
		"-2061428528": "{\"popup_rules\":[{\"id\":\"rl_ad_container\",\"action\":\"iv_clear\"}]}"
	},
	{
		"93910113": "{\"popup_rules\":[{\"id\":\"layout_gift\",\"action\":\"iv_close\"},{\"id\":\"iv_notify\",\"action\":\"iv_close\"}]}"
	},
	{
		"-1670877294": "{\"popup_rules\":[{\"id\":\"新版试用\",\"action\":\"取消\"},{\"id\":\"ad_download\",\"action\":\"ad_not_interest\"},{\"id\":\"不感兴趣&投诉\",\"action\":\"不感兴趣\"},{\"id\":\"push_tip_title\",\"action\":\"close_tip\"},{\"id\":\"ad_header_new\",\"action\":\"menu_item\"}]}"
	},
	{
		"1076661718": "{\"popup_rules\":[{\"id\":\"版本更新\",\"action\":\"暂不更新\"}]}"
	},
	{
		"555434215": "{\"popup_rules\":[{\"id\":\"权限申请说明\",\"action\":\"不同意\"},{\"id\":\"权限申请说明\",\"action\":\"我知道了\"},{\"id\":\"img_bg_header\",\"action\":\"img_close\"},{\"id\":\"txt_client_top_location_guide_title\",\"action\":\"client_top_location_guide_cancel\"},{\"id\":\"contact_post_guide_layout_contact\",\"action\":\"contact_post_guide_img_close\"},{\"id\":\"开启消息通知\",\"action\":\"✕\"},{\"id\":\"ll_wechat_bind_layout\",\"action\":\"iv_wechat_bind_close\"},{\"id\":\"img_bg\",\"action\":\"img_close\"},{\"id\":\"完善个人信息\",\"action\":\"iv_dtl_dialog_close\"}]}"
	},
	{
		"-1048697214": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"viewClose\",\"action\":\"viewClose\"},{\"id\":\"fl_video\",\"action\":\"iv_highlight_close\"}]}"
	},
	{
		"1358411530": "{\"popup_rules\":[{\"id\":\"青少年模式\",\"action\":\"我知道了\"},{\"id\":\"新人福利\",\"action\":\"close\"},{\"id\":\"打开推送提醒\",\"action\":\"关闭\"}]}"
	},
	{
		"1309104121": "{\"popup_rules\":[{\"id\":\"立即升级\",\"action\":\"关闭\"}]}"
	},
	{
		"-34617839": "{\"popup_rules\":[{\"id\":\"开启定位权限\",\"action\":\"img_close\"},{\"id\":\"想获取您的位置信息\",\"action\":\"不允许\"}]}"
	}
]


