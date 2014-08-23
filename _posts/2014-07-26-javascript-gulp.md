---
layout: post
date: 2014-07-27 02:30
title: 更简单的JavaScript Task runner
category: node.js
keywords: NPM, NodeJS, GitHub, JavaScript, gulp, Task runner
description: 使用gulp.js实现前端自动化任务运行
comments: true
---

在去年的时候，曾经写过一篇博客介绍Grunt: [GruntJS初体验](http://blog.fantasy.codes/javascript/2013/11/07/gruntjs-start-up/)，以及当时使用的时候遇到的一些问题。

不过从那之后，就一直听说有一个更好用的Task runner -- [gulp](http://gulpjs.com)。尽管现在才使用有点落伍了，但是还是想分享一下使用gulp轻松而愉快的经历。

gulp和Grunt一样都是通过项目根目录下的「配置文件」来进行「任务」的定义的。

## 配置文件

在我使用Grunt的经历看来，Grunt的配置文件比较固定：

{% highlight js %}
module.exports = function(grunt) {
    grunt.initCofing({
        // config tasks
    });

    grunt.loadNpmTasks('some-task');

    grunt.registerTask('default', 'some-task');
}
{% endhighlight %}

相比而言，gulp的配置文件就像普通的Node文件一样：

```
var gulp = require('gulp');

gulp.task('default', function() {
    // config task
});
```

从配置文件来看，gulp就要比Grunt简洁很多：任务的配置、注册、插件的load几乎在一个函数中完成。

## 流与插件

由于Grunt发展的时间较gulp而言要长的多，因此其社区也相对更为壮大，这导致的结果就是Grunt现有的插件共有3188个，而gulp只有745个（截至2014年7月27日）。

当然，插件的数量并不能说明一切。毕竟实际上对于项目而言并不需要依赖那么多的插件，就像NPM中有如此多的包而最常用的总是那么几个。相信对于gulp而言，插件的数量超越Grunt也可能只是时间问题。

这里就不赘述在Grunt中使用插件的方式了，如果没有使用过Grunt可以参考Grunt的[官网](http://gruntjs.com/)中的示例。

需要提及的一点是，gulp自称是一个"The streaming build system"。直译过来也就是「一个流构建系统」。

以下这段摘自Substack的[stream-handbook](https://github.com/substack/stream-handbook):

> All the different types of stream use `.pipe()` to pair inputs with outputs.

而gulp中正是使用`.pipe()`来轻松使用插件配置一系列任务的。

举个例子，我在一个项目种使用了CoffeeScript来书写一些业务代码，然后需要gulp对CoffeeScript进行编译、压缩、合并，那么可见的就有三个任务。

而且可以想到的是这三个任务就是以「流」的方式来运作的，即前者的输出是后者的输入。

示例代码如下：

```
gulp.task('scripts', function() {
    gulp.src(paths.scripts)
        .pipe(coffee({bare: true}))
        .pipe(uglify())
        .pipe(concat('main.min.js'))
    .pipe(gulp.dest('dest/js'));
});
```

上述代码配置了一个任务"scripts"，然后通过`gulp.src()`来请求输入的文件，通过`.pipe()`将其「运送」到第一个工厂`coffee()`，处理完了之后搬运到`uglify()`对文件进行压缩，随后则是`concat()`来合并上一步的结果，最后通过`gulp.dest()`输出到指定目录。

这是我使用gulp感受到的最大的优点。使用`.pipe()`让整个处理任务的过程非常清晰，而不用像Grunt中那样繁琐的配置。

## 实践

昨天下午的时候做了一个小的工具：[Base64](https://github.com/SFantasy/Base64)。简单的来说，这是一个在线的对Base64进行加密和解密，实现从Base64字符串和JSON之间的相互转换的网站。

当然这个工具本身没有什么亮点，不过主要的目的是使用gulp来构建的这个项目，所以可以把它当成是一个使用gulp的实例吧。由于gulp本身就简洁、容易上手，所以这次实践的过程出乎意料的顺利。

我在项目中新建了两个目录：`/dest`和`/src`，分别是发布文件的目录和源文件的目录。本项目使用的是Sass和CoffeeScript来书写样式和业务逻辑。因此分别需要单独的目录来存放CoffeeScript和Sass的代码，而其对应生成的文件目录为JavaScript和CSS。

这需要我们的task runner以下几个功能：

1. 编译CoffeeScript和Sass
2. 合并压缩JavaScript文件
3. 实时监测文件改动并重复1、2的功能

在明确了目的之后，就可以放肆的在[gulp的插件库](http://gulpjs.com/plugins/)中寻找自己所需的插件了：

1. 编译CoffeeScript: [gulp-coffee](https://github.com/wearefractal/gulp-coffee)
2. 编译Sass: [gulp-ruby-sass](https://github.com/sindresorhus/gulp-ruby-sass)
3. 压缩JavaScript: [gulp-uglify](https://github.com/terinjokes/gulp-uglify)
4. 合并JavaScript: [gulp-concat](https://github.com/wearefractal/gulp-concat)

对应JavaScript和CSS，需要分别创建两个流水线进行操作。因此需要声明两个任务：

```
gulp.task('scripts', function() {
	// do some thing
});

gulp.task('sass', function() {
	// some thing about sass
});
```

gulp中整合任务也非常简单，只需要向另一个任务的声明中增加一个参数即可：

```
gulp.task('default', ['scripts', 'sass'], function() {});
```

### Watch

由于watch的是目录，而且对不同的目录所进行的处理任务是不同的，所以在这里我们就需要两个不同的watch事件来完成我们的需求：

```
gulp.watch('src/coffee/*.coffee', 'scripts');
gulp.watch('src/sass/*.sass', 'sass');
```
然后创建一个名为'watch'的task，存放这两个watch事件即可。

关于本次gulp的具体内容可以移步Base64项目的GitHub地址：[https://github.com/SFantasy/Base64/](https://github.com/SFantasy/Base64/)。

## 结语

相信现在Grunt依旧占有着多数Node/前端开发者，但是gulp无疑是Grunt之外另一个（个人感觉）更好的选择。更为简单、快捷，这是gulp的优势所在，而Grunt则坐拥3000+的插件 -- 社区生态更为完善。

当然，不论你选择了Grunt还是gulp，task runner并不能帮助你完成更多的任务，所以时间紧凑的话还是更推荐易于上手的gulp。

--EOF--
