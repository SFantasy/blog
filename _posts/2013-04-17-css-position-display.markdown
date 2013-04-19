---
layout: post
title: "My fog in CSS"
comments: true
date: 2013-04-17 09:49
categories: Front-end-Dev
---

今天整理一下一些CSS中不是那么容易理解的概念。

## display 

`display`属性有很多的值，但是经常使用的一般以`inline`，`block`最为常见.

我们知道，元素本身被分为`块级元素`和`行级元素`，常见的`块级元素`有`p`, `h1`, `div`等，而`行级元素`有`span`, `a`等.

而通过修改元素的`display`属性可以用之实现想要实现的效果.

当然，我们还会用到`inline-block`这样的值.

* inline-block

[w3school](http://www.w3school.com.cn/css/pr_class_display.asp)上是这样描述的：

> An inline-block element is placed as an inline element(on the same line as adjacent content), but it behaves as a block element.

我现在的理解是这样的，属性值为`inline`的元素的高度、宽度是不能修改的，但是`block`值的元素可以修改其模型的高度以及宽度，将属性值设置为`inline-block`在显示上是呈现出`inline`的样式，但是同时具备了`block`的特性. 

举个例子：

    <ul>
	  <li>One</li>
	  <li>Two</li>
	  <li>Three</li>
	</ul>

`li`元素默认的是`block`的，如果我们用它来做导航菜单就需要它以`inline`的样式来显示，但是`inline`却不能修改其宽度、高度等属性，这时我们就需要将其`display`属性设置为`inline-block`. 

但事实上，我还是对此有点*疑问*的，如果只是将`li`元素设置为`inline`其样式仍可以通过`margin`, `padding`等属性来修改，所以`inline-block`仍不是唯一的选择?! 不知道这个想法是对是错？

* inline-table 

> The element is displayed as an inline-level table.

同理，`inilne-table`属性的元素具有`table`的属性，但是在显示上是`inline`样式的.


## position

`position`属性的值相对于`display`要少的多: `static`, `absolute`, `fixed`, `relative`和`inherit`.

其中`static`是默认的值，而`inherit`即表示`position`继承自其父元素.

主要还是来看看`absolute`, `fixed`和`relative`.

* absolute

> The element is positioned relative to its first positioned (not static) ancestor element

* fixed

> The element is positioned relative to the browser window

* relative

> The element is positioned relative to its normal position, so "left:20" adds 20 pixels to the element's LEFT position

以上是w3schools对于这些值的定义，下面用一个比较简单的例子感受一下(在Chrome26下测试，有些样式是user agent stylesheet，但不影响理解)

有以下HTML：
 
    <div id="ancestor">
	    <div id="father">
		    <div id="son"></son>
		</div>
	</div>
	
以及以下CSS:

    #ancestor { 
	  width: 600px; 
	  height: 600px;
	  background-color: blue; 
    }
    #father { 
	  width: 400px; 
	  height: 400px; 
	  background-color: green; 
    }
    #son { 
	  width: 100px; 
	  height: 100px; 
	  background-color: red;
    }

现在为`#son`添加以下属性值：
   
    top: 100px;
	left: 50px;

刷新之后可以发现没有变化，这是因为默认的`position`是`static`的，而`top`,`right`,`bottom`,`left`等是不适用于`static`的. 继续向`#son`添加:

    position: relative;

可以看到`#son`的位置发现了变化，所谓的`relative`也就是指相对于其原来的位置(`static`的时候)，根据`top`等属性值移动而到的新位置. 如果将其改为：
    
	position: absolute;

那么整个`#son`就会发生新的偏移. 而事实上现在的位置是相对于整个窗口而进行`top: 100px;`, `left: 50px;`的调整的. 我们可以向`#father`添加如下属性（not static）：

    position: relative;

然后会发现`#son`又变回了原样，这正是因为`#son`在寻找其祖先节点中第一个不是`static`的节点时，发现了`#father`的`display`是`relative`，所以这个绝对定位就是根据`#father`而来的.

有没有觉得好理解了很多呢……Have a try!


> 最近膝盖受伤，无法行走，很多事情都做不了，日子也过的云里雾里的. Anyway, go, go, 加油！

--EOF--
