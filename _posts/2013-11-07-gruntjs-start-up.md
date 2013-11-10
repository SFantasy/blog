---
layout: post
title: GruntJS初体验
categories: JavaScript
comments: true
date: 2013-11-07 20:15
---

最近开始做一个小项目，不过需要实现一些目标，能够使用自动化以下步骤：

* Sass和Coffee的compile
* JavaScript的压缩

原来实现这几个任务需要至少开两个terminal的tab：

* 一个开著编译Sass：

    `sass --style compressed --watch foo.sass:foo.css`

* 一个开著编译Coffee

    `coffee --compile --watch bar.coffee`

当然可以用`＆`让他们滚到后台去编译，不过这样不带感。

机缘巧合之下，找到了GruntJS这个「强大」的工具。

使用GruntJS可以做的事情还是很多的，其实我也只是简单地使用了一下这个工具，所以可以浅显地谈一谈。想必以后用到他的机会还多著。

## 简单的配置

Grunt的配置，其实就是在项目下建一个`Grutnfile.js`文件。

    module.exports = function(grunt) {
        grunt.initConfig({
            // 
        });
    };

如果我没理解错的话，这是典型的NodeJS的模块结构。而`grunt.initConfig({})`内则是需要配置的所需的GruntJS任务。

一个典型的GruntJS任务的配置，以`Sass`为例：

    sass: {
        dist: {
            options: {
                style: "compressed",
                noCache: true
            },
            files: {
                'css/foo.css': 'sass/foo.sass'
            }
        }
    }

当然，这个是必须要放在`grunt.initConfig({})`内的，之后还需要在config之外注册这个任务：

    module.exports = function(grunt) {
        grunt.initConfig({
            sass: {
                //...
            }
        });

        grunt.loadNpmTasks('grunt-contrib-sass');
    };

此时在Terminali里应该就可以运行这个任务了：

    grunt sass

其实可以配置一个默认的任务：

    grunt.registerTask("default", 'sass')

现在运行`grunt`就可以编译制定的Sass文件了。

事情进行到这里还是比较顺利的，大可以往里面添加多个任务，然后可以注册自己的任务或者直接将所有的任务都丢进`default`之中直，直接运行`grunt`即可。

我现在用到的只有三个：`Coffee`, `Sass`与`uglify`。所以你大可以按照自己的需求选择合适的任务，放到config之中。

REF:[GruntJS Plugins](http://gruntjs.com/plugins)

## Watch

`grunt-contrib-watch`算是我折腾了比较久的一个插件了。正如其名，他所做的事情就是可以实时检测文件的改动、增删，然后对特定的文件执行特定的任务。

其实我一开始选择的是叫做`grunt-watch`的插件，非官方，但是文档比官方的要清楚许多。在这里不得不吐槽一下`grunt-contrib-*`的插件们……至少感觉在我所见过的项目文档之中是比较让人难以看懂的了：混乱、没有清晰的目录、到处都有例子而不完整。

还是谈谈我遇到的问题。

遇到的第一个问题是，运行了`grunt watch`之后在terminal中出现了waiting...字样，但是过了一会就爆了一个「Bus error」。Google了之后找到了`grunt-contrib-watch`的issue list，发现这是一个Node的问题:[Bus error is OS X 10.9](https://github.com/gruntjs/grunt-contrib-watch/issues/204)。

好吧，`brew upgrade`搞定。

第二个问题就比较奇怪了：

在我执行了`grunt watch`之后出现了waiting...字样，但是在项目中改动了文件之后却没有任何反映，也就是说一直保持着waiting...囧。

折腾许久之后，昨天晚上提了个issue：[grunt watch not work](https://github.com/gruntjs/grunt-contrib-watch/issues/235)。到快睡觉的时候收到了一封邮件，也就是这个issue下的comment，于是决定今天早上开店脑试试:

`grunt watch --verbose`

不过我却没有看到一个错误……或者任何异常的日志信息。于是尝试了一下`grunt watch`，OK了，文件改动检测到了，task能跑起来了。真是奇怪。

其实让我有点失望的是，作者们并没有告诉我为何会出现这个问题（虽然相当奇葩），然后就把这个issue关了。

--EOF--
