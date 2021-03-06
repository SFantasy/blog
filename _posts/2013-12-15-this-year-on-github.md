---
layout: post
date: 2013-12-15 23:40
title: 俺泡GitHub这一年
comments: true
categories: Essay
keywords: github,fantasyshao,学习
description: 使用GitHub，研究GitHub
---

去年四月份的时候机缘巧合之下注册了GitHub的账号，至今也将近两年了。不过也是到了2013这一年，我才开始逐渐熟悉、了解了GitHub这个平台。你可以点此访问我的GitHub主页：[SFantasy](https://github.com/SFantasy)。

这一年来，怎么说也有不少想法和感慨，所以我希望我在文中分享的一些看法和思考能够勾起那些GitHub重度用户的共鸣和未曾用过者的「跃跃欲试」。

## 拥抱 Git

在我接触Git之前，使用的是Subversion。不过开始切换并使用Git倒是无痛的，因为SVN的经历都是在客户端中完成的 -- 没有用到命令行。

（反而如果把时间轴推进到现在，在工作中使用的仍然是SVN，在自己的学习中使用的是Git；两者的命令在大部分情况下是不会被大脑混淆的，而能够被混淆的一般都是`cd`到一个项目路径下，不太能一下子记得这个项目使用的是SVN还是Git。）

很多人都会讨论Git和SVN的区别 -- 似乎将两个工具（编辑器、IDE）或两门语言进行对比，总会成为程序猿们茶余饭后消遣的乐趣。有兴趣的可以看看SO上的[这个问题的回答](http://stackoverflow.com/questions/871/why-is-git-better-than-subversion)，在此就不讨论了。

使用Git可以让我快速的在不同的分支之间切换而不用打开多个tab进行工作，当然也可以在没有网络的情况下默默commit每一次有益的修改，如果想要更多的功能，则不妨尝试一下[Git-extras](https://github.com/visionmedia/git-extras) -- 这个TJ创建的项目，让你拥有更多与Git玩耍的魔法。

要在GitHub上混，第一件事情就得熟悉最基本的Git命令 -- `clone`, `pull`, `add`, `commit`, `push`, `status`等。所以学会使用Git的成本并不高。

## 发现「有趣」的玩意

记得以前听过那么一句话，大概是这个意思：

> 这年头，很多人编程都不需要自己有多牛逼，Google， StackOverFlow， GitHub就基本能解决所有问题了。

事实上很多人并不把GitHub当做一个「代码托管平台」，经常会看见我的小伙伴们在首页的feed里出现star了某某项目。而对于很多人而言，GitHub就是那么一个平台 -- 发现有趣的项目，star一记以表鼓励与赞扬。

[Explore](https://github.com/explore)，在这里你可以看到每天、每周、每月的trend -- star数量增长最快的项目，也可以看到每个语言的最近最火的项目（当然也有开发者）。当然现在还加入了一个新的功能 -- 可以看到自己follow的人star最多的项目。

不得不说，这对于那些想要关注最新技术发展、想要学习新技术或者在自己喜爱的技术上更上一层楼的同学而言，是再好不过的资源了（甚至微博上还有「GitHub精选」这样的搬运工）。

对于我而言，发现有趣的东西，一般都是通过我关注的人的「活动」而间接发现的，当然也偶尔会去explore一下。

（不过现在发现了一个不好的趋势，好多trend的项目都是那些「学习的资源」，什么「free-e-books」、「NodeJS-resources」之类的。收集资源、分享固然重要，但是总觉得这样的REPO居然能超越那些更为实用的项目让人心理上难以接受）。

## 为你的项目选择一个「协议」

这一点是很多人都会忽视的，哪怕是在GitHub上混了很久的同学。而事实上「协议」对于一个开源项目而言是至关重要的 --特别是当你的项目变得足够牛逼的时候。

如果你有足够的耐心，可以浏览一下[GNU.org上关于各种协议](http://www.gnu.org/licenses/license-list.html)的列表以及简短的概述。该文基本上囊括了所有常见的软件、文档以及其他协议。

值得提及的一点是，根据Copyright的规定，倘若未对自己的作品声明任何协议，那么默认的是nonfree的。也就是说这是一种Copyright是对著作权的保护机制。

我的观念是，既然参与到了开源软件的社区之中，就应该花点时间为自己的作品选择一个合适的开源协议（事实上这并不要求作者对所有的开源协议有足够多的涉猎和了解，而只需要了解基本的一些原则），比如在GitHub上最常见的OSS(Open Source Software)协议有三种：MIT, Apache, GPL(v2 && v3) -- 而GitHub还特地制作了一个网站：[choosealicense.com](http://choosealicense.com/)，方便用户根据不同的需要选择不同的协议。

还有一个比较有趣的协议 -- [WTFPL](http://www.wtfpl.net/txt/copying/) (do What The Fuck you want to Public License)，堪称最自由的开源协议，从这个霸气侧漏的名称以及协议中只有一条约定 -- 「You just DO WHAT THE FUCK YOU WANT TO」就可见一斑。

所以嘛，快快为自己的每一个项目种增添一个`LICENSE`文件，或者在`README`文件末尾声明一个使用的协议吧。

## 每天做出一点贡献

不知道什么时候起，GitHub在个人主页中增加了一个「Your contributions」的一个栏目，会显示一年中的contribution数量以及最长、当前的连续贡献天数。其实很明显，这是从众多社交网站的「签到」机制中借鉴而来的一个功能 -- 而这又可以明显的勾起开发者的贡献欲望（如果你和我在看到那堆格子有一样的感觉）。

很多事情说起来容易，但是做起来确实很困难。特别是对于已经进入企业工作的人而言，一天大于等于八个小时的工作已经让人有点疲惫的感觉，而在工作的时间又不好意思一直泡在GitHub上，略微做点改动倒也不是很影响工作，但是如果长时间的刷GitHub又不免引起上级经理或主管的不满。所以能贡献的时间也只有挤出本已经不多的每天的休息时间和周末了。

所以我前一个月的时候突然萌生了一个想法 -- 来一次365天的longest streak！

事实上我自己在这件事情上也是没有多大信心的，如果有假期出去旅行，那么要保持这个持续的贡献是十分困难的。但是这毕竟也只是一种希冀，还是希望能给自己一种动力，每天哪怕只是有一次commit，那么日积月累也是极大的进步。

俺的Curent Streak -- 47days:

![current streak](http://fantasyshao-blog.qiniudn.com/streak.png)

而对于整个开源社区而言，更多的社区中的人是希望有更多的人进来参与的。就好比我这样的初级开发者，在我收到陌生人的Pull Request或者有项目被Fork的时候，心情是格外激动的！

所以我的观点是，不要吝啬自己给予他人和自己进步的机会，如果在使用开源软件或者阅读开源文档时遇到问题就应该及时给作者提出issue，一般经常查收邮件或者浏览GitHub的人都会及时回复或给予修复。

收益于开源的同时，千万不要忘记回馈开源。


以上。

--EOF--
