---
layout: post
title: "Scope & Closure in JavaScript"
date: 2013-3-24 1:10
comments: true
categories: Front-end-Dev
---

最近一直在关注@lifesinger的博客，以issues的形式写的，还是比较有创意，直接watch就可以"订阅"，免掉了RSS(如果我的GR中的各位大牛都用这种方式写博客倒也不错，也就不必伤感GR的关闭了)。  
其中有一篇文章牵扯到了"原生"JavaScript和jQuery之间的话题，关于文章的内容，可以去拜读一下[原文](https://github.com/lifesinger/lifesinger.github.com/issues/126).

让我这种菜鸟眼前一亮的是：
> 具体对 JavaScript 语言来说，会用就好。搞清楚数据类型、作用域、闭包、原型链等基本概念，足矣。再深入进去，对绝大部分人来说，除了能满足下心理上的优越感，对实际工作不会有任何实质性帮助。

"不明觉厉"！我之前有一篇博文说到过自己是一个"野生"程序员，所以也来"研究"一下这些基本概念.

## 作用域 Scope

作用域的概念很简单: 
> *Scope* in a programming language controls the visibility and lifetimes of variables and parameters.  

举一个[JavaScript: the good part](http://book.douban.com/subject/2994925/)里的例子:

    var foo = function () {
	  var a = 3, b = 5;
      // 	  
	  var bar = function () {
	    var b = 7, c = 11;
		//
		a += b + c;
		// a = 21, b = 7, c = 11
	  };
	  // a = 3, b = 5, c undefined
	  bar();
	  // a = 21, b = 5
	};

当然，这个例子还是有点简单了，理解起来应该没有任何问题.

    var x = 10;
    function foo() {
      alert(x);
    }
    (function () {
      var x = 20;
	  foo();
	  // alert 10, not 20
    }) ();
   
JavaScript函数运行在被定义的作用域中，而不是执行它们的作用域中. 所以即使调用`foo()`函数前又声明了一个变量`x`，变量还是会从`foo()`函数创建时的作用域中去查找`x`的值.

在StackOverFlow上看到一个关于作用域的[问题](http://stackoverflow.com/questions/500431/javascript-variable-scope)，其中有个回答得到了572票:

    // a globally-scoped variable
	var a=1;
	
	// global scope
	function one(){
	    alert(a); 
	}
		
	// local scope
	function two(a){
	    alert(a);
	}
	
	// local scope again
	function three(){
	    var a = 3;
		alert(a);
	}
				
    // Intermediate: no such thing as block scope in javascript
	// JavaScript不支持块级(block scope)作用域
	// 如果支持，那么var a=4;的作用域将被局限在if这个语句块内
	function four(){
	    if(true){
		    var a=4;
		}								
		alert(a); // alerts '4', not the global value of '1'
	}
																		
	// Intermediate: object properties
	function Five(){
	    this.a = 5;
	}
								
	// Advanced: closure
	var six = function(){
	    var foo = 6;
											
		return function(){
		    // javascript "closure" means I have access to foo in here, 
		    // because it is defined in the function in which I was defined.
		    alert(foo);
		}
    }()																
																			
	// Advanced: prototype-based scope resolution
	function Seven(){
	    this.a = 7;
	}
																			  
	// [object].prototype.property 
	// loses to [object].property in the scope chain
	Seven.prototype.a = -1; 
	// won't get reached, because 'a' is set in the constructor above.
	Seven.prototype.b = 8; 
	// Will get reached, even though 'b' is NOT set in the constructor.
	
	// These will print 1-8
	one();
	two(2);
	three();
	four();
	alert(new Five().a);
	six();
	alert(new Seven().a);
	alert(new Seven().b);

尽管有关**原型链**的概念还不是很了解，但是从上面这个例子中，我们应该能很进一步的理解有关JavaScript作用域的知识.当然，从这些代码的角度来*研究*作用域还是比较*浅显*的，想进一步了解的同学可以参考一下[ECMA深入理解](http://www.denisdeng.com/?p=908#scope-features).

## 闭包 Closure

在上文中的最后一个例子中有一个是关于解释**闭包**的，我们可以单独拎出来看看：

    // Advanced: closure
	var six = function(){
	    var foo = 6;
											
		return function(){
		    // javascript "closure" means I have access to foo in here, 
		    // because it is defined in the function in which I was defined.
		    alert(foo);
		}
    }()																
	
这个例子中的注释已经解释了*closure*的概念，再来看看*JavaScript: the good parts*中的说法：

    var quo = function (status) {
	  return {
	    get_status: function() {
		  return status;
		}
	  };
	};
	
	var myQuo = quo("amazed");
	
	document.writeln(myQuo.get_status());

创建变量`myQuo`的时候，我们调用了`quo`，它返回包含`get_status`方法的一个新对象.该对象的引用包含在`myQuo`中。即使`quo`已经返回了，`get_status`方法仍然可以访问`quo`对象的`status`属性.
> The function has access to the context in which it was created. This is called *closure*.

其实也可以这样理解：当内部函数在定义它的作用域的外部被引用时(比如`quo`被`myQuo`引用时),就创建了该内部函数的一个**闭包**(引用可访问该内部函数`quo`的属性和变量).  
这方面的知识这样梳理下来也是只知道了一个梗概(强烈欢迎指出错误，以及更为简便的理解方式),更多的还是要持续学习啊.


> 以前尝试过在Emacs中用Shell，最近在终端里用Emacs,两者一比,我反而更喜欢后者. 命令：`emacs -nw` nw应该是no window的意思吧. 不过有很dt的事情,就是快捷键会有冲突, 比如`C-y`不能粘贴,反而要用终端里的粘贴快捷键`C-S-v`,又不想改掉快捷键,所以……还是改邪归正吧！

--EOF--
