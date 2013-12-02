---
layout: post
comments: true
title: 「译」理解ECMAScript 6中的arrow函数
date: 2013-09-13 23:00
categories: JavaScript
---

> [原文地址](http://www.nczonline.net/blog/2013/09/10/understanding-ecmascript-6-arrow-functions/?utm_source=feedburner&utm_medium=feed&utm_campaign=Feed%3A+nczonline+%28NCZOnline+-+The+Official+Web+Site+of+Nicholas+C.+Zakas%29), 作者: [NCZ](http://www.nczonline.net), 翻译：[Fantasyshao](http://www.shaofantasy.cn).

ECMAScript 6中最有意思的新内容是「arrow函数」。顾名思义，arrow函数就是一种使用叫做「arrow」（`=>`）的新语法来定义函数的方法。不过，arrow函数在以下几方面和「传统」的JavaScript函数表现的不同：

* **在词法上对`this`的绑定** - 函数体内`this`的值由其定义时而非其调用时决定.
* **无法被`new`** - Arrow函数不能被用来当作构造函数，如果对其使用`new`就会抛出错误.
* **不能改变`this`** - 函数体内`this`的值无法改变，它（`this`）将始终保持同一个值直到该函数的生命周期结束.
* **不包含`arguments`对象** - 无法通过`arguments`对象对函数的参数进行操作，你必须使用声明的变量或者其他ES6的特性，如rest arguments.

我们很难解释为什么会存在这些差异。首先，对`this`的绑定在JavaScript中引发诸多错误的罪魁祸首. 在函数体内我们会发现很难「追踪」`this`的值，并且因此会很轻易地产生很多意想不到的后果.其次，通过arrow函数来保证运行的函数只有一个单一的`this`值，JavaScript引擎可以更容易的优化这些操作（相对于那些被用来做构造函数或者经常修改的常规的函数）.

## 语法

Arrow函数的语法可以有多种多样的形式，这还需要取决于你想要尝试实现的是什么.所有的变化都是以函数参数开始，接着是arrow，接着就是函数体.用法不同，参数和函数体就可以以不同形式出现.比如，下面这个arrow函数只有一个参数并简单的返回之：


    var reflect = value => value;
    // 相比以下相同作用的函数，显得更为高效：
    var reflect = function(value) {
        return value;
    };

当arrow函数只有一个参数的时候，那个参数可以直接被使用而不需要其他的多余的语法元素.Arrow紧接着参数，而arrow右边的表达式会被计算并返回.尽管没有明确的`return`语句，这个arrow函数会返回第一个传入的参数.

如果传入了两个及以上的参数，那么就必须用括号将参数包含起来以表示一个参数列表. 如：

    var sum = (num1, num2) => num1 + num2;
    // 等同于：
    var sum = function(num1, num2) {
        return num1 + num2;
    };

`sum()`函数简单的将两个数字相加并返回其结果.唯一不同的地方就在于参数用逗号分隔，并封闭在括号内(就像传统的函数一样).同样的，没有参数的函数必须使用空括号来声明一个函数：


    var sum = () => 1 + 2;
    // 等同于：
    var sum = function() {
        return 1 + 2;
    };

当你需要提供一个更为「传统」的函数体时，也许由多个表达式组成，那么就需要用大括号将函数体包裹起来并显示的声明返回值，如：


    var sum = (num1, num2) => { return num1 + num2; }
    // 等同于：
    var sum = function(num1, num2) {
        return num1 + num2;
    };

除了不能使用`arguments`以外，我们可以像「传统」函数一样在arrow函数的大括号内进行任意操作.

因为大括号是用来表示函数体的，倘若一个arrow函数要在函数体外部返回一个对象字面量(Object literal)，则必须在函数体外部添加一对括号，如：


    var getTempItem = id => ({ id: id, name: "Temp" });
    // 等同于：
    var getTempItem = function(id) {

        return {
            id: id,
            name: "Temp"
        };
    };

将对象字面量用括号括起来，就意味着大括号内的是在函数体内部的一个对象字面量.

## 用法

JavaScript中最常见的一种错误就是由于在函数体内对`this`值的绑定. 由于函数中的`this`值会随着其被调用时的上下文环境而改变，那么当使用者想要改变一个对象的时候，会错误地修改了另一个对象. 思考下面这个例子：


    var PageHandler = {

        id: "123456",

        init: function() {
            document.addEventListener("click", function(event) {
                this.doSomething(event.type);     // error
            }, false);
        },

        doSomething: function(type) {
            console.log("Handling " + type  + " for " + this.id);
        }
    };

在这段代码中，`PageHandler`这个对象是处理页面中的交互.`init()`方法是用来初始化页面的交互方法 -- 给文档增加了一个事件监听器用来调用`this.doSomething()`.但是这段代码实际上并不会起作用.由于`this`在事件处理函数中指向的是一个全局对象而不是`PageHandler`，对`this.doSomething()`的引用就因此破坏了.如果试着去运行这段代码，那么在事件绑定函数运行时就会产生错误，因为`this.doSomething()`并不存在于全局对象上.

你可以使用`bind()`方法显式地将`this`值绑定到`PageHandler`上：


    var PageHandler = {

        id: "123456",

        init: function() {
            document.addEventListener("click", (function(event) {
                this.doSomething(event.type);     // error
            }).bind(this), false);
        },

        doSomething: function(type) {
            console.log("Handling " + type  + " for " + this.id);
        }
    };

现在代码就能如期运行了,但是这样看起来会有点奇怪.因为调用`bind(this)`时就会产生一个将`this`值绑定到现在的`this`上的函数 -- `PageHandler()`.现在的代码运行起来就能如同你所预期的一样了，尽管需要创建另外一个函数来完成这个任务.

因为arrow函数在词法上对`this`进行了绑定，`this`值不会在函数定义的上下文被改变.如：


    var PageHandler = {

        id: "123456",

        init: function() {
            document.addEventListener("click",
                    event => this.doSomething(event.type), false);
        },

        doSomething: function(type) {
            console.log("Handling " + type  + " for " + this.id);
        }
    };

在这个例子中，事件处理函数是一个调用`this.doSomething()`的arrow函数.`this`的值在`init()`函数中都是一致的,所以这个版本的例子可以像上面那个使用`bind()`函数的一样.尽管`doSomething()`方法没有返回任何值，但它仍然是函数体内唯一一个被执行的语句，所以没有必要在外面增加大括号.

Arrow函数简洁明了的语法使得它们变得像其他函数中的参数一样靠谱.举例而言，如果你想要用ES5对一个数组进行排序，很有可能会这样写：


    var result = values.sort(function(a, b) {
        return a - b;
    });

对于这种简单的程序步骤而言还是显得太为繁琐了.以下是更为紧凑的arrow函数版本：

    var result = values.sort((a, b) => a - b);

数组方法可以接受的回调函数如`sort()`, `map()`, 以及`reduce()`等都可以通过arrow函数将复杂的过程转换为简单的代码.

## 其他

Arrow函数和「传统」的函数有很多不同之处，但是还是有很多地方适合它们相似的，如：

* 对arrow函数使用`typeof`操作符判断时，都会返回「function」.

* Arrow函数仍然是`Function`的实例，因此`instanceof`仍然对arrow函数有效.

* 尽管不能改变`this`值，`call()`, `apply()`和`bind()`方法对arrow函数仍然起作用，

最大的不同之处在于，arrow函数不能使用`new`,如果尝试着对arrow函数使用之，就会抛出一个错误.

## 总结

Arrow函数是ECMAScript 6中十分有趣的特性，并且是到现在为止十分稳固的特性.随着将函数作为参数越来越流行，使用一种更为简洁的定义函数的方法是广受好评的改变，并将永远改变人们编程的方式.对于`this`的绑定能够解决开发者长久以来的痛楚，并且通过JavaScript引擎优化可以对性能有额外的加分.如果你想要尝试一下arrow函数，那么就快去更新你的FireFox吧！因为FireFox是第一个官方发布ECMAScript6实现的的浏览器!

> BTW, Chrome（包括Chrome Canary 30+）到现在还不支持Arrow函数 （[查看ECMAScript 6的浏览器兼容性](http://kangax.github.io/es5-compat-table/es6/)), 所以要使用ECMAScript 6中的新特性还是必须用FireFox.

> 另，最近空闲事件不多，但是会在这些时间内抽出来翻译一些大师的文章，长点姿势. 个人感觉有些地方翻译的还是比较生硬，英语水平还有待提高 （囧）

--EOF--