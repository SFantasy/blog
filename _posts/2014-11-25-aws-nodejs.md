---
layout: post
date: 2014-11-25 22:22
title: EC2上配置部署Node.js应用
keywords: AWS, AWS EC2, Node.js, Nginx, 环境配置
description: 在AWS EC2上配置Node.js的环境与Nginx
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

Node.js官方给出了使用包管理方式安装Node.js的比较方便的方法：[Install instruction](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#debian-and-ubuntu-based-linux-distributions)，而我也正是使用这种方式安装的:

```
curl -sL https://deb.nodesource.com/setup | sudo bash -
sudo apt-get install nodejs
```

在顺利安装完Node.js之后可以用Vi编辑一个简单的JavaScript文件测试一下：

```
console.log('Hello Node.js and AWS.');
```

![aws-2](http://fantasyshao-blog.qiniudn.com/aws-2.png)

## 部署Node.js应用

现在我需要部署我在之前的博客中提到的[Riki](https://github.com/SFantasy/Riki)。

## MongoDB

MongoDB可以完全参考其官方文档： [Install MongoDB on Ubuntu](http://docs.mongodb.org/manual/tutorial/install-mongodb-on-ubuntu/)

## 部署

首先我需要checkout GitHub上的repo:

```
git clone https://github.com/SFantasy/Riki.git
```

安装依赖：`npm install`

由于原来Riki中是使用`supervisor`启动的，在EC2上还是选择使用[PM2](https://github.com/Unitech/PM2)来运行。

安装PM2：`sudo npm install -g pm2`

修改原来项目种的package.json中的`scripts`:

```
pm2 start ./bin/www
```

这样就可以通过`npm start`来运行我们的项目了，如果使用项目默认的3000端口的话就可以直接运行：

![aws-riki](http://fantasyshao-blog.qiniudn.com/aws-riki.png)

## Nginx

在Ubuntu的机器上安装Nginx非常简单：

```
sudo apt-get install nginx
```

安装完后Nginx就已经启动了，访问EC2的public IP可以看到如下界面：

![aws-nginx](http://fantasyshao-blog.qiniudn.com/aws-nginx.png)

接下来需要修改Nginx的配置文件才能将3000端口转发到Nginx的80端口上，配置文件默认是在`/etc/nginx/nginx.conf`：

```
upstream riki {
    server 127.0.0.1:3000;
}

server {
    listen 80;
    server_name localhost;

    location / {
        proxy_pass http://riki;
    }
}
```

这里我是简单粗暴的把原有配置文件中的`include`的内容注释掉了。

于是乎，我们就可以直接通过IP访问Riki了：

![aws-riki](http://fantasyshao-blog.qiniudn.com/aws-riki-2.png)

至此，一个简单的Node.js的应用就已经部署好了。对在EC2上的部署过程有任何疑问都可以与我交流。
