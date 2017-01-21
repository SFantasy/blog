---
layout: post
title: 快速理解 REST
date: 2016-11-23 23:00
keywords: REST, RESTful, architecture
description: 什么是 REST，如何理解 REST
comments: true
category: Architecture
---

如果你正在从事编程工作，那么你一定或多或少地听说、了解、实践过 "REST" 或者 "RESTful Web Service"。

什么是 REST ？

- REST 最早是 Roy Thomas Fielding 博士在他的论文（链接见「参考与相关阅读」）中提出的；
- REST 是 "REpresentational State Transfer" 的缩写，翻译过来就是「表述性状态转移」，当然，这个词语听起来仍然十分的抽象；
- REST 是一种建立在多种「约束」之上的架构风格，而不涉及具体的语法细节和实现；
- REST 中比较核心的一个关键词是「资源」(Resource)。

Roy Thomas Fielding 博士是 [IETF/RFC2616](https://tools.ietf.org/html/rfc2616)，即现在主流的 HTTP/1.1 协议的主要起草者，而该论文则是在 HTTP/1.1 协议之后发表的。

论文中有一个从「空风格」推导的过程 -- 在架构中逐渐添加约束，包含了以下：

- 客户-服务端，也就是常说的 Client-Server，即 C-S 架构；
- 无状态，每个请求包含了理解该请求的所有信息，会话状态（Session）完全保存在客户端；
- 缓存，请求的返回数据需要隐式或显式的标记为是否可以缓存；
- 统一接口，这是 REST 的核心特征；
- 分层系统，将架构拆分为多个层次；
- 按需代码，这是 REST 的一个可选约束；

下面着重来理解一下其中比较重要的几个约束。

## 客户-服务端

客户-服务端，即 C-S 模型在日常的生活工作中非常常见。

例如，我们每天使用的手机 App、浏览器，各种嵌入式设备中的应用都是这里所谓的客户端。

打开一个 App，就会通过 HTTP 协议发送各种类型的请求到服务端，而服务端则相应的会返回「资源」给客户端。

请求、数据通过 HTTP 协议的交互，因此客户端的发展（技术选择、具体实现、平台等）不受服务端的限制 -- 反之亦然。

## 资源

接下来，我们需要来理解一下什么是「资源」。

最容易理解的就是服务器中的静态资源，例如一个页面中包含的 HTML，CSS，JavaScript 以及图片等。

当然，这也包含了服务器动态生成的内容或者实时获取的数据。

我们可以使用浏览器的开发者工具等方式看到每个请求的 MIME(Multipurpose Internet Mail Extension) 类型。

MIME 类型是一种文本标记，可以将其理解为不同的资源类型的标识符号，MIME 类型非常之多，这里列举几个常见的 MIME 类型：

- HTML: text/html
- GIF: image/gif
- JSON: application/json

## 无状态

客户与服务端之间的通信需要是无状态的，也就意味着服务端对于每个发送过来的请求都是一视同仁的。

这也就意味着，RESTful Web Service 中我们需要把一些状态（例如常见的认证信息）放在请求之中。

## 统一接口

统一接口 (Uniform Interface) 包含了四个约束：

- 资源的识别 (Identification of resources)

在常见的 Web 系统中，不同的资源在请求之中通过 URI 进行识别。

例如，在浏览器中通过一个 URI 获取到的 JSON -- 实际上可能在服务端的数据库中对应的是很多不同的数据。

- 通过表述对资源执行的操作 (Manipulation of resources through representations)



- 自描述的消息 (Self-descriptive messages)

- 作为应用状态引擎的超媒体 (Hypermedia as the engine of application state)


## 总结

在上文中我们通过解释了 REST 的一些核心概念，了解了什么是 REST，并罗列、分析 REST 风格的几个比较核心的约束。

当然，最好的理解的方式就是去实践。 

## 参考与相关阅读

- [Architectural Styles and the Design of Network-based Softwares Architecture](http://www.ics.uci.edu/~fielding/pubs/dissertation/top.htm), Roy Thomas Fielding.
- [Representational State Transfer](https://en.wikipedia.org/wiki/Representational_state_transfer), Wikipedia.
- [A Quick Understanding of REST](https://scotch.io/bar-talk/a-quick-understanding-of-rest), Brian Mosigisi.
- [HTTP 权威指南](https://book.douban.com/subject/10746113/)
