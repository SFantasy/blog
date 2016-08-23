---
layout: post
date: 2016-08-23 00:00:00
title: 探索浏览器端的存储方式
keywords: storage, localstorage, cookies, IndexedDB
description: using different storages in modern browsers
comments: true
category: Front-end
---

随着浏览器的不断更新换代，我们可以在浏览器中使用的存储方式也日趋丰富。

从 cookies 到 HTML5 规范带来的本地存储，以及与传统数据库很相像、功能也更为强大的 IndexedDB 和 WebSQL -- 在浏览器端，我们已经有能力去使用一些与客户端软件一样的数据持久化方案。

## cookies

cookies 应该是我们认识时间最久的浏览器端的存储方式了。然而 cookies 最初出现的目的并不是为了给开发者一个存储数据的地方，而是与 HTTP 的状态管理 <sup>1</sup> 有关系。简而言之，就是 cookies 会在每一次 HTTP 请求的时候被发送到服务端，而不仅仅是作为一种存储的方式停留在我们的浏览器中。

因此，如果你的 cookies 内容过长，很有可能影响到服务器的性能。

### 使用 cookies

在浏览器中，我们可以通过 `document.cookie` 获取所有的当前页面的 cookies，它以一个字符串的形式存储 -- 当然，我们也可以通过浏览器的开发者工具以 GUI 的形式直接查阅到某个 cookies 的对应内容，类似键值对的形式。

设置 cookies 的方式很简单：

```javascript
document.cookie = 'foo=bar;'
```

当然，cookies 设置的时候可以指定很多属性，例如：

- Path: `;path=/foo` 如果不指定 path 就会将 cookies 写到当前访问到的 URL 路径中
- 域名: `;domain=mozilla.com` 或者二级域名：`;domain=developer.mozilla.com`
- max-age：`max-age=1000` 单位是秒
- 过期时间：`expires=Thu, 01 Sep 2016 00:00:00 GMT`  过期时间的字符串需要是 GMT 格式的时间，可以通过 Date 对象提供的方法进行格式化

一般而言，我们在开发过程中，会在创建 cookie 的时候指定当前域的根路径，以及设置一个 `max-age` 用以指定最长有效期。

示例代码：

```javascript
document.cookie = 'foo=bar; path=/; domain=mozila.com; max-age=10000'
```

### cookies 作为存储方式的问题

首先，正如上文中提到的那样，cookies 会在 HTTP 请求的时候被发送到服务端，因此 cookies 不能用来存放容量稍大的数据，以防降低 HTTP 请求的效率。

另外，由于浏览器原生的 API 提供的是以字符串赋值的方式，因此在存取过程中不能很直观的进行操作。对于修改、删除等操作亦须通过一些奇巧淫技才能实现，例如 MDN 上的这个 [Simple Cookie Framework](https://developer.mozilla.org/en-US/docs/Web/API/Document/cookie/Simple_document.cookie_framework).

## 本地存储

本地存储包含了 localStorage 与 sessionStorage 两兄弟：

- 两者均以 key-value 的形式存储于浏览器中
- 原生提供的 API 对于这两者而言都是一致的易用
- 通过 sessionStorage 存储的数据会在页面会话结束的时候被清除，而 localStorage 本身没有过期时间

### 使用本地存储

本地存储的使用方式非常简单，可以直接通过浏览器所提供的 API 对数据进行操作，以 localStorage为例：

```javascript
// 创建新的存储项
localStorage.setItem('foo', 'bar')
// 获取存储内容
localStorage.getItem('foo')
// 删除存储内容
localStorage.removeItem('foo')
```

也可以直接通过操作对象的属性来获取、删除数据：

```javascript
// 获取
localStorage.foo
// 设置
localStorage.foo = 'axe'
// 删除
delete localStorage.foo
```

当然，不建议使用后面这种方式来操作 localStorage 或者 sessionStorage，这样操作的方式可能会不小心改写原生对象的属性或者方法，例如：

```javascript
localStorage.setItem = 'lol'
```

### 本地存储的限制

不同浏览器对于本地存储的限制（容量限制）是不一样的，根据一些资料显示大小是在 5MB  — 已经可以应付绝大部分的应用本地存储的需求，例如缓存一份页面所引用的 JavaScript 文件。

不建议在浏览器中以循环的方式测试本地存储的大小限制，因为很有可能导致当前页面无响应。

### 本地存储的应用

本地存储可以应用的场景很多，例如：

- 作为 Web 应用的缓存，例如保存游戏状态、页面的状态等；
- 作为文件内容的缓存，例如保存一份 jQuery 代码等；
- 作为前端优化中的缓存，用来保存一些长期不修改的内容，例如常见的国家、城市信息等。

在实现一些基于浏览器的离线应用之时，完全可以将本地存储作为持久化的存储方案来使用。

## IndexedDB

IndexedDB，顾名思义，是一种使用索引进行高性能检索的数据库存储方式。

相对于前文中提到的 cookies 与本地存储而言，IndexedDB 可以在浏览器端存储更为复杂、大量的结构化数据或者文件 <sup>3</sup>。

先来看看如何使用 IndexedDB 的。

### 使用 IndexedDB

不同于前文提到的存储方式，IndexedDB 需要打开数据库才能进行后续的操作：

```javascript
indexedDB.open('TestDatabase', 3);
```

### 一些核心概念

- IndexedDB 存储的是键值对
- IndexedDB 是基于事务型的数据库模型构建的
- 大部分 IndexedDB 的接口是异步的
- IndexedDB 使用了大量的请求
- IndexedDB 是面向对象的

## 参考文章

1. [HTTP cookies explained](https://www.nczonline.net/blog/2009/05/05/http-cookies-explained/), May 5, 2009, NCZ
2. [Dive into HTML5](http://diveintohtml5.info/storage.html)
3. [IndexedDB on MDN](https://developer.mozilla.org/en-US/docs/Web/API/IndexedDB_API)
