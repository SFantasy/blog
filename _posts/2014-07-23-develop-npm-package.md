---
layout: post
date: 2014-07-24 00:39
title: 第一个NPM package
category: Node.js
keywords: NPM, NodeJS, GitHub, JavaScript, node-weather,天气
description: 开发一个简单的NPM package，可以在终端中查询天气
comments: true
---

前天晚上闲着的时候，研究了一下如何开发、发布一个NPM package，于是选了一个比较简单的想法实现了一下。

这个package的名字叫做[node-weather](https://github.com/SFantasy/node-weather)，想必看名字就知道他的功能了。从前天开发到现在版本已经衍生到0.1.4。主要实现的功能是调取百度LBS云的天气接口，在终端中查询今明后三天的指定城市的天气情况。

先简单的介绍一下NPM吧（若你未曾听闻过）。

## NPM

[NPM](https://www.npmjs.org/)也就是Node Package Manager，就如同Ruby中的[Gem](https://rubygems.org/)，Python中的[pip](https://pypi.python.org/pypi/pip)等，是一个开源的Node的包管理工具。

截至我写这篇博客为止，NPM上已经有84849个包。当然，由于NPM的自由度极高，其中包含了很多参差不齐的开发者所开发的包；也有很多几乎已经「阵亡」的包，占着NPM的坑。

所有NPM中的包都可以通过`npm`命令来进行操作，这当然不具体展开了，可以查询NPM的api或者在终端中输入`npm`来查看其用法。

## node-weather

以下介绍以下node-weather的用法以及其实现。

### 用法

与所有其他NPM中的包一样，可以通过`npm`的命令来进行安装。

```
[sudo] npm install node-weather [-g]
```

如果你不想要使用了，则可以一样轻松的卸载之：

```
[sudo] npm uninstall node-weather
```

当前node-weather只实现了两个命令：

```
// 查看天气情况
node-weather 城市名
// 查看node-weather的帮助
node-weather -h (--help)
```

你可以在自己的终端中尝试一下。

### 实现

其实node-weather的实现正如你所预料的那样简单。

首先还是花了一点时间Google了一下查询天气的API。Google被墙、Yahoo!的则需要使用一些城市代码（比较繁琐）；其他可以使用的倒是有，不过我还是选择了百度的API，原因是之前使用过百度的开发者平台（唯一还存活的是开发过的应用也是一个命令行工具 -- [translaet-cli](https://github.com/SFantasy/translate-cli)，调取的百度翻译的接口，用Shell写的）。

从现在看来，很多的开发接口都是使用JSON格式的，这对于Node而言是再简单不过的了。内置的JSON对象，可以轻松的解析、操作返回的结果。

最核心的功能就是通过访问百度的API，然后处理其返回的数据。node-weather使用的是[request](https://www.npmjs.org/package/request)，这也是众多其他需要HTTP请求的包中所依赖的包。

request最基本的用法就是：

```
var request = require('request');
request(url, function(err, res, body) {
	// logical codes
});
```

其中返回的参数中`err`就是请求的错误消息，成功则无。`res`是整个返回的结果，`body`则是返回的内容。比较奇怪的一点是，`res`的类型是对象，而`body`的类型是字符串。

在请求成功之后，那么其数据就任凭我们处置了。

另外一个使用的包叫做[colors](https://www.npmjs.org/package/colors)，可以在终端中为输出的文字增添一些色彩。使用整个包就更简单了，具体可以移步其[GitHub地址](https://github.com/Marak/colors.js)或者[NPM的主页](https://www.npmjs.org/package/colors)。

具体的代码实现可以查看我的[源代码](https://github.com/SFantasy/node-weather)，就不把代码贴出来献丑了。

### 流程

包的开发还是有一个简单的流程的。

一个典型的NPM package的结构一般是这样的：

```
|-/lib
|-/bin
|-/test
|-index.js
|-package.json
|-readme.md
```

其中lib包含的是包的主要实现代码；bin则包含的是可执行文件，一般是一个Node的脚本；test即包的测试代码目录；index.js是整个包的入口文件；package.json包含包的信息；readme则是整个包的说明文件。

如果刚建好一个包的话，`npm init`命令可以交互式的帮助你生成一个结构、内容完整的package.json文件。然后就可以开心的开始写代码了。

在完成包的开发之后，就可以发布自己的包了，没有任何限制。不过要注意的一点是，你首先得有一个NPM的账号！然后通过`npm login`在终端之中登陆自己的账号，最后只需要`npm publish`即可，在浏览器中访问NPM的网站就可以找到发布的包了。

## 后话

1. node-weather其实还有一个功能没有实现，就是在终端中显示百度API返回的天气图。我在之前尝试了一下substack开发的[picture-tube](https://github.com/substack/picture-tube)，效果不理想，所以暂时没有显示图片。这是TODO之一。

2. 再者，还需要改进node-weather的UI，虽然只是一个命令行工具，但是也是需要对用户友好一些的:)

3. 随后我可能会将上文中提到的[translate-cli](https://github.com/SFantasy/translate-cli)用Node改写一个版本。


--EOF--
