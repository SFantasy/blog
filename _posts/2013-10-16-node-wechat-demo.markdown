---
layout: post
title: 微信公众平台 in Node.js
date: 2013-10-16 22:00
comments: true
categories: Node.js
keywords: NodeJS,Wechat,微信公众平台
description: 使用NodeJS进行微信公众平台的开发
---

最近需要做一个微信公众平台上的服务号，但是在准备的过程中遇到了不少坎坷。

(没有找到类似的文章或教程，反而都是一些用Node写好的微信模块，如JacksonTian的wechat等)

比如刚接触Node，又比如之前使用Nitrous.io, Cloud9IDE等无法部署所需应用等（比如Nitrous.io只能Preview）。

最后总算使用Node.js的HTTP模块成功的走出了微信公众平台开发的第一步。

## 准备活动

我们需要一个能够发布应用的地方，这次我选择的是Appfog，传说中的PaaS。

* [AppFog](http://www.appfog.com)

[CloudFoundry](http://www.cloudfoundry.com)也不错，如果用PHP开发还可以选择BAE或者SAE。

我们还需要安装好Node：

* [Node.js](http://nodejs.org)

[NPM](http://npmjs.org): Node Package Manager.

### AppFog的使用

* 安装af、上传应用

```
gem install af
af login
af update APP_NAME
```

update时会自动重启应用。

* 查看log

了解自己的应用是否正常运行：

```
af logs APP_NAME [--all]
```

这个命令的缺点是不能实时查看log。

## 成为开发者

**填写信息**

* URL(Appfog应用的地址)
* token(随意填)

微信服务器会发送GET请求到所填写的URL上，附带参数为

* signature: 微信加密签名
* timestamp：时间戳
* nonce：随机数
* echostr：随机字符串

### 使用Node.js获取GET请求并作出响应

按照微信公众平台的要求进行验证的函数：

    var isLegel = function (signature, timestamp, nonce) {
        var TOKEN = 'tnwechattest';
        var arr = [TOKEN, timestamp, nonce];
        // 对三个参数进行字典序排序
        arr.sort();
        // sha1 加密
        var sha1 = crypto.createHash('sha1');
        var msg = arr[0] + arr[1] + arr[2];
        sha1.update(msg);
        msg = sha1.digest('hex');
        // 验证
        if(msg == signature) {
            console.log('验证成功');
            return true;
        } else {
            console.log('验证失败');
            return false;
        }
    };


使用Node.js的HTTP模块，对GET请求的参数进行处理并做响应：

    http.createServer(function (req, res) {
        // 获取GET请求的参数
        var url_params = url.parse(req.url, true);

        console.log(req.url);

        var query = url_params.query;

        res.writeHead(200, {'Content-Type': 'text/plain'});
        console.log('Query params:' + query.signature + query.timestamp + query.nonce);

        if(isLegel(query.signature, query.timestamp, query.nonce)) {
            // 返回echostr
            res.end(query.echostr);
        } else {
            //
            res.end('Hello world\n');
        }

    }).listen(process.env.VCAP_APP_PORT || 3000);


不出意外的话，在微信公众平台上填写好Appfog的应用地址和TOKEN，提交之后就可以我们就能成为微信公众平台的开发者了。

### 10月17日更新

今天完成了一个简单的[Demo](https://github.com/SFantasy/wechat)，同时制作了一个slide。

#### 使用NPM中的wechat模块

**事件处理**

    app.use('/', wechat(TOKEN, function(message, req, res) {
         // ...
     }).event(function(message, req, res) {
         // 关注事件
         if(message.Event == 'subscribe') {
             res.reply('亲，感谢关注！么么哒~');
         }
     }));

**回复消息**

    app.use('/', wechat(TOKEN, wechat.text(function(message, req, res) {
         //
         var input = (message.Content || '').trim();

         if(input === '你好') {
             res.reply('你也好！');
         } else {
             res.reply('听不懂！');
         }
     }));

* 还可以创建自定义菜单、定义更为「智能」的规则（实现一个小黄鸡？）

#### Slide show

[View it in Slid.es](http://slid.es/fantasyshao/wechat-dev-test/)

<iframe src="http://slid.es/fantasyshao/wechat-dev-test/embed" width="576" height="420" scrolling="no" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>

--EOF--
