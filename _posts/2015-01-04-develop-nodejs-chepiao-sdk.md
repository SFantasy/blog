---
layout: post
date: 2015-01-05 23:00
title: Node.js SDK for chepiao100.com
keywords: JavaScript, Node.js, Chepiao SDK, Github
description: Develop an SDK for chepiao100.com
comments: true
category: Node.js
---

15年元旦之前的一次偶然的机会，快速开发了一个[chepiao100.com](http://www.chepiao100.com)的Node.js版本的SDK.

取名[chepiao-sdk](https://github.com/SFantasy/node-chepiao-sdk)，已经发布在NPM上，可以通过`npm install chepiao-sdk`安装、使用。

开发这个SDK的初衷其实因为在14年圣诞左右，当时正在12306上抢春节来回的高铁票，于是就想到可不可以调用一些接口在终端中查询火车票相关的信息。最初我在互联网上搜索到、并使用了去哪儿的火车票查询开放接口，例如[这种](http://train.qunar.com/qunar/checiInfo.jsp?ex_track=&q=g1&format=json&cityname=123456&ver=1373813217828).

[node-train](https://github.com/SFantasy/node-train/)的前几个版本就是使用的去哪儿的这个接口，但是由于去哪儿这个接口有两个非常致命的缺陷：

1. 没有文档，至少我在互联网上搜索不到相关的文档
2. 列车时刻的接口返回中车站的信息是打乱的

因此我决意寻找另外的比较好的开放接口，于是就找到了chepiao100这个站点.

虽然以前没有听说过这个网站，但是从他的文档来看还是做的不错的. 不过万幸中的不幸就是该网站的API的secret key的有效时间只有一周.

## 介绍

使用这个SDK唯一的门槛就是在chepiao100的网站上去申请secret key，如果有需要长期使用应该需要通过咨询以期获取一个长期可用的key.

下面主要介绍一下SDK的使用和现有的几个主要API，首先需要初始化SDK，传入申请时的id和key:

{% highlight js %}
var Chepiao = require('chepiao-sdk');
var chepiao = new Chepiao({
    userid: 'your userid',
    seckey: 'your secret key'
});
{% endhighlight %}

然后就可以通过`chepiao`调用SDK中的方法了：

{% highlight js %}
chepiao.schedule('g1', function (res) {
    // do stuff with the response
});
{% endhighlight %}

这是一个接口，现在还提供了查询火车余票：

{% highlight js %}
chepiao.leftTickets(date, startStation, arriveStation, callback);
{% endhighlight %}

以及查询飞机票的接口：

{% highlight js %}
chepiao.flights(date, depart, arrival, callback);
{% endhighlight %}

## 实现

此SDK实现的就是给予Node.js一个可以快速访问原有接口的通道，最核心的代码就是其中的`request`函数:

{% highlight js %}
Chepiao.prototype.request = function(url, form, callback) {
    var _this = this;

    request.post({
        url: url,
        formData: objectAssign(_this.config, form),
        json: true
    }, function (err, res, body) {
        if (!err && res.statusCode === 200) {
            if (body.errMsg === 'Y') {
                callback({
                    success: true,
                    data: body.data
                });
            } else {
                callback({
                    success: false,
                    data: []
                });
            }
        }
    });
};
{% endhighlight %}

由于`Object.assign()`是ES6中的特性，所以我在此引用了一个名为`objectAssign`的NPM包，可以合并两个对象 -- 以此拼接成请求原接口的Form中的参数.

然后在`request`的回调中处理返回的内容，将参数传递给调用此函数的回调函数.

实现好了这个SDK后，我便更改了原来的`node-train`中的代码，并非常快速的实现了查询列车时刻以及查询火车余票的命令行工具.

最后，欢迎诸位Star, fork以及提出任意与此项目相关的issue.
