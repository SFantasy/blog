---
layout: post
title: 用Safari和iOS Simulator调试
date: 2014-01-11 20:00
comments: true
categories: Front-end-dev
keywords: iOS,safari,debug,调试,Mobile,移动开发,前端
description: 用Safari和iOS Simulator调试网页
---

同事在自己的电脑上装了一个Android模拟器，用来在电脑上查看现在做的M站的效果。（这让我想到了当年在学校里还折腾过ADT(Android Develop Tool)，只依稀记得电脑各种卡翻着实痛苦难堪。）不过相隔多时，感觉模拟器比之前的看起来好多了。

而之前还尝试着用过Chrome的远程调试，也就是连着USB线在Android的Chrome上调试网页 -- 不过很不幸的是总是「时有时无」，所以我觉得这种方法不太稳（kao）定（pu）。

后来突然想起来电脑上是装了Xcode的，于是找到了iOS Simulator。

## Simulator

<img src="http://fantasyshao-blog.qiniudn.com/safari-inspector-2.png" style="width: 50%">

如果有机会，也准备学习开发iOS，不过这次是用来调试网页。

Xcode的模拟器有iPhone3.5寸和4寸（包括64位）以及iPad和iPad Retina等。从我非常不专业的角度看来，iOS simulator非常流畅，用起来至少不会卡，所以感觉非常不错。

## Inspetor

废话不多说，要使用iOS simulator和桌面的Safari调试其实只有两步：

1. 需要打开`Settings->Safari->Advanced->Web Inspector`，然后在模拟器的Safari中打开网页
2. 在Safari中选择`Develop->iPhone Simulator`，然后直接可以选择之前打开的网页了的inspetor调试了

如图：

在Safari中找到模拟器中打开的网页：

![safari](http://fantasyshao-blog.qiniudn.com/safari-inspector-3.png)

Inspector:

![inspetor](http://fantasyshao-blog.qiniudn.com/safari-inspector-4.png)

## 调试

打开了Safari的Web Inspector之后我们就可以开始调试了：

![inspecotr 2](http://fantasyshao-blog.qiniudn.com/safari-inspector-5.png)

当然，再次从我非常不专业的角度来看，Safari的Web Inspetor和Chrome的Web Developer Tool在界面上还是有比较大的区别的，但是总体的功能相差无几。所以若是习惯了额使用Chrome Web Developer Tool的童鞋在使用Safari Web Inspetor的时候基本上是不要多少适应的时间的。

不过说真的，其实同时开着Web Inspetor和iOS Simulator是相当占地方的（如果用的是MBP甚至是MBA的话）。所以如果能连个外接显示器就更好了，当然最好的话就是使用iMac啦→_→

这样的话至少能省下一台iPhone测试机（虽然iPhone一般都没出兼容性问题），而且方便在手机上调试查看效果等，当然还是非常开心滴。

如果你也在开发手机的网站，可以非常方便的使用这种方式来调试，若是需要兼容iPad等（响应式或者多个版本）也是比较方便的（那么笔记本的屏幕肯定不够大啦）。

## 參考

- [Quick tip using web inspector to debug mobile safari](http://webdesign.tutsplus.com/tutorials/workflow-tutorials/quick-tip-using-web-inspector-to-debug-mobile-safari/)

--EOF--
