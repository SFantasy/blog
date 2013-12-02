---
layout: post
title: "「译」在ECMAScript 6的背影之后: Native errors"
comments: true
date: 2013-11-14 01:00
categories: Translate JavaScript
---

原文: [NCZOnline](http://www.nczonline.net/blog/2013/11/12/in-the-ecmascript-6-shadows-native-errors), 译者：[Fantasy Shao](http://fantasyshao.com)

随着各种JavaScript引擎对ECMAScript 6的一些特性开始实现，相信ECMAScript也离我们不远了。这份规范中的一些部分引起了广泛的关注：WeakMap, classes, generators, modules等等。这些都是有代表性的、在ECMAScript 5基础上的重大改变和增强。可是，在规范中仍然有一小部分的内容不那么引人注目，但是对于JavaScript的未来而言却同样重要。它们如此之小，以至于很少有人谈论到它们，除非你花一点时间阅读实际的规范，不然你可能根本不知道它们的存在。其中一个特性就是native errors。

## Errors today

为了理解为什么native errors是如此让人兴奋，首先要了解下现在的错误机制。所有通过JavaScript引擎抛出的错误都是继承自`Error`，也就是说所有的错误在它们的原型链上都有`Error.prototype`。以下是ECMAScript 5中的错误列表：

* **Error** - 所有错误的基础类型。实际上从来不会被引擎抛出。
* **EvalError** - 通过eval()执行代码时遇到错误时抛出。
* **RangeError** - 当数字大小越界时抛出。例如，试着创建一个-20个元素的数组(`new Array(-20)`)。这个在正常的执行情况中是不会出现的。
* **ReferenceError** - 当代码运行时期望一个对象但却无法获取时抛出，例如，尝试着调用一个空引用的对象。
* **SyntaxError** - 在代码传入`eval()`时有语法错误。
* **TypeError** - 当一个变量的类型错误时抛出。例如，`new 10`或者"prop"的值为true.
* **URIError** - 在一个错误格式的URI字符串传入encodeURI, encodeURIComponent, decodeURI或者decodeURIComponent时抛出。

你可以有选择地使用它们的构造函数抛出上述Error，但是大多数开发者会抛出他们自己定义的错误。门外汉也许会倾向于这样开始使用通用的`Error`对象抛出错误，例如：

    throw new Error("This is my custom error message.");

相比JavaScript引擎所抛出的错误，开发者抛出的就让问题看起来有所不同了。这是一个在应用错误处理策略中非常重要的一个概念。传统的做法是继承`Error`创建自己的错误处理类型，然后让其他所有的错误类型都继承于它。举个例子：

    function MyError(message) {
        this.message = message;
    }

    MyError.prototype = Object.create(Error.prototype, {
        name: { value: "MyError" }
    });

    function ThatNameIsStupidError(message) {
        this.message = message;
    }
    
    ThatNameIsStupidError.prototype = Object.create(MyError.prototype, {
        name: { value: "ThatNameIsStupidError" }
    });
    
    
    function YouDidSomethingDumbError(message) {
        this.message = message;
    }
    
    YouDidSomethingDumbError.prototype = Object.create(MyError.prototype, {
        name: { value: "YouDidSomethingDumbError" }
    });
    
这样可以被自定义用来使用的错误有**ThatNameIsStupidError**和**YouDidSomethingDumbError**。两者都是继承自MyError，意图在于让任何开发者定义的错误都将继承自通用的基本类型，并允许这样做：
    
    try {
        doSomethingThatMightThrowAnError();
    } catch (error) {
        if (error instanceof MyError) {
            // handle developer-defined error
        } else {
            // handle native error
        }
    }

在这段代码中，你可以检查一下抛出的错误是不是**MyError**的实例来了解是不是所有开发者自定义的错误都是从那一种公有类型继承的。我们可以轻易地设置好这一切，尽管这会需要额外的基本类型来确定错误的起因。

## 了解 native errors

ECMAScript 6 定义了一种新的错误类型 -- NativeError。19.5.6节(见参考[1]) 描述了这个对象类型：

> When an ECMAScript implementation detects a runtime error, it throws a new instance of one of the NativeError objects defined in 19.5.5. Each of these objects has the structure described below, differing only in the name used as the constructor name instead of NativeError, in the name property of the prototype object, and in the implementation-defined message property of the prototype object.

回过头看看19.5.6节(第一句中提到的)，你会知道NativeError对象是：

* EvalError
* RangeError
* ReferenceError
* SyntaxError
* TypeError
* URIError

这意味着所有JavaScript引擎抛出的运行时错误都是继承自**NativeError**而非**Error**(**NativeError**继承自**Error**，所以现存代码中使用`instanceof Error`仍然可用)。这也就意味着有一天你可以使用这样的代码来区分你自己定义的错误和JavaScript引擎的错误：

    try {
        doSomethingThatMightThrowAnError();
    } catch (error) {
        if (error instanceof NativeError) {
            // handle native error
        } else {
            // handle developer-defined error
        }
    }

所以不需要创建你自己定义的基础错误类型（类似**MyError**)，任何开发者定义的错误都可以被轻易的辨别出来，因为它们都不是继承自**NativeError**的。也就是说你可以写更少的代码来区分不同的错误。

## 总结

错误处理并不是一个性感的话题，但是这是一个随着你的应用的长大而更显重要的话题。这个对于错误处理过程的细致的改变，既高明又高效地解决了JavaScript中关于错误处理的标志性的痛处。我非常高兴的看到ECMAScript 6中的这个改变，同时也非常期待看到其他更多有趣的、隐藏在这份规范阴影中的特性。

## 参考

1. [ECMAScript 6: Native Error Object Structure](https://people.mozilla.org/~jorendorff/es6-draft.html#sec-nativeerror-object-structure)

--EOF--
