# Eiko的Arch Linux安装检查表owo

Arch Linux就像开飞机，安装Arch Linux就像组装一个你自己的飞机！owo
简单介绍一下Arch Linux的特性：

1. Minimal, 和一般的系统安装时会为你选择预装的软件包不同，arch linux不会为你预装任何软件包，只会给你安装诸如linux kernel和systemd等必要的系统组件。你需要在这个最小的空系统上面做加法，只安装自己选择的软件，自己需要的软件，组装完全属于你自己的操作系统！owo 这会使得你的系统没有臃肿而用不到的组件，消耗最少的资源并具有最快的速度。

2. Modernity, Arch Linux使用滚动更新来维护所有的软件包，这意味着它没有大的版本号，不存在Windows 8, 10, 11这样的大版本更新，而是通过一种连续，频繁，微小的方式对每个软件包进行更新。这使得Arch Linux就像一艘连续运行并且不断更新零件的船，你的系统会处于一种可控(更新完全是手动的，不存在强制更新owo)并连续的变化过程中owo. 这样做的优点有：所有的软件，驱动等都是最新的，你可以享受到最新的功能，最新优化，bug fix, security fix. 缺点：不断更新和发生变化的系统注定不是”最稳定“的，比如新的软件更新可能引入了新的bug，或者出现了配置变化等。因此你应该具有一定系统维护的能力(只要你愿意，你可以在这个过程中学习和锻炼哦！owo)

3. Simplicity, Arch Linux对各软件包只做最少的修改，其哲学是将各系统的原始接口和原始能量直接交给你。你能够发挥出系统和软件的原始且强大的能量owo，体会Linux的野性魅力！

因此，Arch Linux的优点有：

* 速度快，资源消耗少

* 轻松获取最新的软件和驱动

* 灵活，自定义程度非常高，你可以用自己的想法打造一个完全属于你自己的系统

* 有大量学习和锻炼的机会

* AUR上几乎有你想要的所有软件

* 有一个非常好的Wiki，你可以在这里找到几乎所有你想要的信息

缺点：

* 滚动更新模型注定了这类系统有一定的不稳定性，需要你时常更新系统以及对系统有一定的系统维护能力

* 从0开始安装和配置过程可能会比较复杂，需要一定的学习和耐心

如果稳定性是你的第一考量，你可以选择Debian系的系统owo! 对初学者友好的有Linux Mint, Pop!_OS, Ubuntu等。更专业一些的用户可以选择Debian, Fedora等。

使用Arch Linux，我相信你可以体会，学习和发挥Linux的最原始和最强大的力量～

本检查表相对于Arch Linux Wiki的安装指南

* 更加简单直接。相比之下Arch Linux的安装指南更加适合熟练的用户，其内容更加具有一般性，假设更少。

* 在关键的节点提示用户进行检查和常见的可能错误。

* 使用label来标记分区，大大降低了用户在分区时出现错误挂载的可能性。

另一方面这个检查表也是我个人的reference! owo

## 安装前检查

1. 如果要安装双系统，确认你已经在windows中通过磁盘管理工具释放了足够的空间，或者为安装新系统插入了一块新的磁盘。

2. 从[Arch Linux官网](https://www.archlinux.org/download/)下载最新的ISO镜像。通过Rufus, Ventoy，cp等工具制作启动U盘。

3. 打开Arch Linux Wiki的[安装指南](https://wiki.archlinux.org/title/Installation_guide)。

4. 确保你能使用有线网络或者Wi-Fi网络连接。连接eduroam可能不太方便，最好在安装之前使用别的wifi连接或者手机热点转发，安装完成之后再连接和配置eduroam.

5. 如果你有一台老的(Linux)电脑，并且新电脑的(待安装系统)硬盘可以现在读取，你可以在现在在安装开始之前，通过硬盘盒或者直接连接等方式，从"机外"完成以下步骤中的分区工作，然后在老电脑上通过rsync高速完成搬家工作。当然你也可以选择在安装完系统后搬家，或者不需要搬家。通过有线连接的搬家速度是最快的，如果你有搬家的需求，你可以在安装前完成分区和这一步。

### BIOS设置

1. 通过重启计算机，按F2, F8, F10, F12, Delete等键进入BIOS设置。注意不同的电脑品牌需要按的键可能不同，可以多尝试一下，或者查询对应品牌的官方网站。

2. 在BIOS设置中，关闭Secure Boot并且设置启动顺序使得你的电脑能够通过USB启动。不同品牌的操作方式可能不同，如果不清楚可以使用搜索引擎或者查询品牌官方网站。

3. 插入制作好的启动U盘，重启电脑。

## 安装Arch Linux检查表

### 准备工作

1. 使用iwctl来连接到Wi-Fi网络：(你也可以使用wpa_supplicant)

先进入iwctl：
```bash
iwctl
```
列出可用的设备：
```bash
device list
```
扫描Wi-Fi网络：
```bash
station <device> scan
```
显示扫描到的Wi-Fi网络：
```bash
station <device> get-networks
```
连接到Wi-Fi网络：
```bash
station <device> connect 网络的SSID
```
检查连接状态：
```bash
station <device> show
```
退出iwctl：
```bash
exit
```

记得使用dhcpcd来获取IP地址
```bash
dhcpcd
```

可以使用ping命令来检查网络连接是否成功owo
```bash
ping archlinux.org
```

2. 通过fdisk或者cfdisk来给你的磁盘分区owo

```bash
fdisk -l

fdisk /dev/你的磁盘(sd** or nvme*n*)
```
输入m查看帮助，p打印当前分区表，n新建分区，w保存退出。

你需要确保你有

* (重要)一个大约512M ~ 1G的EFI分区。如果你使用双系统，你可以创建这个分区，也可以不创建这个分区而选择直接使用windows或安装其它操作系统时已经创建过的EFI分区。

* (重要)一个最大的root分区，这个分区将用来存放你的整个系统和所有的文件。

* (可选)swap分区是可选的，通常大小在你的内存的1~2倍大小。这在老一点的电脑上可能比较有意义，而对内存充足的现代的电脑来说不是必须的。如果你需要使用休眠(hibernate, 即将内存中的数据写入磁盘并关闭电脑电源)功能，建议swap分区的大小需要不少于内存大小。你可以选择不创建swap分区而在之后使用更加灵活的swapfile方案，效果和swap分区基本相同。

* (可选)一个Home分区，你可以选择将系统和家分开，甚至将你的家单独放置在另一块硬盘上，这样你可以让多个Linux系统使用同一个家，或者方便的把家搬走owo

如果你不知道该干什么，请确保创建一个Efi分区和root分区owo

3. 格式化分区

在格式化你的分区之前，请仔细检查对应的名称(比如/dev/nvme0n1p5)是否准确owo！建议在运行格式化命令前再阅读检查一遍。你可以使用
```bash
fdisk -l
# 或者
lsblk -f
```
来仔细检查你是否在格式化正确的分区。

接下来是格式化并且选择你想要的文件系统：owo

* ext4是一个高性能，快速且稳定的通用Linux文件系统，广泛使用并且使用简单，能满足大多数用户的需求。
```bash
mkfs.fat -F32 /dev/你的efi分区 
# 如果你之前没有创建这个分区而使用安装其它系统时已经创建过的boot分区，请不要格式化它！
fatlabel /dev/你的efi分区 EFI
# 为这个分区加上一个标签，方便引用它不会搞错

mkfs.ext4 -L ARCH /dev/你的root分区 
# -L ARCH 是给这个分区加上一个标签，方便引用它不会搞错。
# 你也可以换一个名字，比如ROOT或者MEOW
```

```bash
#(optional) 如果你创建了swap分区
mkswap -L SWAP /dev/你的swap分区 
swapon /dev/disk/by-label/SWAP # 启用swap分区
```

* 如果你想要使用更好玩的Btrfs文件系统(btrfs是一个copy on write的文件系统，支持子卷管理，轻松创建快照，时间旅行owo，多磁盘管理，RAID等丰富功能owo)，使用
```bash
mkfs.btrfs -L ARCH /dev/你的root分区
```

4. 挂载分区

* 对于使用ext4等文件系统的用户：
```bash
mount /dev/disk/by-label/ARCH /mnt # 挂载root分区
mkdir /mnt/boot # 创建一个boot文件夹用于挂载efi分区
mount /dev/disk/by-label/EFI /mnt/boot # 挂载efi分区到/mnt/boot文件夹
```
你也可以单独创建一个efi文件夹用于挂载efi分区，尤其是如果你要和其它系统共享efi分区，下面这个操作会更值得推荐，因为这样占用该分区的空间更小。
```bash
mount /dev/disk/by-label/ARCH /mnt # 挂载root分区
mkdir /mnt/boot # boot 文件夹保留在root分区中
mkdir /mnt/efi # 创建一个efi文件夹用于挂载efi分区
mount /dev/disk/by-label/EFI /mnt/efi # 挂载efi分区到/mnt/efi文件夹
```

* 如果你使用Btrfs文件系统，这一步会比较复杂，你需要先挂载文件系统，创建subvolume，然后再重新挂载子卷到/mnt。
```bash
mount /dev/disk/by-label/ARCH /mnt  # 挂载文件系统
btrfs subvolume create /mnt/@ # 创建子卷(重要)
btrfs subvolume create /mnt/@home # 给你的家单独创建子卷(optional)

btrfs subvolume list /mnt # 打印创建的子卷，检查是否符合预期

umount /mnt # 卸载文件系统
mount -o noatime,subvol=@ /dev/disk/by-label/ARCH /mnt # 重新将子卷@挂载到 /mnt
mkdir /mnt/home # 创建一个home文件夹用于挂载@home分区，如果没有创建@home分区则忽略以下步骤
mount -o noatime,subvol=@home /dev/disk/by-label/ARCH /mnt/home # 挂载@home分区到/mnt/home文件夹

mkdir /mnt/boot # boot 文件夹保留在@中
mkdir /mnt/efi # 创建一个efi文件夹单独用于挂载efi分区，boot文件夹保留在@中，方便snapshot将它包含在内
mount /dev/disk/by-label/EFI /mnt/efi # 挂载efi分区到/mnt/efi文件夹
```
这里noatime选项会关闭文件的”访问时间“记录，默认情况下unix操作系统会对所有文件维护一个“访问时间戳“。关闭它可以提高文件系统的性能，而对于Btrfs这样一个Copy on write的文件系统来说这个选项更有意义，可以减少不必要的写入操作。

为了使用Btrfs的快照功能，我们必须单独挂载efi到/efi，而不能直接挂载到/boot. 否则snapshot无法把/boot分区的initramfs包含在内，这会导致你更新kernel之后无法通过之前的snapshot启动“过去的系统”，造成对@的snapshot难以使用。

5. (optional)在下一步开始前你可以检查挂载情况：

如果你有其他硬盘并且需要挂载到指定的文件夹，你可以在这时挂载它们方便之后的gen-fstab生成fstab文件。

```bash
lsblk -f 
```

### 安装系统

1. 更新和选择镜像(optional)

编辑/etc/pacman.d/mirrorlist，将你所在地区的镜像源放在最前面，你也可以使用reflector来自动选择最快的镜像源。这会加快下载速度。

2. 安装基本系统

```bash
pacstrap -K /mnt base linux linux-firmware # 这些都是必须的！owo 
# 如果你在虚拟机内安装Arch Linux，则不需要安装linux-firmware
```

其他可选项
```bash
pacstrap -K /mnt amd-ucode   # AMD CPU用户请安装，不要安装两个owo
pacstrap -K /mnt intel-ucode # Intel CPU用户请安装，不要安装两个owo

pacstrap -K /mnt base-devel # 可选安装基本开发工具

pacstrap -K /mnt grub efibootmgr # 建议安装GRUB引导程序

pacstrap -K /mnt neovim # 可选安装neovim编辑器

pacstrap -K /mnt networkmanager # 建议安装NetworkManager, 方便联网

pacstrap -K /mnt btrfs-progs # 如果你使用Btrfs, 记得安装btrfs工具哦！owo
```
你可以用一个命令，使用空格分隔多个软件包，不需要多次运行pacstrap。
这一步可选项并不关键，你也可以在arch-chroot步骤之后在系统内使用pacman来安装软件包。

### 配置系统

1. 生成fstab文件
这会基于当前的挂载情况生成一个fstab文件，用于在启动系统时自动挂载分区。

```bash
genfstab -U /mnt >> /mnt/etc/fstab
```

这是重要文件，建议检查一下文件内容是否符合预期(里面包含你系统启动时需要挂载的分区信息)：
```bash
cat /mnt/etc/fstab
```

2. 切换到新系统
```bash
arch-chroot /mnt
```

3. 设置时区
```bash
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime # 设置时区，如果不在China，你应该修改成你需要的时区，比如Europe/London
hwclock --systohc # 生成硬件时间
```

4. 本地化

编辑/etc/locale.gen，取消你需要的语言的注释，然后生成本地化文件。
建议启用 en_US.UTF-8 UTF-8 和 zh_CN.UTF-8 UTF-8

```bash
nano /etc/locale.gen # 一个很简单的编辑器
# 或者
nvim /etc/locale.gen # nvim 或者 vim 是一个很强大但是需要一定学习的编辑器
# 进入vim之后，可以按正斜杠/ 然后输入en_US回车，直接跳到搜索的位置，
# 然后按^跳到本行第一个字符，再按x删除注释符号#. 修改完成之后按:wq 保存退出owo
```

生成本地化文件：
```bash
locale-gen
```

创建并编辑/etc/locale.conf文件，写入你的语言设置，你可以用nano, vim等编辑器或者echo命令来写入。
```bash
echo "LANG=en_US.UTF-8" > /etc/locale.conf
```

5. 网络配置

使用你喜欢的编辑器编辑/etc/hostname文件，写入你的主机名。没错，只用写入一行就行了。

你也可以用echo命令来写入：
```bash
echo "你的主机名" > /etc/hostname
```

6. 生成Initramfs
```bash
mkinitcpio -P
```

7. 设置root密码(非必须)
```bash
passwd
```
如果你不设置root密码，你将无法使用root用户登录，但是你可以使用sudo来执行命令。不设置root密码通常是一个好的安全实践。**但是一定要配置一个可以使用sudo的用户。(用户管理那一节我们会做这件事)**

8. 安装引导程序(以GRUB为例)
```bash
# 如果你创建过efi文件夹并设置了挂载efi分区到/efi，你应该使用以下命令
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# 如果你没有创建过efi文件夹并设置了挂载efi分区到/boot，你应该使用以下命令
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
```

### 用户管理

0. 安装sudo才能使用sudo命令owo
```bash
pacman -S sudo
```

1. 创建一个新用户
```bash
useradd -m -G wheel -s /bin/bash 你的用户名
# -m 为这个用户创建家目录
# -G 添加这个用户到wheel用户组
# -s 设置这个用户的shell(可以不加，默认是bash)
```

2. 设置用户密码
```bash
passwd 你的用户名
```

3. 编辑sudoers文件
```bash
nvim /etc/sudoers
```
取消注释这一行：
```bash
%wheel ALL=(ALL) ALL
```

### 安装完成

1. 退出chroot环境
```bash
exit
```

2. 重启，进入新系统
```bash
reboot
```
电脑重启熄灭屏幕之后移除U盘，在启动时你应该能看到GRUB引导界面，选择Arch Linux启动！owo
如果一切顺利，你将看到一个提示登录的命令行界面，恭喜你成功安装了Arch Linux！>w<

## 系统安装后

重启后如果一切正确，你将能登录进入你的新系统。

如果你是第一次安装Arch Linux，推荐你学习arch linux中最重要的工具owo：[pacman的使用方法](https://wiki.archlinux.org/title/Pacman)

1. 安装你所需的软件，为此先设置网络(以NetworkManager为例，你需要在之前的步骤中安装了NetworkManager)：
```bash
sudo systemctl enable NetworkManager --now # NetworkManager启动! owo

nmcli device wifi list                  # 列出可用的Wi-Fi网络
nmcli device wifi connect 网络的SSID -a # 连接到Wi-Fi网络
# nmcli device wifi list 可以直接缩写成 nmcli d w l 
# nmcli device wifi connect 网络的SSID -a 可以直接缩写成 nmcli d w c 网络的SSID -a
```

从这里开始，每个人要做的操作都将大相径庭，你可以安装桌面环境，配置X11或者Wayland，安装声音工具，或者任何你需要的软件。每个人喜欢用的可能都不同，

Arch Wiki上的[安装后推荐操作](https://wiki.archlinux.org/title/General_recommendations)是一个很好并且很全面的参考！

这里我们举安装KDE桌面环境，和XMonad窗口管理器的例子。

### 桌面环境/窗口管理器
安装完Arch Linux系统之后，大多数人会选择安装一个正经的图形界面(桌面环境或者窗口管理器)。有很多选项可以选择，桌面环境诸如kde, gnome. 热门的窗口管理器有诸如i3, awesome, dwm (通过C语言配置), xmonad (通过Haskell配置), 等。你可以自行了解并选择你想要的owo，我这里只能列出我平常用的～

#### 如果你想安装KDE桌面环境
```bash
sudo pacman -S xorg plasma sddm kde-applications
```

启用sddm
```bash
sudo systemctl enable sddm
```
完成了owo

#### 如果你想安装XMonad窗口管理器
虽然可以从arch官方通过pacman安装xmonad, 但是从稳定性的角度来说我个人倾向于install from source. 即窗口管理器由源代码直接管理而不是pacman来管理，这样你的窗口管理器+系统会超稳定！

[XMonad官方安装教程](https://xmonad.org/INSTALL.html#build-using-stack)

1. 先安装Dependencies
```bash
sudo pacman -S git xorg-server xorg-apps xorg-xinit xorg-xmessage libx11 libxft libxinerama libxrandr libxss pkgconf
```

2. 安装Haskell编译器(以stack为例)
```bash
sudo pacman -S stack
```

当然如果你要使用Haskell语言，你可以从[Haskell官方](https://www.haskell.org/ghcup/)安装ghcup, 会将ghc和cabal, stack等工具一起安装。
```bash
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

3. 安装XMonad
```bash
cd
mkdir .xmonad
cd .xmonad
git clone https://github.com/xmonad/xmonad
git clone https://github.com/xmonad/xmonad-contrib
```
如果你有自己的配置文件xmonad.hs以及自己的library (lib/) 你应该在这时把它放在.xmonad/文件夹下。你可以用scp或者rsync等工具来将已有的配置文件传输到你的新系统。

4. 编译和安装
```bash
# in the directory ~/.xmonad
stack init
stack install
```

5. 安装Display Manager(以lightdm/sddm为例)
```bash
# For lightdm
sudo pacman -S lightdm lightdm-gtk-greeter nitrogen #lightdm
sudo systemctl enable lightdm #lightdm

# For sddm
sudo pacman -S sddm #sddm
sudo systemctl enable sddm  #sddm
```

6. 注册xsessions文件
```bash
sudo nvim /usr/share/xsessions/xmonad.desktop
```
写入以下内容：
```bash
[Desktop Entry]
Name=XMonad
Comment=Lightweight tiling window manager # 写啥都可以
Exec=/home/你的用户/.local/bin/xmonad # 根据安装路径填写
Type=Application
```

### 你可能用的到或用不到的系统配置

#### 缩放
在~/.Xresources中添加
```bash
Xft.dpi: 96 # 96dpi是默认值，你可以根据自己的屏幕分辨率调整缩放，
# 比如120就是1.25倍缩放，144就是1.5倍缩放，192就是2倍缩放等.
```

#### 音频
```bash
sudo pacman -S alsa-utils pipewire pipewire-alsa pipewire-pulse # 安装音频驱动
sudo pacman -S pavucontrol # PulseAudio的图形界面
```

##### 如果电脑仍然没有声音
如果你检测不到声卡，你可能需要安装对应的驱动，比如安装 sof-firmware, alsa-ucm-conf
```bash
sudo pacman -S sof-firmware alsa-ucm-conf
```

#### 播放音乐

如果你发现你播放不了指定格式的音乐，你可以安装解码器
```bash
sudo pacman -S gstreamer gst-plugins-good gst-plugins-bad gst-plugins-ugly
```

#### Touchpad没反应
```bash
sudo pacman -S xf86-input-libinput 
sudo pacman -S xf86-input-synaptics # 如果你的触摸板是Synaptics的
```

如果安装了以上包没有正常工作，你可能需要增加一个配置文件 /etc/X11/xorg.conf.d/70-synaptics.conf
参考[Arch Wiki](https://wiki.archlinux.org/title/Touchpad_Synaptics)


## AUR Helper 的安装和使用
Aur是Arch Linux中的一个专门存放各种软件的安装脚本的网站，其中的内容都是由用户上传的而非由Arch Linux官方管理的。AUR是Arch Linux的一大优点，可以让用户方便的安装各种软件！owo

在Aur上安装软件的步骤很简单，你只需要

```bash
git clone https://aur.archlinux.org/软件的包名.git
cd 软件的包名
makepkg -si
```

如果你希望直接在命令行中像pacman那样一键搜索和安装软件，你可以使用AUR助手，最常用的aur助手是yay或者paru, 还有aura可以选择。以paru为例：
```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

这时，安装aur上的软件就会非常容易，比如我要安装qq，只需要输入
```bash
paru -S linuxqq
```

## 其它你可能会用到的软件推荐

### 中文字体
[Simplified Chinese](https://wiki.archlinux.org/title/Localization/Simplified_Chinese) 和 [Traditional Chinese](https://wiki.archlinux.org/title/Localization/Traditional_Chinese) 的安装方法可以参考Arch Wiki。

```bash
sudo pacman -S wqy-microhei wqy-zenhei noto-fonts-cjk
```

### 输入法
fcitx是一个非常好用的输入法框架
[fcitx on arch wiki](https://wiki.archlinux.org/title/Fcitx) 

另外一个常用的输入法框架是ibus
[ibus on arch wiki](https://wiki.archlinux.org/title/IBus)

以安装谷歌拼音输入法为例：
```bash
sudo pacman -S fcitx fcitx-configtool fcitx-googlepinyin
```

### 浏览器
我比较喜欢使用firefox或者floorp，你可以安装你喜欢的浏览器owo
```bash
# firefox的安装
sudo pacman -S firefox
# 你也可以选择 firefox-developer-edition 或者 firefox-nightly

# floorp的安装
paru -S floorp
```

### 视频音频
使用mpv来看视频，quodlibet来播放本地音乐，vlc也是一个可以推荐的音频和视频播放器！
```bash
sudo pacman -S mpv quodlibet
```

### 终端相关
使用kitty或者alacritty作为你的terminal
```bash
sudo pacman -S kitty
```
#### neofetch
安装neofetch打印一个好看的系统信息和图标owo，可以用来给大家截图分享！
```bash
sudo pacman -S neofetch

neofetch # run it in the terminal! owo
```

#### 终端下的资源管理器
使用ranger或者yazi来方便的阅览你的所有文件owo
```bash
sudo pacman -S yazi
```
在你的.bashrc中添加如下内容，可以方便的启动yazi并且用它导航：
```bash
# yazi functionality that allows change the current directory when exiting yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}
```

#### fzf (fuzzy finder) 快速查找文件
使用fzf来查找你系统中的所有文件
```bash
sudo pacman -S fzf
```

在.bashrc中可以添加如下内容：
```bash
# Load fzf key bindings at startup, press Ctrl+T or Ctrl+R to trigger fzf
source <(fzf --bash)

# 这个功能会方便的把fzf和yazi整合到一起！owo
function fy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	fzf -i | xargs -I {} yazi '{}' "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
	echo "You are now in: " && pwd
}
```

#### 可爱的鼓励文字

在你的.bashrc中添加如下内容，这样你每次打开终端就会受到一条可爱的鼓励文字！>w<
```bash

greetings=(
    "$USER! お疲れ様です！今日も頑張ってね！ (辛苦啦！今天也要加油哦！) (｡•̀ᴗ-)✧"
    "$USER! Keep shining like the star you are! (✨)"
    "$USER! 一歩一歩、前進しよう！ (一步一步向前进吧！) (ง •̀_•́)ง"
    "$USER! You can accomplish anything you set your mind to! (^-^*)/ "
    "$USER! 笑顔でいれば、きっと素敵な一日になるよ！ (保持笑容，一定会是美好的一天！) (´｡• ᵕ •｡\`)♡"
    "$USER! Believe in yourself and keep moving forward! (｡•̀ᴗ-)✧"
    "$USER! 今日も最高の一日にしよう！ (今天也要成为最好的一天！) (*•̀ᴗ•́*)و ̑̑"
    "$USER! You're making progress every day. Keep going! (OwO)"
    "$USER! あなたならできる！ファイト！ (你一定能做到！加油！) (ง •̀_•́)ง"
    "$USER! You're doing great. Stay positive and persistent! (^-^*)/"
    "$USER! 笑顔と一緒にスタートしよう！ (一起微笑着开始吧！) (´｡• ᵕ •｡\`) ♡"
    "$USER! 今日も一日、頑張りましょう！ (今天也要加油哦！) (*•̀ᴗ•́*)و ̑̑"
    "$USER! あなたの笑顔が、世界を明るくする！ (你的笑容能让世界更美好！) (｡•̀ᴗ-)✧"
    "$USER! 今日もあなたらしく輝いてください！ (今天也请你闪耀如你自己！) (^-^*)/"
    "$USER! Your potential is limitless. Keep going! (OwO)"
    "$USER! 笑顔と自信を持って、素晴らしい一日にしよう！ (带着笑容和自信，让今天成为美好的一天！) (´｡• ᵕ •｡\`) ♡"
    "$USER! Every step you take brings you closer to your dreams! (*•̀ᴗ•́*)و ̑̑"
    "$USER! いつも頑張っているね、素晴らしい！ (你总是很努力，真了不起！) (｡•̀ᴗ-)✧"
    "$USER! Don't forget to be kind to yourself today! (^-^*)/"
    "$USER! 小さな進歩でも、一歩一歩積み重ねていこう！ (即使是小小的进步，也要一步一步积累起来！) (ง •̀_•́)ง"
    "$USER! Your positive energy is contagious. Share it with the world! (OwO)"
    "$USER! 今日もファイト！一緒に頑張ろう！ (今天也要加油！一起努力吧！) (´｡• ᵕ •｡\`) ♡"
    "$USER! You're a beacon of light. Shine brightly! (｡•̀ᴗ-)✧"
    "$USER! 笑顔を忘れないで、きっと素敵な日になるよ！ (不要忘记笑容，一定会是美好的一天！) (^-^*)/"
    "$USER! Progress is progress, no matter how small. Keep it up! (*•̀ᴗ•́*)و ̑̑"
    "$USER! 自分を信じて、素晴らしい未来に向かって進んでね！ (相信自己，朝着美好的未来前进吧！) (´｡• ᵕ •｡\`) ♡"
    "$USER! You're strong, capable, and inspiring. The world needs you! (｡•̀ᴗ-)✧"
    "$USER! 我知道，只要你下定决心做一件事，你就绝对不会放弃！ (^-^*)/"
)

# Function to display a random greeting
function random_greeting {
    local index=$((RANDOM % ${#greetings[@]}))
    echo -e "${greetings[$index]}"
}

# Call the random_greeting function at startup
random_greeting
```

#### 笔记本的一键省电优化

安装tlp可以一键优化你的笔记本电脑的耗电owo

```bash
sudo pacman -S tlp
sudo systemctl enable tlp --now
```

安装完之后就把它忘了吧，它会自动帮你省电的owo

### 游戏

#### 安装steam
[Arch Wiki上的Steam页面](https://wiki.archlinux.org/title/Steam)

安装steam之前我们需要先打开multilib，即32位的软件源owo
```bash
sudo nvim /etc/pacman.conf
```
按/[multi 回车，再按n等方式，定位到[multilib],把它对应的段落的注释取消
```
[multilib]
Include = /etc/pacman.d/mirrorlist
```
保存退出，然后直接安装就可以了！owo
```bash
sudo pacman -S steam
```
注意安装正确的图形驱动，不要乱选哦！owo

## 远程登录的魔法门(ssh)

### 安装ssh
```bash
sudo pacman -S openssh
```

在要被远程登录的电脑上启动ssh服务
```bash
# 启动ssh服务, 仅限本次启动，临时使用
sudo systemctl start sshd 

# 立即启动，并且之后也开机启动ssh服务，适合服务器上使用
# 如果你选择长期启动魔法门登录，你的密码不能太弱
sudo systemctl enable sshd --now 
```

### 远程登录
```bash
# 在电脑上使用ip ad命令可以查看ip地址
ssh 用户名@IP地址
```

#### 加密传输文件
```bash
scp 本地文件路径 用户名@IP地址:远程文件路径
```

## 搬家

安装rsync
```bash
sudo pacman -S rsync
```

如果你有一台老的电脑，你可以使用rsync来搬家，把你的家目录搬到新的系统中！首先建议将两台电脑置于同一个局域网中。有一个小的骚操作是用手机打开一个5G频段的热点，然后让两台电脑连接这个热点，这样可以保证搬家的速度最快，降低其它设备的信号干扰，通常可以达到30MB/s以上的速度。

具体要搬哪些内容取决于你自己的需求，比如如果我想要搬走.config和Documents, Pictures文件夹，我可以使用

```bash
# 在新电脑上使用ip ad可以查看ip地址
rsync -Pvar ~/.config 新电脑的用户名@新电脑的IP地址:~/ --exclude=~/.config/microsoft* --exclude=~/.config/QQ/*
# 通过 --exclude 可以排除一些不需要搬走的文件夹

rsync -Pvar ~/Documents ~/Pictures 新电脑的用户名@新电脑的IP地址:~/
```

如果时间和空间资源允许，你可以把整个家目录搬走，这样你的新系统就会和你的老系统一模一样了！owo (只要安装的软件一样的话)

如果你愿意，你也可以选择将新电脑的硬盘拆卸下来，然后通过硬盘盒或者直接连接等方式，在老电脑上"机外"完成搬家工作。这包含挂载，rsync等操作。相比于无线传输，有线直连的速度会非常非常快！owo
