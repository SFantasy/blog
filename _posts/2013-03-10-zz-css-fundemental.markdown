---
layout: post
title: "CSS布局原理入门"
date: 2013-3-10 00:07
comments: true
keywords: CSS入门, 盒模型, 布局, 前端开发
description: 简单的介绍CSS的布局原理，适合新手入门
categories: Front-end-Dev
---

本文出自@寒冬winter的[微博](http://photo.weibo.com/1196343093/wbphotos/large/photo_id/3554004161919635?refer=weibofeedv5)

由于原照片过于……卖萌(亮瞎)，所以整理一个正常一点的文章来记录并分享一下。

首先，我们来了解一下神马叫做盒(box)

    <div>
	  some text
      <p>some text
    </div>

这是源代码，里面的`<div>`和`<p>`叫做"标签(tag)".

    div
     |__ [text]
     |__ p
         |__ [text]

当浏览器把他们读入内存的时候，会形成"节点(node)"

	 -------------
	|  _________  |
	| |some text| |
	|  ---------  |
	| |some text| |
    |  ---------  |
     ------------

浏览器再把他们显示到屏幕上，让用户可以看到的就是所谓的"盒(box)"了

盒不仅仅是简单的一个矩形，它还包含很多要素：留白(margin)、边框(border)、边距(padding)、内容(content).

这些就是所谓的"盒模型"啦.

![Box Model](../media/img/css_boxmodel.png)

跟节点(node)一样，盒形成了一个树形结构，通常这些结构被称作"渲染树(render tree)"

然而只有盒子(box)是木有用的，浏览器还必须知道把这个盒子摆放在什么位置.

决定盒子位置和大小的，就是盒子所在的"格式化上下文(formatting context)"

基本的个是化上下文有两种：块格式化上下文(block formatting context)和行内格式化上下文(inline formatting context)

block formatting context就是传说中的BFC啦. 你一定听过这个很高端的名词吧.
![BFC](../media/img/bfc.png)

简单来说，BFC和IFC的区别是，BFC里面的元素是沿着竖直方向排列的，而IFC里的元素则是水平方向.
(事实上这还跟语言文字本地化设置有关，咱本文中暂且不表)

页面的最外层，也就是浏览器的网页绘制区域，是一个BFC.
![bfcifc](../media/img/bfcifc.png)

盒子会根据它所对应的节点的子节点display性质来决定自己是BFC还是IFC.

比如，下面这个div会生成IFC

    <div>
    <span>aaa</span>
    <a>good</a>
    </div>

而若是至少有一个子节点的display是block级别的，那么就一定要生成BFC啦^^.

    <div>
    <span>aaa</span>
    <a>good</a>
    <p>hahaha
    </div>

然而问题出来啦，inline级别的元素怎么可以放进入BFC呢？
![question](../media/img/question.png)

答案是，浏览器会生成一个"匿名盒(anonymous box)"来容纳这些inline元素
![anonymous](../media/img/anonymous.png)

你一定注意到了我提到的一个概念：inline级别，事实上差不多每一个盒子都有inline和block两个级别，看看这些display的值吧：

	block inline-block
	table inline-table
	flex  inline-flex
	grid  inline-grid

值得注意的是，并非所有display为block的元素，都会在它的box里面创建BFC.

    <div>
	  <div id="小透明" style="overflow:visible">
	    <p>hahahaha
	  </div>
	  <p>hohohoho
    </div>

比如这里的小透明，因为它的overflow是visible，所以它的子节点p的box是直接放进外部BFC里面的.

因为BFC会影响到float、边距折叠(margin-collapse)等等特性，所以识别出小透明们就十分重要了.

除了BFC和IFC，还有一些其它的格式化上下文：比如flex和inline-flex元素会在其盒内创建弹性化上下文(flex formatting context, FFC)，而table和grid也会创建不同的格式化上下文（虽然标准中木有使用这个术语）.

肯德基老爷爷创建的是KFC，Kentucky Fried Chiken，请不要搞混哦.

总结一下，浏览器正常流中，会有多种不同的布局方式，其中最为主要的布局方式就是基本布局，它使用两种格式化上下文BFC和FIC来完成布局。

在基本布局中，有些盒子可以在其内部生成不同的格式化上下文，有些则根本不生成格式化上下文.然而不论如何，基本布局中的盒子要么是inlnie-level的，要么是block-level的.

值得一提的是，全部页面上的盒子分为正常流(normal flow)、浮动(floats)、绝对定位(absolute positioned)三种，而本文所讲到的仅仅是正常中的盒子表现.

    box(盒)

    * floats(浮动)
    * absolute positioned(绝对定位)
    * normal flow(正常流)
      * inline-level(行内级)
      * block-level(块级)
