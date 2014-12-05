---
layout: post
date: 2014-12-05 23:22
title: JavaScript模块化、Browserify与gulpjs
keywords: 前端模块化, gulp, browserify, workflow, 前端工作流, 依赖管理, CommonJS, AMD
description: 使用Browserify更好的编写模块化的客户端JavaScript
comments: true
category: Node.js
---

最初是想在文章中对比、探讨、研究一下JavaScript模块化方面的内容（其实连提纲都写好了），但是写着写着发现自己的功力不够：

1. 仅使用过SeaJS和一点点的RequireJS
2. 对于很多诸如模块规范、运行机制方面的东西不甚熟悉
3. 开发的经验并不足够多，对于工程实践上的诸多内容不够深入

所以本文仅仅讨论一些关于JavaScript模块化的内容，着重介绍如何使用Browserify、搭配gulpjs来实现Web前端的JavaScript模块化。

## 关于JavaScript模块化

由于JavaScript语言（泛指当前广泛使用的版本）本身并不具备如同Java, Python等语言的类、模块、包等机制，并不能通过诸如`import`等方式加载同一项目中的不同模块，而随着Web开发方式的演进、客户端JavaScript的大放异彩，更加「有序」地组织页面的JavaScript代码就成为了一种必然的需求。

相信编写过稍具规模的Web应用的同学应该能够体会到JavaScript的这种「缺陷」，不过程序员天生就是一种没有轮子创造轮子的职业。

于是乎，JavaScript模块的组织方式出现了AMD, CMD与CommonJS等多种「规范」，关于JavaScript模块化的历程可以参考玉伯的文章 - [前端模块化开发那点历史](https://github.com/seajs/seajs/issues/588) 或者Google之。

但是这些标准在增进社区多元化的同时也给很多刚入门的同学带来了不少困惑：什么AMD，CMD，CommonJS，我到底应当使用哪种？

如果你还在为自己的项目所使用的技术选型，那么我会极力向你推荐CommonJS规范。

### CommonJS规范的写法

CommonJS规范实际上是一个服务端JavaScript的规范，因此Node就遵循了此规范。

在CommonJS规范中，一个文件就是一个模块，例如：

```
module.exports = function () {
  console.log('Hello Node.js');
}
```

假定上述文件保存为[`a.js`](/examples/browserify/a.js)，那么就可以在其他模块中像这样引用并执行该模块：

```
var a = require('./a')();
```

另一种方式是在同一文件中定义多个对象并输出：

```
exports.a = function () {
  console.log('Module a');
}

exports.b = function () {
  console.log('Module b');
}
```

假定上述代码保存为[`log.js`](/examples/browserify/log.js)，那么就可以像这样引用并使用：

```
var log = require('./log');

log.a(); // Module a
log.b(); // Module b
```

## Browserify

[Browserify](//browserify.org)正是那个可以将Node中书写模块的方式搬到浏览器端的那个运输工。

将Node的模块的方式搬运到浏览器端可以充分利用NPM现有的强大的生态系统和社区支持，而对于企业内部的开发则完全可以在内网中搭建企业所私有的NPM（关于此点可以参考fengmk2他们的CNPM：[企业级私有NPM](http://www.slideshare.net/kingsoft1/cnpm-jsdc2014tw)）。

有一点非常爽的地方在于，在使用版本控制工具checkout出来之后只需要`npm install`就完全不用管其他的事情了。当然更希望的是整个应用都是通过Node.js来开发的，那么新人进来就再也不用苦逼的配置那么长时间的开发环境了，当然这又是题外话了。

回来继续谈Browserify，以上文中的`a.js`为例，在安装完Browserify之后，我们可以通过简单的命令将`a.js` browserify:

```
browserify a.js -o a-browserified.js
```

[点此查看生成后的`a-browserified.js`](/examples/browserify/a-browserified.js)

此后，我们就可以通过`script`标签引入经过Browserify后的JavaScript文件了，当然在项目开发中我们不可能这样一个个去生成适用于浏览器端的JavaScript代码。

### Browserify + gulpjs

在前面的文章中已经介绍过如何使用gulpjs了，这次其实就是将Browserify加入gulpjs的workflow。

废话不多说了，直接看代码：

```
// Task begin
gulp.task('browserify', function () {

  var browserifyThis = function (bundleConfig) {

    // 配置browserify
    var bundler = browserify({
      cache: {},
      packageCache: {},
      fullPaths: true,
      entries: bundleConfig.entries,
      extensions: config.extensions,
      debug: config.debug
    });

    var bundle = function () {

      return bundler
        .bundle()
        .on('error', function (err) {
          console.log(err);
        }).pipe(source(bundleConfig.outputName))
          .pipe(gulp.dest(bundleConfig.dest))
          .on('end', function () {
            console.log('Build Success!');
          });
    };

    // 使用Watchify
    bundler = watchify(bundler);
    bundler.on('update', bundle);

    return bundle();
  };

  config.bundleConfigs.forEach(browserifyThis);

});
```

上述代码的主要实现的就是遍历配置文件中所定义的文件目录，然后将其browserify，同时对其进行watchify。watchify是Browserify的作者Substack编写的一个配合Browserify使用的工具，功能相当与gulp中的`gulp.watch()`。

在定义好task之后就可以将其加入自己的gulp workflow了。

## 参考文章、资料

1. Guyiling - [使用 AMD、CommonJS 及 ES Harmony 编写模块化的JavaScript](http://justineo.github.io/singles/writing-modular-js/)
2. Lifesinger - [前端模块化开发的价值](https://github.com/seajs/seajs/issues/547)
3. Lifesinger - [前端模块化开发那点历史](https://github.com/seajs/seajs/issues/588)
4. FIS - [前端工程之模块化](http://fex.baidu.com/blog/2014/03/fis-module/)
5. CommonJS - [Wiki](http://wiki.commonjs.org/wiki/CommonJS)
6. Jack Franklin - [Dependency management with browserify](http://javascriptplayground.com/blog/2013/09/browserify/)
7. Dan Tello - [Gulp + Browserify: The Everthing Post](http://viget.com/extend/gulp-browserify-starter-faq)

---

文中若有不正确之处，欢迎各位客官指出斧正。谢谢阅读。
