---
layout: post
date: 2014-12-10 23:00
title: 使用 sourcemap 调试 Sass 与 CoffeeScript
keywords: JavaScript, CoffeeScript, Sass, sourcemap, Chrome
description: Debugging Sass and CoffeeScript with sourcemaps using Chrome dev tools
comments: true
category: Front-end
---

最近在做一个小东西：[Toolbox](https://github.com/FantasyMedia/Toolbox)，目的是提供一个给开发者使用的「工具箱」。也正是在做这个东西的同时，研究了一下sourcemap相关的内容。

之前更新了电脑上的Sass版本后（大概是3.4版本）编译的的Sass文件会自动生成sourcemap的文件。当时说实话不知道这是干什么用的，就默默的搜索如何在编译时加上参数不生成sourcemap文件。但是之后还是回头去看了看sourcemap为何物、有何用、如何用，谨以此文分享一下。

## Source map 简介

Source map应该是最先应用于JavaScript的技术。（关于这一点并没有进行考究，但是从我搜索到的资料来看，应该是Google Closure最先提出的sourcemap调试技术）

由于很多框架、类库都相对比较庞大，所以在真正投入生产环境使用的时候都会用各种工具进行压缩、转换。

因此在浏览器中对使用这些「转换」过的代码进行调试都会感到十分迷惑：这种压缩过的代码要怎么调试？而sourcempa就是为了解决这个调试问题而诞生的。同样的，对于Sass这类CSS的预处理工具而言，Source map同样可以用来在浏览器内调试Sass代码。

下图为在Chrome中开启sourcemap调试选项：

![sourcemap](http://fantasyshao-blog.qiniudn.com/toggle-sourcemap.png)

有趣的是有一个名为[Sourcemap](http://www.sourcemap.com/)的网站，提供的是商品运送、物流线路的自动可视化服务。

## 调试Sass

如上文所提及的那样，现有的Sass版本是默认开启sourcemap选项的，因此在生成对应的CSS文件的同时会生成一个`.css.map`的文件。

例如有以下Sass文件：

```
.test
  color: black
  background-color: white
  .test-child
    color: red
```

通过Sass命令 `sass style.sass style.css` 编译后，就会生成以下style.css：

```
.test {
  color: black;
  background-color: white; }
  .test .test-child {
    color: red; }

    /*# sourceMappingURL=style.css.map */
```

其中最后一行就记录了该CSS文件的sourcemap文件的路径所在。

同时生成的style.css.map：

```
{
  "version": 3,
  "mappings": "AAAA,KAAK;EACH,KAAK,EAAE,KAAK;EACZ,gBAAgB,EAAE,KAAK;EACvB,iBAAW;IACT,KAAK,EAAE,GAAG",
  "sources": ["style.sass"],
  "names": [],
  "file": "style.css"
}
```

从上至下分别为：

- version: Sourcemap的版本，当前为3
- mappings: 记录位置信息的字符串，真正有用的部分
- sources: 对应的Sass文件
- names: 转换前后的变量名与属性名，此处为空
- file: 对应的CSS文件

关于mappings信息可以参考阮老师的文章中的解释，链接在参考资料一节中。

在开启了sourcemap后审查元素可以看到，在Dev tools中的地址即为Sass文件：

![sass-sourcemap](http://fantasyshao-blog.qiniudn.com/sass-sourcemap.png)

点击后就可以看到Sass的源码：

![sass-sourcemap-2](http://fantasyshao-blog.qiniudn.com/sass-sourcemap-2.png)

如果在开启CSS Source map的时候勾选了下方的"Auto-reload generated CSS"选项就可以在浏览器里修改上图中的Sass进行直接进行调试了

## 调试CoffeeScript

CoffeeScript默认生成的代码是不带sourcemap的，因此要在编译的时候传入相应的参数。比如使用命令行工具生成的时候需要传入`-m`或者`--map`参数。

平时在浏览器中打断点调试JavaScript都是在Dev Tools的source中找到js文件，然后开始调试。但是使用Coffee生成的JavaScript代码直接打断点是无效的，因为实际上我们的断点会打到对应的CoffeeScript代码中：

![coffee-sourcemap](http://fantasyshao-blog.qiniudn.com/coffee-sourcemap.png)

点击Breakpoints就会自动跳转到相应的CoffeeScript代码：

![coffee-sourcemap-2](http://fantasyshao-blog.qiniudn.com/coffee-sourcemap-2.png)

于是乎，就可以欢快的开始调试CoffeeScript了。

## 参考资料

- The Sass way - [Using sourcemaps with sass](http://thesassway.com/intermediate/using-source-maps-with-sass)
- 阮一峰 - [JavaScript Source map 详解](http://www.ruanyifeng.com/blog/2013/01/javascript_source_map.html)
- [Google Source map Revision3 Proposal](https://docs.google.com/document/d/1U1RGAehQwRypUTovF1KRlpiOFze0b-_2gc6fAH0KY0k/edit)
- [CoffeeScript Source Map](http://coffeescript.org/#source-maps)
