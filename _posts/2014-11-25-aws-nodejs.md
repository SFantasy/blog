---
layout: post
date: 2014-11-25 22:22
title: AWS EC2与Node.js
keywords: AWS, AWS EC2, Node.js, 环境配置
description: 在AWS EC2上配置Node.js的环境
comments: true
category: Node.js
---

由于绑定信用卡后可以免费使用1年的AWS，在今晚把玩了一下AWS EC2。

试用了一会AWS之后给我的好感主要源于以下几点：

- 服务种类多，包括了EC2, VPC等30余中云计算、数据库、网络服务、数据分析的服务：

![aws services](http://fantasyshao-blog.qiniudn.com/aws-services.png)

- EC2实例的种类多，现有的就包括Red Hat, SUSE和Ubuntu等(当然还有Windows Server).
- 基于Web的强大的管理后台，这点可能要使用过后才能感受一二

关于AWS就先介绍到这里，具体可以打开浏览器去感受一下: [Amazon Web Service](http://aws.amazon.com/)

通过SSH登录到AWS的Ubuntu实例后是这样的：

![aws](http://fantasyshao-blog.qiniudn.com/aws.png)

这次开始使用AWS的初衷不同于之前使用[Digital Ocean](//digitalocean.com) （那时主要是配置VPN），主要是想在「非本地」和「非配置好的App Engine」的服务器上运行Node.js程序，感受以下生产环境的氛围以及相关的一些配置技（da）巧（keng）。

Node.js在Ubuntu等Linux发行版上大概有这么两种安装方式：

1. （更改源后）使用发行版自带的包管理器，例如Debian系的apt-get，CentOS系的yum等
2. Clone GitHub上Node.js的源码，编译安装

Node.js官方给出了使用包管理方式安装Node.js的比较方便的方法：[Install instruction](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#debian-and-ubuntu-based-linux-distributions)，而我也正是使用这种方式安装的。

在顺利安装完Node.js之后可以用Vi编辑一个简单的JavaScript文件测试一下：

```
console.log('Hello Node.js and AWS.');
```

![aws-2](http://fantasyshao-blog.qiniudn.com/aws-2.png)

*To be continued...*
