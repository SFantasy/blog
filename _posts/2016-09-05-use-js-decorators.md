---
layout: post
date: 2016-09-05 22:00:00
title: 使用 ECMAScript 的 Decorators
keywords: ECMAScript, ES7, decorators, AOP
description: Use ECMAScript decorators today
comments: true
category: JavaScript
---

Decorators 亦即「装饰器」，最早接触到这个概念是在学生时代学习 Python 的时候。

查阅 ECMA262 的资料可以发现，ECMAScript 提案中的 decorator 分为好几种类型：

- Class and Property decorators
- Method Parameter decorators
- Function Expression decorators

其中第一种已经处于 stage-2，而下面两种仍处于 stage-0 -- 也就是说我们可能在不远的将来就能使用到原生的 "Class and Property decorators"。当然，不同类型的装饰器的装饰对象不同，应用场景也不同 -- 本文将挑选一些场景来主要讲述如何使用和编写不同的函数装饰器。

> 本来想把标题写成「使用 ES7 Decorators」，后来意识到 Decorators 还不一定在哪个版本的 ECMAScript 中出现，索性把题目改成了「使用 ECMAScript 的 Decorators」

先来看看一个简单的使用装饰器的例子：

```js
function log (target, key, descriptor) {
  console.log(`Invoking method ${key}`);
  return descriptor;
}

class Foo {
  @log
  bar () {
    console.log('baaaaar');
  }
}

let foo = new Foo();
foo.bar();

// Console:
// "Invoking method bar"
// "baaaaar"
```

可以看到 `@log` 装饰器用来修饰方法，输出一个 `Invoking method ${key}` log

## 装饰器的实现方法

通过上文的案例可以看到，装饰器实际上也是一个函数，通过固定的参数可以实现对被装饰的类或函数进行「装饰」。

再来看看刚才编写的 `@log` 装饰器：

```js
function log (target, key, descriptor) {
  console.log(`Invoking method ${key}`);
  return descriptor;
}
```

对于这个函数，我们传递了三个参数，`target`, `key` 与 `descriptor`:

- target: 装饰器的目标对象
- key: 目标的名称
- descriptor: 对应 `Object.defineProperty` 方法中的 `descriptor`，即对对象的一些描述，如 `configurable`, `enumerable`, `writable` 等

接下来看看一个修改对象描述符 (descriptor) 的装饰器方法：

```js
function rewritable (target, key, descriptor) {
  descriptor.writable = false;
  return descriptor;
}

class Foo {
  @rewritable
  bar () {
    console.log('baaaaar');
  }
}

let foo = new Foo();
foo.bar();
foo.bar = () => { console.log('2333333'); };
foo.bar();

// Console:
// 'baaaaar'
// '2333333'
```

这个例子中，`@rewritable` 装饰器改写了对象上的方法使得 `foo.bar` 方法在运行时被改写（对象的 `writable` 属性默认值为 `false`）。

## 带参数的装饰器

接下来看看如何实现、使用带参数的装饰器。例如我们可以实现一个装饰器，通过给装饰器传入参数来决定改对象是否为 `writalbe`。

```js
function writable (value) {
  return function (target, value, descriptor) {
    descriptor.writable = value;
    return descriptor;
  }
}

class Foo {
  @writable(true)
  bar () {
    console.log('baaaaar');
  }
}
```

此处的 `@writable` 接受一个 `value` 参数，按需处理了之后返回一个普通的装饰器函数。当然，你可以给装饰器传入多个参数，来实现更多的功能。

## 总结

本文中，我们主要学习了 ES 中的装饰器概念、实现方式和调用方法。

装饰器的原理虽然简单，但是可以通过更为优雅的语法来实现类似 Python 装饰器乃至 Java 中注解的功能。之后将研究一些更为实用的装饰器实现和使用方法，当然这一切现在仍需要借助 [Babel](http://babeljs.com)。

## 参考资料

- [tc39/proposal](https://github.com/tc39/proposals)
- [MDN - Object.defineProperty](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty)
