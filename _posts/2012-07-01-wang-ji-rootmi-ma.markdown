---
layout: post
title: "忘记Root密码"
date: 2012-07-01 11:18
comments: true
categories: Linux
---

最近终于开始有点想看书的心思了，于是捧起鸟哥的“大作”开始啃了起来（《鸟哥的Linux私房菜》），以下空间用来Mark一下本人曾经遇到过的问题或者不曾理解的内容，由于水平有限，各种槽点请轻吐……

记得第一次安装完Fedora之后就急匆匆地跑去上体育课了，然后回来居然怎么都无法正确的输入系统的密码，所以也就悲剧地无法进入系统的T^T……记得Google了一些内容无果后，最终在室友的强烈建议下重装了系统。

“你只要以单用户维护模式登录即可更改你的root帐号密码。由于lilo这个引导程序已经很少见了，这里使用grub引导装载程序作为范例来介绍。

先将系统重启，在读秒的时候按下任意键就会出现如下内容：

	root (hd0,0)

	kernel /vmlinuz-2.6.18-128.e15 ro root=LABEL=/ rhgb quiet

	initrd /initrd-2.6.18-128.e15.img

时，请将光标移动到kernel那一行，再按一次e进入kernel该行的编辑界面中，然后在出现的界面当中，最后方输入single:

	kernel /vmlinuz-2.6.18-128.e15 ro root=LABEL=/ rhgb quieet single

再按下Enter确定之后，按下b就可以开机进入单用户维护模式了。在这个模式之下，你会在tty1的地方不需要输入密码即可取得终端的控制权（而且是使用root的身份）。之后就能够修改root的密码了，请使用下面的命令来修改root的密码。

	[root@www~]#passwd

接下来系统会要求你输入两次新的密码，然后再来reboot即可顺利修改root密码了。”（摘自《鸟哥的Linux私房菜（第三版）》）
