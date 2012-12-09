---
layout: post
title: "A byte things about UNIX Shell"
date: 2012-09-30 11:11
comments: true
categories: Shell Linux
---

最近在图书馆翻到了一本《Unix 技术手册（第三版）》，这本书是SVR4（System V Release 4）和Solaris7的技术参考手册；其实旁边还有一本相对比较新的第四版，不过那本太厚，而且琢磨着应该差不了多少，于是就拿着它翻了起来。
记得之前在看《鸟哥的Linux私房菜》的时候差不多翻到“学习shell与shell script”那一章，所以在阅读完介绍Unix的那一章以及跳过一大刀Unix命令的第二章后，看到了Unix shell的部分。

## Unix Shell
#### 用途：
1.交互式使用；2.定制Unix会话；3.编程。
#### 种类：
1.Bourne shell；

2.Korn shell；

3.C shell。

我们常用的默认shell一般都是bash，也就是被Linus吐槽为“丑陋名称的”“Bourne-again shell”，也有听说是“Born-again shell”的意思。但是不管如何，bash总归是sh的超集（superset）；Korn shell (ksh) 也是 Bourne shell(sh)的增强版，不过与bash不同的是，ksh是贝尔实验室的一个名叫 David Korn 写的，而bash属于鼎鼎大名的GNU项目，所以使得所有的GUN/Linux（当然，还有Mac OS X）的默认shell 是bash。

当然，书中还提到了更加适合交互使用的C shell(csh)，一个从Berkeley孵化出来的shell版本，所以它也理所应当地在BSD(Berkeley Software Distribution)成为了默认shell。

我们可以在Linux 中用以下形式的命令来切换当前使用的shell：
	exec ksh
接下来简单的介绍一下bash的功能:

* 输入输出重定向
	
		echo "This is an example" > a.txt
  		#将输出文本重定向（在这里也就是保存）到一个文件中

* 文件名缩写用的通配符（元字符）
所谓通配符，举例来说：我们要删除所有文件格式为“.txt”的文件，使用“rm *.txt”就可以了，其中*就是所谓的“通配符”。

* 定制环境的shell变量

* 写shell程序用的内置命令集
	
  		echo"hello bash"
  		#输出字符串
  		exit  	
  		#退出bash
  		wait
 		#等待活动作业的完成
		type cmd  
		#查看一个命令是否是bash的内置命令

* 作业控制

	 	bg
		#将作业置于后台运行
	  	fg
		#将作业置于前台运行
	  	jobs
	  	#查看当前活动作业
	  	kill
	  	#终止某作业
	  	wait
	  	#等待后台作业完成
	  	C-z
	  	#挂起当前作业

* 命令行编辑

* 命令历史

可以输入“history”查看内存中所有的记忆下来的命令。当然也可以使用"history number“来查看最近number条的记录。

* 别名

  		alias lm = ls -l | more
  		#今后在bash中输入"lm" 就相当于输入了 "ls -l | more"

当然将”alias“替换为”unalias“就可以将刚才设置好的别名去掉。
