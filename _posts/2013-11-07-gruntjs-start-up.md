---
layout: post
title: 始用GruntJS
categories: JavaScript
comments: true
date: 2013-11-07 20:15
---

最近開始做一個小項目，不過需要實現一些目標，能夠使用自動化以下步驟：

* Sass和Coffee的compile
* JavaScript的壓縮

原來實現這幾個任務需要至少開兩個terminal的tab：

* 一個開著編譯Sass：

    `sass --style compressed --watch foo.sass:foo.css`

* 一個開著編譯Coffee

    `coffee --compile --watch bar.coffee`

當然可以用`＆`讓他們滾到後臺去編譯，不過這樣不帶感。

機緣巧合之下，找到了GruntJS這個「強大」的工具。

使用GruntJS可以做的事情還是很多的，其實我也只是簡單地使用了一下這個工具，所以可以淺顯地談一談。想必以後用到他的機會還多著。

## 簡單的配置

Grunt的配置，其實就是在項目下建一個`Grutnfile.js`文件。

    module.exports = function(grunt) {
        grunt.initConfig({
            // 
        });
    };

如果我沒理解錯的話，這是典型的NodeJS的模塊結構。而`grunt.initConfig({})`內則是需要配置的所需的GruntJS任務。

一個典型的GruntJS任務的配置，以`Sass`為例：

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

當然，這個是必須要放在`grunt.initConfig({})`內的，之後還需要在config之外註冊這個任務：

    module.exports = function(grunt) {
        grunt.initConfig({
            sass: {
                //...
            }
        });

        grunt.loadNpmTasks('grunt-contrib-sass');
    };

此時在Terminali里應該就可以運行這個任務了：

    grunt sass

其實可以配置一個默認的任務：

    grunt.registerTask("default", 'sass')

現在運行`grunt`就可以編譯制定的Sass文件了。

事情進行到這裡還是比較順利的，大可以往裡面添加多個任務，然後可以註冊自己的任務或者直接將所有的任務都丟進`default`之中。


--EOF--
