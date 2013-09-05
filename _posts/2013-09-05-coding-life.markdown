---
layout: post
comments: true
title: 近期的生活片段
date: 2013-09-05 23:00
categories: 随笔
---

在公司实习了一个月多了，说长不长，说短也不短了。至少从我个人角度来讲，经历的也不少 -- 光挪地方就挪了三次了。而工作的内容相对而言也发生了比较大的转变 -- 现在的工作更像一个「前端」。

## 工作

抛开前两周的工作不谈，就讲讲来到「无线」部门之后的工作吧。

之所以说现在的工作更像一个「前端」，是因为现在需要从静态页面开始做起（之前参与的公司后台系统基本对于样式没有要求，直接用的Bootstrap2.x） -- 以及其他所有与「前端」相关的工作。

对于「静态页面」，之前也只是知道公司里的流程是要根据「设计师」的PSD来写的，但是真正到了工作中才明白要把像素精确到1px还是很费神的一件事情。比如我要用PS里的工具来量出某个间距是多少像素之类的，这还是很不科学的……（「怎么设计师不注明这里是多少像素啊！」）

不过其实现在感觉最麻烦的还是JavaScript部分，并不是说语言本身那部分会比较难（虽然很多问题确实出自我对其不了解，掌握的不好，但是通过Google，W3Scools和StackOverFlow几乎能解决所有我能遇到的这类问题），而是很多业务逻辑不是一次就能完成的（其实这样说来还是自己的问题，对于整个网站的前端架构没有很好的构思，导致现在很多文件看起来很臃肿而结构又不是很清晰，有机会的话我一定要对它们进行重构）。

说起来现在在想不用任何框架而全都用原生的来写是不是一个「错误」的决定？

工作中学习到的也比较多，主要还是技术方面的，因为以前自己做做小东西也不会有很多问题。就拿今天的工作而言，学到两样「新」技术:

1. 使用Ajax改变页面中的内容，但是原页面载入的时候是通过URL`www.xxx.com/#xx`获取一些信息的，在页面中调用了Ajax之后却无法改变URL地址。救世主出现了 -- HTML5中的`history.pushState`和相应的`window.onpopstate`. 其实之前在做另一个项目的时候了解过一点点相关的内容，记得是提到SEO的时候搜索引擎不会将URL中带sharp的链接收录，而且浏览器也无法通过回退按钮来返回上一个状态。GitHub上有这样一个项目：[jquery-pjax](https://github.com/defunkt/jquery-pjax). 所谓的pjax也就是`pushState` + `Ajax`.

2. 对浏览器Cookie的操作。虽然`document.cookie`就可以设置cookie，但是还是遇到了一些问题。由于需求是需要将用户浏览记录以一定的格式保存到cookie中，并使得服务器端语言能够通过此cookie来生成某些页面 -- 所以我需要的是能够像`locastorage.getItem()`那样的获取cookie中特定字段的方法。好在MDN(Mozilla Developer Network)提供了一种简单高效的[方法](https://developer.mozilla.org/en-US/docs/Web/API/document.cookie#A_little_framework.3A_a_complete_cookies_reader.2Fwriter_with_full_unicode_support)，不然我可能就要和正则表达式奋斗不少时间了。 

工作中其实会遇到很多上述的情况，但是最后总是能够比较「完美」的解决问题，我只能说Google太强大了。（我是Google脑残粉（逃……））

## 业余

最近开始维护自己的[Wiki](https://github.com/SFantasy/sfantasy.github.io/wiki)，当然是在GitHub上的，主要还是希望通过Wiki的形式来记录一些学习上的东西（总感觉那么点东西拿来写篇博客会很水，放到Evernote里又不好展示，所以还是借用GitHub整个平台）。

还有就是最近好久没有学习自己想学习的东西了（比如Python，Common Lisp等），甚至连Emacs也用的不多了，都怪我平时都用的是Sublime（拿Sublime用Emacs的键位心里又觉得难受……！）

--EOF--

