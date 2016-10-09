---
layout: post
date: 2016-10-08 23:00
title:  Express 自动路由加载的设计与实现
keywords: Express, router, express-load-router
description: Design and implement automatic router loader with Express
category: Node.js
comments: true
---

Express 的路由是内置在框架内的，在实例化之后可以直接调用声明路由，例如：

```js
const app = require('express')();

app.get('/', (req, res) => {
  // ...
});
```

项目中经常会对目录结构进行 MVC 的分层，所以很多情况下会这样组织代码：

- 定义一个 controller

```js
exports.renderHomepage = (req, res) => {
  res.render('home');
};
``` 

- 定义一个 router

```js
const homeController = require('/path/to/controller');

app.get('/home', homeController.renderHomepage);
```

当然这边一般会使用 express.Router() 对 router 进行拆分，当然这并不在这次的讨论中。

这样的声明和定义方式确实没有什么问题，但是当项目在日积月累的迭代过程中，这一部分代码就会变得十分冗余。

因此需要实现一种自动路由加载的机制，而不再需要去写这些可以简化的代码。


## TL;DR

可以翻阅 [express-load-router](https://github.com/SFantasy/express-load-router) 的代码，而不需要阅读此文。

## 构思

### Method 

对应 HTTP 的各种请求方式，在 Express 中可以使用 `app.get()`, `app.post()`, `app.delete()`, `app.put()` 等方式来定义对应的路由。

所以我们的这个机制需要分辨不同的 HTTP Method，对应使用 Express 的方法，好在这些方法和 Method 都是直接对应的。

### 参数

一般在定义项目路由的时候会通过两种方式来传递参数到服务端：

- URL 参数
- Request body

对应到 Express 中而言就是 `req.params` 和 `req.body`

### URL 规则

通常而言，项目中的 Controller 会按照业务逻辑进行划分，因此可以根据 Controller 的文件目录层级来进行路由的映射。

假定有以下目录结构：

```
controllers
├── home
│   └── index.js
└── list
    └── index.js
```

那么对应生成的路由应当为：`/home` 和 `/list`

以上三点基本上是自动路由模块的比较核心的构思，当然其他一定还有不少可以添加的「辅助功能」。

## 实现

首先，需要获取到所有指定目录（一般而言是 `controllers`）下的文件路径。

不过这次使用的是 [glob](https://www.npmjs.com/package/glob) -- 一个用于快速文件匹配的模块 -- 当然，也可以直接使用 Node.js 的核心模块 `path` 对目录进行递归遍历。

不管用什么方式，在获取到目录下的所有文件之后，才可以开始实现真正的路由加载逻辑了。

使用 `glob` 的获取方式：

```js
const glob = require('glob');

glob.sync('*/**/*.js').forEach(file => {
  // Do things with file
});
```

### 初步的实现

再来看看上文中提到的常用的 Controller 写法，假设这个文件的路径为 `controllers/home/index.js`：

```js
exports.renderHomepage = (req, res) => {
  res.render('home');
};
```

在获取到路径之后，需要 `require` 之方可获取文件内 exports 的方法，所以现在的方法就变成了这样：

```js
const glob = require('glob');

glob.sync('/controllers/**/*.js').forEach(file => {
  const instance = require(file);

  // Do things with instance
});
```

但是 `renderHomepage` 这样的方法太过于与业务相关联了，无法直接与 Express 的路由联系上。

所以这边需要修改一下 `controllers/home/index.js` 中的方法定义，使用 HTTP Method 作为方法名称：

```js
exports.GET = (req, res) => {
  res.render('home');
};
```

这看起来是个不错的主意，这样就可以让一个 Controller 文件中定义较少数量的方法，同时与对应的 HTTP Method 相映射。

接下来就需要来写对应的路由来使用这个 Controller 中的函数了：

```js
const glob = require('glob');
const app = require('express')();

glob.sync('/controllers/**/*.js').forEach(file => {
  const instance = require(file);
  // 生成 URL 路径，去掉 .js 去掉 controllers
  const urlPath = file.replace(/\.[^.]*$/, '').replace('/controllers', '');
  // 获取所有 Controller 中的方法
  const methods = Object.keys(instance);

  methods.forEach(method => {
    app[method.toLowerCase()](urlPath, instance[method]);
  });
});
```

这样路由加载和核心就写的差不多了，还是十分简洁精炼的。

### 添砖加瓦

仔细想想这个模块还缺少了什么？

是的，路由方法是可以加载了，但是没有地方来声明这样的 URL 参数:

```js
app.get('/detail/:id', (req, res) => {})
```

所以我们又需要对声明路由方法的方式进行一个修改 -- 将其修改为一个对象，并约定两个 Key 值分别声明参数和处理函数：

```js
exports.GET = {
  params: ['/:id'],
  handler (req, res) {
    res.render('detail', {
      id: req.params.id
    });
  }
};
```

当然，一个好的模块肯定需要对原有的方式进行兼容，所以这里我们可能需要对原来的模块进行一个不小的修改：

```js
const glob = require('glob');
const app = require('express')();

glob.sync('/controllers/**/*.js').forEach(file => {
  const instance = require(file);
  // 生成 URL 路径，去掉 .js 去掉 controllers
  const urlPath = file.replace(/\.[^.]*$/, '').replace('/controllers', '');
  // 获取所有 Controller 中的方法
  const methods = Object.keys(instance);

  methods.forEach(method => {
    const handler = instance[method];
    // 判断 Controller 中输出的类型
    switch (typeof handler) {
        case 'object':
          urlPath += `/${handler.params.join('/')}`;
          handler = handler.handler;
          break;
        case 'function':
          // Nothing to do with the pure handler.
          break;
        default:
          return;
      }

    app[method.toLowerCase()](urlPath, handler);
  });
});
```

至此，便已经完成了前文「构思」中提到的三个点。

我在 [express-load-router](https://github.com/SFantasy/express-load-router) 中还添加了两个配置项：

- 可以传入一个 `excludeRules` 的数组来配置例外规则，即不纳入自动加载的路径，例如：

```
['/list', '/detail']
```

- 可以传入一个 `rewriteRules` 的 Map 来配置 rewrite 规则，重写 URL 路径，例如：

```
new Map([
  ['/home', '/']
])
```

--EOF--
