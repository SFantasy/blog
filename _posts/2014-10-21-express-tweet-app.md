---
layout: post
date: 2014-10-21 22:22
title: Express4开发Web应用
keywords: Express, Node, Web开发
description: 使用Express4和MongoDB开发一个简单的Web应用
comments: true
category: Node.js
---

最近用[Express](http://expressjs.com)开发了一个小的网站，分享一下。

Express可谓是Node.js领域Web开发最常用的框架了，之前做微信公众账号的时候就用过Express，不过这次是算是结合MongoDB和Jade开发一个完整的Web应用，不同于之前的经历。

最近写Node.js或者前端相关的代码都是用的JetBrains家的[WebStorm](https://www.jetbrains.com/webstorm/)，前段时间JetBrains的产品开始对[edu邮箱的免费](https://www.jetbrains.com/student/)，正好问妹纸借了edu的邮箱注册了JetBrains的账号，于是下载了WebStorm等一系列IDE。

## Start

在WebStorm中新建项目的时候，可以选择Express项目：

![WebStorm](http://fantasyshao-blog.qiniudn.com/express-1.png)

其实WebStorm使用的就是[express-generator](https://github.com/expressjs/generator)生成Express的项目，使用express-generator命令行也可以同样生成所需的目录结构：

```
express project-anme
```

生成完一个简单的Express项目的目录结构之后，就已经可以运行了：

```
npm start
```

可以观察到，项目启动的命令是写在`package.json`文件中的，如果要使用[supervisor](https://github.com/isaacs/node-supervisor)等项目工具来监听项目文件变化、重新启动Node服务器，便可以通过修改该文件中的命令来实现，如：

```
"scripts": {
    "start": "supervisor ./bin/www"
}
```

## MVC

虽然对于一个Web项目而言，并没有固定的目录结构，但是从经验以及约定俗成来看还是MVC最为流行。这次我也是用的MVC的结构，同时稍微扩充了一个Service层把数据定义和操作分割：

- Model：只定义数据库里的存储结构
- Service：定义读取和存储数据库的方法
- Controller：调取Service中的方法来将数据render到View
- View：通过Jade模板展现数据以及前端的展示逻辑

## 样式

其实新建Express项目的时候可以选择Stylus或者Compass等，不过由于项目比较简单且对于样式并没有特别的需求（主要还是学习后端数据操作等），所以就没有选择这些CSS的预编译器。

可以通过添加少数的CSS代码让自己的应用看起来不那么寒碜，当然你也可以选择使用Bootstrap等CSS库来给自己的网站增添一些样式。

## 源码

这个项目的代码全部开源在GitHub上：[Riki](https://github.com/SFantasy/Riki)，取名Riki原意是想创建一个匿名的Twitter（或者是类似树洞）的应用，希望有时间可以改进一下然后实现之。

> to be continued...
