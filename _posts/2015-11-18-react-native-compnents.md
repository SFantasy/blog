---
layout: post
date: 2015-11-18
title:  RNComponents
keywords: ReactNative, React, Components
description: RNComponents, a new github organization for building and maintaining ReactNative components.
comments: true
category: React
---

在全职使用 Node.js 工作大半年之后，在上周末转型做 ReactNative 的开发 -- 而这也正是我在业余时间所做的事情。

于是乎，又一次迎来了把兴趣变成职业的转机 -- 也许这也正是我不愿离开现在公司的原因之一，在这里我可以相对主动的用自己比较心仪的技术做一些事情。

以下是我在公司里的技术转型路线：

> 前端开发 -> Node.js Web开发 -> ReactNative 开发

回归正题。

既然开始了全职的 ReactNative 开发时光，就希望结合工作上的一些需要来做一些组件上的开发，毕竟现在 ReactNative 开源社区上有很多组件长期处于无人维护的状态，也有很多轮子还没有人造，亦或是不符合自己的业务需求。

本周的时候，我在 Github 上创建了一个名为 [RNComponents](https://github.com/RNComponents) 的组织，用来放置一些我自己写的、或者是从一些没有持续维护的组件 fork 过来的 ReactNative 组件。

为保证组件命名的同一，现在都是用 `rn-` 为前缀命名。同一在此组织下进行维护管理，并保持 Github 的项目名和 NPM 中的包名一致。

现在已经发布了一个名为 [`rn-navbar`](https://github.com/RNComponents/rn-navbar) 的简单导航栏组件和一个从 [`react-native-htmlview`](https://github.com/jsdf/react-native-htmlview) 修改而来的 [`rn-htmlview`](https://github.com/RNComponents/rn-htmlview) 组件（修改内容可以参照项目中的 HISTORY 文件）。

当然，现在公司里的项目才处于起步、探索和踩坑的状态，我将会长期维护此组织中的 ReactNative 组件也相信一定会有更多组件发布。

Happy Hacking :D
