---
layout: post
date: 2016-05-11 20:00:00
title: 体验 Ruff 1.0
keywords: ruff, hardware, javascript
description: 通过 Ruff 使用 JavaScript 对硬件进行编程
comments: true
category: Fresh
---

前几天围观了 Ruff 1.0 在微信群里线上发布会，感觉是个很有意思的东西。
Ruff 给出的口号是「现代 JavaScript 开发硬件」，作为一名每天使用 JavaScript 编码的程序员自然对其很感兴趣了。

值得注意的是 Ruff 是一个 JavaScript runtime，而非一块开发板的名称。

## 开箱

Ruff 的包装

![ruff-box](/media/img/ruff/ruff-box.jpg)

开发板

![ruff-board](/media/img/ruff/ruff.jpg)

附赠的套件

![ruff-things](/media/img/ruff/ruff-things.jpg)

## 开始使用

> 学习使用 Ruff 可以完全参照官方的文档：[Ruff - 起步走](https://ruff.io/zh-cn/docs/getting-started.html)

### 配置环境

Ruff 1.0 的环境搭建是以下载 SDK 然后配置环境变量的方式进行的，可以将以下代码 Copy 添加到你的 Shell 配置中：

```
export RUFF_HOME=/path/to/ruff-sdk
export PATH="$PATH:$RUFF_HOME/bin"
```

### 创建项目

整个过程很类似创建 Node.js 项目：

![ruff-create](/media/img/ruff/ruff-create.png)

### 连接设备

插入数据线的时候总觉得要把板子给摁破

![ruff-connect](/media/img/ruff/ruff-connect.jpg)

### 连接 WiFi

需要自己输入 SSID 和 password

在连接的时候不知道什么原因，一直在打点：

![ruff-wifi](/media/img/ruff/ruff-wifi.png)

但是再打开一个 Tab 使用 rap scan 命令证实实际上已经连接上了。

### 代码

默认创建的项目是启动开发板右侧的红色 LED，代码如下：

```
$.ready(function (error) {
    if (error) {
        console.log(error);
        return;
    }

    $('#led-r').turnOn();
});

$.end(function () {
    $('#led-r').turnOff();
});
```

这很像是我们所熟悉的 jQuery 写成的代码。

### 部署

```
rap deploy -s
```

在几秒钟之后，应用就已经部署到 Ruff 的开发板上了，可以看到右侧的红灯已经被点亮了：

![ruff-red](/media/img/ruff/ruff-red.jpg)

### 添加模块

官方教程中是添加一个大按键的模块，但是我在收到的包装中并没有发现该模块 -- 原来是 Ruff 将按键模块放到了光照传感器的包装之中。

```
rap device add button
```

然后按照提示输入设备的型号就会自动下载该设备的驱动。

### LCD 模块

连线开始复杂起来了，好在 Ruff 提供了可视化布局。

```
rap layout --visual
```

会在浏览器中弹出一个页面教你如何接线，这还是十分方便的:

![ruff-layout](/media/img/ruff/ruff-layout.png)

Rap Registry 中可以照着型号找到对应的 LCD API: [Rap Registry](https://rap.ruff.io/raps/116)

编写代码:

```
$('#button').on('push', function () {
  $('#lcd').print('Hello');
  $('#lcd').setCursor(0, 1);
  $('#lcd').print('Ruff');
});

$('#button').on('release', function () {
  $('#lcd').clear();
});
```

Deploy 后运行成功！

![ruff-lcd](/media/img/ruff/ruff-lcd.jpg)

总的来说，Ruff 的使用体验还是非常不错的：

- 简洁的语法和快速的部署方式让 Ruff 能很快的上手；

- Rap Registry 和 Visual layout 让我这样普通定的程序员也能很快的用它来开发一些东西；

不好的地方稍微复杂一点的应用，在布线连接方面可能就比较麻烦了。

不过 Ruff 毕竟是一个刚面世不久的产物，而「用软件定义硬件」这样的概念让人有很大的想象空间。

---

Happy Hacking!

> 本文最早发布于我的[知乎专栏](https://zhuanlan.zhihu.com/p/20884629)，欢迎访问。
