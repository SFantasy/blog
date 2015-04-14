---
layout: post
date: 2015-04-08 23:00
title: React Native 开发 CNode iOS 客户端
keywords:
description: React, React Native, CNode client
comments: true
category: React
---

前段时间，Facebook开源了之前发布的 React Native。这一消息让很多iOS、JavaScript开发者以及很多Hybrid应用开发爱好者为之兴奋。

相信有很多开发者都跟我一样，在听到这个消息后都会做两件事情：

1. 上 GitHub star 一记
2. 写个 Demo 看看效果、体验体验

在根据国际惯例写完一个 Hello World 之后，开始了 CNode 社区的 iOS 客户端开发，代码依旧遵循MIT协议开源在 [Github](https://github.com/SFantasy/CNode-React-Native).

这次的App开发的目录结构参考的是 [HackerNews-React-Native](https://github.com/iSimar/HackerNews-React-Native)：

```
- App/
- index.ios.js
- package.json
```

其中 App 目录下为整个应用的主要实现目录，样式和 View 展示的 JavaScript 文件分开书写。

到现在为止，仅实现了 CNode 社区的列表页以及对应 topic 的详情页，可见文末附上的截图。

## 数据的获取

React Native 内置了基于 Promise 的 [fetch](https://fetch.spec.whatwg.org/) 来请求接口，
这是一种相对于前端工程师所熟悉的 XMLHttpRequest 而言更好的接口请求方式。Chrome 已经实现了 fetch，对于不支持的浏览器，GitHub 也提供了一种  [polyfill](https://github.com/github/fetch) 以供使用。

## 样式的处理

React Native 的样式亦是用 JavaScript 来编写的，在不看文档的情况下会比较痛苦：因为很多平时很常用的属性可能其并不支持使用，或者需要变着法子去写。

例如：

- 不需要写 `px`, `rem` 这样的单位：`marginTop: '10'`

- `margin` 无法通过一个属性来写：

```
{
    marginTop: '0',
    marginRight: '10',
    marginBottom: '0',
    marginLeft: '10'
}
```

而不能写成：

```
{
    margin: '0 10'
}
```

至于布局，则用到了 Flex，（想起曾经在某个项目种用 Flex 的经历也是热泪盈眶，当时写了好多的mixin）。

## 开发有感

使用 React Native 是我接触过的 Hybrid App 开发方式中用的最舒服的一种，而在这之前我对 React 的了解也仅限于「听说」的程度，相信熟悉使用 React 的同学使用起来会更加的得心应手。

而且使用 Node.js 的模块系统，对于开发 App 有着极大的便利，这比 iOS 中的 Cocoapods 等方式要方便太多了。

在熟悉了 React Native 提供的组件之后，可以相当快速的开发出一个 App 的原型，而在样式的处理上感觉是一个比较欠缺的地方，如果可以通过 CSS 或者其他预编译工具来处理的话会更加的便于开发。


## 截图

<img width="50%" src="https://github.com/SFantasy/CNode-React-Native/raw/master/home.png">
<img width="50%" src="https://github.com/SFantasy/CNode-React-Native/raw/master/topic.png">

## 参考文档

- [Facebook React Native Tutorial](https://facebook.github.io/react-native/docs/tutorial.html)
