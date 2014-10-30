---
layout: post
date: 2014-10-21 22:22
title: Express4开发Web应用
keywords: Express, Node, Web开发
description: 使用Express4和MongoDB开发一个简单的Web应用
comments: true
category: Node.js
---

最近用[Express](http://expressjs.com)开发了一个小的网站，分享一下。

（这个系列的文章会尽量写的比较浅显易懂，照顾刚入门的童鞋）

Express可谓是Node.js领域Web开发最常用的框架了，之前做微信公众账号的时候就用过Express，不过这次是算是结合MongoDB和Jade开发一个完整的Web应用，不同于之前的经历。

最近写Node.js或者前端相关的代码都是用的JetBrains家的[WebStorm](https://www.jetbrains.com/webstorm/)，前段时间JetBrains的产品开始对[edu邮箱的免费](https://www.jetbrains.com/student/)，正好问妹纸借了edu的邮箱注册了JetBrains的账号，于是下载了WebStorm等一系列IDE。


## Start

在WebStorm中新建项目的时候，可以选择Express项目：

![WebStorm](http://fantasyshao-blog.qiniudn.com/express-1.png)

其实WebStorm使用的就是[express-generator](https://github.com/expressjs/generator)生成Express的项目，使用express-generator命令行也可以同样生成所需的目录结构：

```
express project-anme
```

生成完一个简单的Express项目的目录结构之后，就已经可以运行了：

```
npm start
```

可以观察到，项目启动的命令是写在`package.json`文件中的，如果要使用[supervisor](https://github.com/isaacs/node-supervisor)等项目工具来监听项目文件变化、重新启动Node服务器，便可以通过修改该文件中的命令来实现，如：

```
"scripts": {
    "start": "supervisor ./bin/www"
}
```

## MVC与路由

虽然对于一个Web项目而言，并没有固定的目录结构，但是从经验以及约定俗成来看还是MVC最为流行。这次我也是用的MVC的结构，同时稍微扩充了一个Service层把数据定义和操作分割：

- Model：只定义数据库里的存储结构
- Service：定义读取和存储数据库的方法
- Controller：调取Service中的方法来将数据render到View
- View：通过Jade模板展现数据以及前端的展示逻辑

使用express-generator默认生成的目录中会带有一个`routes`文件夹，其中包含了两个文件。但是事实上我们并不需要通过不同的文件来定义不同的路由 -- 原因是路由的代码实际上并不多，一般一个页面的操作的路由代码仅仅只有1~3行，而且如果将路由放在不同的目录中会需要同时在这些文件中`require('express')`。

还有一点是我们通过MVC建立起的结构，可以在控制路由的代码中调用controller里的方法（这也就是上文中说「仅仅只有1~3行」的原因），例如：

```
app.get('/', site.index);
app.post('/register', user.register);
```

其中`site`和`user`就是我们在项目中的两个controller。

于是最后项目的目录结构变成了这样：

- bin/
- controllers/
- models/
- views/
- service/
- public/
- app.js
- routes.js
- package.json

## MongoDB

先贴两个链接，如果没有了解过MongoDB的可以先浏览下：

- MongoDB: [https://www.mongodb.org/](https://www.mongodb.org/)
- Mongoose: [http://mongoosejs.com/](http://mongoosejs.com/)

MongoDB对于Node而言确实很方便，由于MongoDB使用的是JSON风格的文档存储结构，所以特别是处理数据的时候就像是在处理JavaScript的对象一样。

而在Express中使用Mongoose来操作MongoDB也特别的方便:

连接数据库：

```
var mongoose = require('mongoose');

mongoose.connect('mongodb://127.0.0.1/test', function (err) {
  if (err) {
    console.log('connect to %s error: ', err.message);
    process.exit(1);
  }
});
```

定义Schema，以简单的User为例:

```
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var UserSchema = new Schema({
  name: { type: String },
  password: { type: String }
});

// 索引
UserSchema.index({
  name: 1,
  unique: true
});

mongoose.model('User', UserSchema);
```

## 其他

### 样式

其实新建Express项目的时候可以选择Stylus或者Compass等，不过由于项目比较简单且对于样式并没有特别的需求（主要还是学习后端数据操作等），所以就没有选择这些CSS的预编译器。

可以通过添加少数的CSS代码让自己的应用看起来不那么寒碜，当然你也可以选择使用Bootstrap等CSS库来给自己的网站增添一些样式。

### 源码

这个项目的代码开源在GitHub上：[Riki](https://github.com/SFantasy/Riki)。

---

To be continued...
