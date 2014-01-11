---
layout: post
title: Several topics in Python
comments: true
categories: Python
date: 2013-3-24 13:30
---

这篇文章其实是紧接着`lambda`那篇的, 谈的内容也比较的杂.

### Everything is an Object

我们经常会听到一句话-- *Everything in Python is an object*. 然后呢？如何理解这句话呢？

> Everything in Python is an object, and almost everything has attributes and methods.

尽管在Python中，有些对象既没有属性，又没有方法(Tuple?!);并且不是所有的对象都可以子类化。但是我们可以这样理解：

> Everthing is an object in the sense that it can be assigned to a  variable or passed as an argument to a function.

### Decorator

我们先来看看decorator的形式

#### 无参数形式的decorator

    @myDecorator
	def f():
	    ...
    
	#实际上执行：
    f = myDecorator(f)
	
	#多个decorator
	
	@A
	@B
	@C
	def f():
	    ...
	
	#实际上执行：
	f = A(B(C(f)))
	
#### 有参数形式的decorator

    @myDecorator(arg)
	def f():
	    ...
		
	#实际上执行：
	f = myDecorator(arg)(f)
	
也就是说，如果是有参数的decorator，会先将该参数传入decorator获得一个不带参数的decorator.  

#### decorator函数的定义

事实上，每个decorator都对应的是一个函数，用来处理后面的函数.

    #返回原函数对象:

    def A(f):
	    #处理函数f
		return f
	
	@A
	def f(args):pass
	
    #返回新的函数对象:

    def A(f):
	    def new_f(args):
		    # Add something
			return f(args)
		return new_f
		
	@A
	def f(args):pass

    #更为通用的形式,使用动态参数，
	
	def A(f):
	    def new_f(*args, **argkw):
		  # Add something
		  return f(*args, **argkw)
		return new_f
		
	@A
	def f(args):pass
	
#### decorator的作用?

limodou提到了decorator与[AOP](http://en.wikipedia.org/wiki/Aspect-oriented_programming)(Aspect-oritented Programming)有点类似,其实意思也就是：在不修改代函数源代码的情况下，通过装饰器来给程序动态添加一些功能的思想。

事实上，如果只是使用普通的函数也是能够提供这类功能的吧？！（如果你懂得我的意思的话）不过使用decodator又有一个好处，这样写的形式特简单、明了。就像[Bruce Eckel](http://blog.csdn.net/beckel/article/details/3585352)的博文中讲的那样：

> 我认为，decorator之所以产生如此大影响，就是因为其带着一点点语法糖的味道改变了人们思考程序设计的方式。



### staticmethod, classmethod & normalmethod

分别对应的其实也就是*静态方法*,*类方法*和*普通对象方法*  
还是举一个stackoverflow上的例子：

    class A(object):
	    def foo(self, x):
		    print "executing foo(%s, %s)"%(self, x)
		
		@classmethod
		def class_foo(cls, x):
		    print "executing class_foo(%s, %s)"%(cls, x)
		
		@staticmethod
		def static_foo(x):
		    print "executing static_foo(%s)"%x
	
	a = A()
    
对象`a`是`A`的一个实例，我们平时最常用的方法类型就是*普通对象方法*，对象作为第一个参数被隐式调用.
    
	a.foo(1)
	# executing foo(<__main__.A object at 0x1d63890>, 1)

对于*类方法*而言，实例`a`的类被作为第一个参数被隐式调用.

    a.class_foo(1)
	# executing class_foo(<class '__main__.A'>,1)
	A.class_foo(1)
	# executing class_foo(<class '__main__.A'>,1)
    # 事实上，定义一个类方法，更多的用类而不是该类的实例去调用之
	
而对于*静态方法*来说，实例和类(对应`self`和`cls`)都不会被隐式传入.

    a.static_foo(1)
	# executing static_foo(1)

`a.foo`可以将`foo`函数绑定到`a`实例，因为其将`a`这个实例作为参数传入了`foo`,同样`a.class_foo`将`class_foo`绑定到了`A`这个类;但是`static_foo`却只是单纯的一个函数，因为它没有绑定任何实例或者类.关于这些，我们可以通过`print`来观察：

    print(a.foo)
    <bound method A.foo of <__main__.A object at 0x1e0c450>>

    print(a.class_foo)
    <bound method type.class_foo of <class '__main__.A'>>

    print(a.static_foo)
    <function static_foo at 0x1eccf50>


### The Zen of Python

    # Open your interpreter:
    >> import this
	The Zen of Python, by Tim Peters
	
	Beautiful is better than ugly.
	Explicit is better than implicit.
	Simple is better than complex.
	Complex is better than complicated.
	Flat is better than nested.
	Sparse is better than dense.
	Readability counts.
	Special cases aren't special enough to break the rules.
	Although practicality beats purity.
	Errors should never pass silently.
	Unless explicitly silenced.
	In the face of ambiguity, refuse the temptation to guess.
	There should be one-- and preferably only one --obvious way to do it.
	Although that way may not be obvious at first unless you're Dutch.
	Now is better than never.
	Although never is often better than *right* now.
	If the implementation is hard to explain, it's a bad idea.
	If the implementation is easy to explain, it may be a good idea.
	Namespaces are one honking great idea -- let's do more of those!
	
中文翻译版可见[此处](http://wiki.woodpecker.org.cn/moin/PythonZen), 啄木鸟社区的几位大牛的不同风格的翻译.

## Reference

* [Dive into Python](http://www.diveintopython.net)
* [limodou的学习记录](http://blog.donews.com/limodou/)


> 文中关于decorator部分有点乱,不过……我先去赶软件测试女博士的作业了 :-(

--EOF--
