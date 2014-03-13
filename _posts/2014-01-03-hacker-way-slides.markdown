---
layout: post
date: 2014-01-03 22:22:22
title: 用黑客的方式制作幻灯片
categories: Racket
comments: true
keywords: racket,slides,幻灯片,黑客
description: 以黑客的方式用racket制作幻灯片
---

忘掉类似微软PowerPoint和Apple Keynote这样时髦的软件，忘掉类似impress.js及reveal.js这样酷炫的前端技术，在此，我将会给大家介绍一种特别的方式来制作幻灯片。

我们将要使用的是 -- 铛铛铛铛 -- **[Racket](http://racket-lang.org)**.

如果你是一名程序语言爱好者，那么对Racket这个名词一定不会陌生。（我当然不会介绍一下Racket这门语言，然后再梳理一下整个Lisp语言的族谱，要是你无比厌烦Lisp那「Lots of Irritating Superfluous Parentheses」，那么恐怕你可以直接`Ctrl or CMD + W`了。）

## 幻灯片

首先要介绍一下使用的编程环境：DrRacket（无论是在Mac OS X还是Linux甚至是Windows环境中都可以直接安装官网上的包）。要选择Racket中的幻灯片「语言」：`#lang slideshow` 这样我们就可以在DrRacket中开始制作幻灯片了。

### Hello world

在DrRacket中键入如下代码：

```
#lang slideshow
(slide
	#:title "Say Hello to the world!"
	(t "Hello World!"))
```
再点击右上角的`Run`即可运行看到我们制作的第一张幻灯片了。

这里值得注意的几点是：

- `slide`是主函数，相当于C++或Java中的main函数
- `t`函数创建了一个`pict`(我的理解就是图片，但在此处是以文字组成的)
- 而`title`很明显是创建了一个幻灯片的标题

下面会介绍一些幻灯片中的基本元素：标题，段落，列表等内容。

### 标题

在上述例子中我们已经可以看到在`slide`函数中可以设置整页幻灯片的标题。那么使用`titlet`函数就可以给段落添加标题了：

```
#lang slideshow
(slide
	(titlet "Title")
	(t "Test")
	(t "TEST"))
```

### 段落

虽然使用`t`函数也可以起到创建段落的作用，但是如果你尝试过的话，会发现`t`函数是默认居中的（当然这并不是关键），而且从语义上来讲，创建段落更应当使用`para`函数（就像现在在Web上推行Web语义化一样）：

```
#lang slideshow
(slide
	(titlet "Title")
	(para "This is a paragraph"))
```

### 列表

简单的列表在幻灯片中易于叙事、陈述观点。当然这在Racket中也是简单的一笔:

```
#lang slideshow
(slide
	#:title "Slide"
	(item "First item")
	(item "Second item")
	(item "Third item"))
```

### 字体

- 粗体：`(bt "string")`
- 斜体：`(it "string")`
- 粗+斜体： `(bit "string")`

如果你想要用`(bt (it "string"))`的方法来让字体又粗又斜恐怕是不行的了（会报错，因为`bt`这类函数只能接受字符串参数，而不能用函数作为参数）。

- 等宽字体：`(tt "string")`
- serif: `(rt "string")`

## 加入动画

- 'next

`'next`，顾名思义，可以让后面的内容在点击或按下控制下一页的按钮之后显示，也是幻灯片中最常见的转场动画效果。

```
#lang slideshow
(slide
	#:title "Example"
	(t "First")
	'next
	(t "Second")
	'next
	(t "Third"))
```

- 'alts

接在`'alts`之后的必须是由`list`组成的`list`，而后一个`list`会替换前一个`list`出现在幻灯片中。

```
#lang slideshow
(slide
	#:title "Example"
	(t "First")
	'next
	'alts
	(list (list (item "t1")
				(item "t2")
				(item "t3"))
		  (list (item "t4")
		  		(item "t5"))))
```

> *to be continue...*

## 参考

- [racket-lang.org](http://docs.racket-lang.org/slideshow/)

有兴趣的同学可以看看这篇Utah大学的文章：[Slideshow: functional Presentations](http://www.cs.utah.edu/plt/publications/jfp05-ff.pdf)

--EOF--
