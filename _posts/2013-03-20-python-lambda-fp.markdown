---
layout: post
title: "Python中的lambda"
date: 2013-3-20 23:30
comments: true
categories: Python
keywords: Python,lambda,Lisp,函数式编程
description: 了解Python中的Lambda
---

## 前言

去年夏天的时候，孤陋寡闻的我第一次见识了Lisp，我的一个同学捧着Galaxy Note在看Practical Common Lisp，于是我略感兴趣然后跟了他的风看了篇Lisp之根源，这是一篇译作，原文是Paul Graham写的。之后同学还饶有兴趣地在我的电脑上安装了Slime + Emacs.

这段经历给我留下的唯一结果是Emacs几乎成为了我最常用的编辑器，而Lisp却没有走进我的生活.

之后，我学了一段时间的Python(A byte of python)，并且在课程作业、日常工作上也经常用到(Machine Learning, File Processing, Lexical Analysis等)，但是遗憾的是我至今还没有尝试过Python的FP.

再后来，就是读七周七语言并逐渐接触到Scala, Erlang, Haskell的日子了.

其实当我看完‘七周七语言’, 对于函数式编程依旧不甚了解, 所知道的也无非是类似“变量不可变”，匿名函数，高阶函数等一些内容;再之后，我在OSChina上翻译了一篇介绍Ruby函数式编程的文章, 那是正好接触了一点函数式编程的思想, 但是翻译的时候还是很生涩的.

## 正题

前几天莫名奇妙的笔了一次Python，很多基础的知识都答不上来，可见自学的成果真是相当差.多的不谈，一言以蔽之--“还不会走路，就想着跑了”.

其中有一题是考的用lambda写一个阶乘函数，果断的悲剧了:(

    def factorial(k):
	    return reduce((lambda i,j: i*j), range(1, k+1))

    factorial(5)

上面的写法不知道是不是标准答案，但可以确定的是正确答案.

其中reduce函数是用来进行迭代乘积的，而lambda表达式和range函数是作为reduce的参数的.

    lambda arg1, arg2,...: expression using args

这是lambda函数的定义方式，所以说，其实所谓的lambda函数也无非是用来定义匿名函数(Anonymous function)的方式.这在更为'pure'的函数式编程语言如Clojure, Haskell中就如同def在Python中的地位吧？

现在我们可以用Python中的几个函数式编程工具来体验一下这个酷而古老的编程范型：

    In [1]: x = lambda n: n+1
	In [2]: x(10)
	Out[2]: 11
	#的确很简单吧
	In [3]: filter(lambda n: n%2 == 0, range(1, 10))
	Out[3]: [2, 4, 6, 8]
	#配合filter函数使用，filter出[1,10)中为偶数的部分
	In [4]: map(lambda n: n*3+5, range(1, 10))
	Out[4]: [8, 11, 14, 17, 20, 23, 26, 29, 32]
    #配合map函数使用，可以对数据进行简单的映射

用lambda函数在Python中做一些列表解析还是蛮不错的，如果要在lambda表达式中使用if-else语句呢？相必应该很容易想得到：

    In [5]: x = lambda x: "Large" if x>2 else "Small"
    In [6]: x(3)
    Out[6]: 'Large'
	#换一种实现方式
	In [7]: x = lambda n: x>2 and "Large" or "Small"
	#(test and [x]) or [y], test 为真，执行x，否则执行y
    In [8]: x(3)
    Out[8]: 'Large'

当然，也可以更像Lisp一点：

    In [9]: ((lambda x:(lambda y: x+y))(1))(2)
    Out[9]: 3
    #虽然只是1+2……

很多时候是用不到lambda函数的，当然也有很多人对lambda情有独钟，我也在豆瓣某小组中看到过对于这个话题的争论，各执一词，争执不下.

我觉得lambda函数还是很可爱的，可能也与自己本身对于函数式编程也有相当的兴趣有关，当然，关于函数式编程的思想还是不甚了解.

> 说真的，我想学Lisp!

--EOF--
