---
layout: post
title: 几个有趣的命令行工具
categories: Shell
date: 2013-12-03 20:00
comments: true
keywords: 命令行,CLI,有趣,Bash,Zsh
description: 几个有趣的命令行工具
---

最近发现了几个比较有意思的命令行工具，分享一下。

## FIFGlet

FIGlet的介绍可以看看他的[man page](http://www.figlet.org/figlet-man.html)。

简单来说，FIGlet就是一个用「更大」的字符来输出字母的工具。

> **「这有啥好玩的?」**

来看看例子：

```
figlet happy
```

这时候输出的结果是：

```
 _
| |__   __ _ _ __  _ __  _   _
| '_ \ / _` | '_ \| '_ \| | | |
| | | | (_| | |_) | |_) | |_| |
|_| |_|\__,_| .__/| .__/ \__, |
            |_|   |_|    |___/
```

怎么样，挺好玩的吧？

再来个立体感的：

```
figlet -f isomatric1 happy
```

输出：

```
      ___           ___           ___           ___           ___
     /\__\         /\  \         /\  \         /\  \         |\__\
    /:/  /        /::\  \       /::\  \       /::\  \        |:|  |
   /:/__/        /:/\:\  \     /:/\:\  \     /:/\:\  \       |:|  |
  /::\  \ ___   /::\~\:\  \   /::\~\:\  \   /::\~\:\  \      |:|__|__
 /:/\:\  /\__\ /:/\:\ \:\__\ /:/\:\ \:\__\ /:/\:\ \:\__\     /::::\__\
 \/__\:\/:/  / \/__\:\/:/  / \/__\:\/:/  / \/__\:\/:/  /    /:/~~/~
      \::/  /       \::/  /       \::/  /       \::/  /    /:/  /
      /:/  /        /:/  /         \/__/         \/__/     \/__/
     /:/  /        /:/  /
     \/__/         \/__/
```

加上了参数`-f`可以选择输出的字体，[examples](http://www.figlet.org/examples.html)中有相当多的字体，相信一定能找到你喜欢的一个。

当然，也可以通过`-w`制定输出的宽度，通过`-R`切换到从右向左输出字符...等等。

### 更多參考

* [官网](http://www.figlet.org/)
* [FIGlet on GitHub](https://github.com/cmatsuoka/figlet)

## toilet

是的，这个命令叫做toilet。

与FIGlet的功能相近，我们可以看看他的效果：

![screenshot](http://fantasyshao-blog.qiniudn.com/toilet.png)


## sl

在安装了`sl`之后，如果你使用的是zsh而不是bash，需要使用`sudo sl`来使用该命令，否则zsh会默认把`sl`当成`ls`。

```
sudo sl
```

![screenshot](http://fantasyshao-blog.qiniudn.com/sl.png)

你会看到一辆货车飞驰而过……

sl其实是Steam Locomotive（蒸汽火车头）的缩写，正如作者在项目主页上所说：

> SL (Steam Locomotive) runs across your terminal when you type "sl" as you meant to type "ls". It's just a joke command, and not usefull at all.

输入`sl`大部分情况是因为错误的输入（想要输入的是`ls`），所以实际上没有任何用处，it is just for fun!

题外话，如果把火车头换成一群「草泥马」会如何？输错命令时，终端里就是「一群草泥马飞驰而过」的场景了。

### 更多参考

* [sl on GitHub](https://github.com/mtoyoda/sl)

## CMatrix

作者是一个热爱「The Matrix」也就是黑客帝国的一名程序员，而且强烈建议电脑爱好者和科幻迷去观看之。

![screenshot](http://fantasyshao-blog.qiniudn.com/matrix.png)

看截图不带感，如果你使用的是Debian或RedHat分支的Linux，亦或是OS X都应该用包管理器去安装一下，酷炫。

### 更多参考

[CMatrix主页](http://www.asty.org/cmatrix/)

> 你还发现过哪些有趣的命令行工具呢？

--EOF--
