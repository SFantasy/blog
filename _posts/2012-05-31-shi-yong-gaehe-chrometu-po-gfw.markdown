---
layout: post
title: "使用GAE和Chrome突破GFW"
date: 2012-5-31 11:06
comments: true
categories: Google-App-Engine
---

看到文章标题想必屏幕前的你已经懂了我要讲什么。

这篇文章主要介绍了一种用Chrome app+GAE的方法，此前在网上也看到过用GAE的教程，不过没有去尝试；日天同学率先发现此方法并造福全寝 : )

以下方法在真实可行。

1. 安装Proxy Switchysharp

这个应用在Chrome应用商店里自己搜就能搜到了；

添加到浏览器之后会有个选项卡跳出来，给自己的情景模式取个名字；

在手动配置里的HTTP代理那一栏里填上127.0.0.1；端口号为8086；

再把所有协议均使用相同的代理服务器那个选上。点击保存就行了。

2. 创建自己的Google App

地址： [https://appengine.google.com](https://appengine.google.com)

点击createApplication后，在×××.appspot.com那栏里填app的名字， xxx是你自己取的名字，Application Title也是；

填好后直接Creaete Application 就好了；

3. 下载配置wallproxy

地址：[http://code.google.com/p/wallproxy-plugins/downloads/list](http://code.google.com/p/wallproxy-plugins/downloads/list)
这个list里有好几个文件，这次用的是wallproxy-plus.7z；

下载完成后直接解压就行，不用安装；

1)打开wallproxy目录下的server文件夹爱，运行upload.bat文件，先选择设置自己的appid，然后上传就行了，期间会让你填自己的邮箱地址和密码；

 可以上appengine看自己的app有没有上传成功，如果dashboard里有自己app运行的情况的话，就证明已经上传成功了。

2)打开wallproxy的目录里的local文件夹，打开WallProxy.exe文件，运行双击那个图标后会有一个console出来，最小化不要关闭；

右击图标设置，最主要要在里面改一个appid，也就是之前申请GoogleApp时候的app的名字；还有可以修改server type，可以在不同的类型之间试试，效果的确是有细微的差别的，这个在wallproxy的主页上说明了。

这样就搞定wallproxy了。



至此，在正确配置好app和wallproxy就已经可以跑到万里长城外面了。当然，你要在浏览的时候选择自己当初配置的情景模式。

在上网的时候一开始可能比较慢，但是后来还是蛮给力的，youtube可以看视频，其他测试的网站还有FB,Twitter,Blogger；

流量为一天1G，对于浏览一下网站已经很够用了。
