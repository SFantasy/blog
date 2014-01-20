---
layout: post
date: 2014-01-19 14:00
title: Musiculator
category: Objective-C
comments: true
---

上周初步研究了一下如何开发iOS应用。然后想到了当时@zc在学校里做的一个HTML 5的小应用 -- Musiculator -- Music + Calculator. 

本文简单的介绍一下上周做应用的几个步骤以及一些想法，当然也为那些像我一样想尝尝鲜的小菜鸟在不知从而下手的时候来上那么一缕春风~

## UI

新建完iOS的项目之后会发现项目中有一个`Main.storyboard`的文件，这也是这次我用来画UI的工具，细心的观众朋友一定能在Xcode的界面中找到一个控件的区域，于是我们就可以拖拖控件完成一个比较简单的界面啦。

这是我画完后的界面：

<img style="width: 50%;" src="http://fantasyshao-blog.qiniudn.com/musiculator-2.png">

说实话我挺喜欢这个界面的（哈哈），但是理智告诉我要给按钮添加一道边框。无奈的是在storyboard中怎么也找不到如何修改控件的样式，于是我就开始各种Google了（o(╯□╰)o）

键入`option`+`command`+`enter`，可以直接在storyboard右侧调出`ViewController`。其实接下来要说的是一种比较费劲且无脑的方法，在`storyboard`中选中控件，按住`control`直接拖到右侧的`ViewController.h`中 -- 创建一个控件与代码之间的「连接」。

选择新建`Outlet`型的`Connection`之后，就会生成这样的代码（zeroBtn是自己取的ID）：

```
@property (weak, nonatomic) IBOutlet UIButton *zeroBtn;
```

然后再次拖动同一控件到这个声明语句下，就选择`Action`型的`Connection`：

```
- (IBAction)typeZero:(id)sender;
```

这样就可以为控件绑定事件之类的了。对于上述过程，只能说对其原理还不了解（有待学习）。

对了，其实上述界面拖动之后的界面并不是我所期望的界面 -- 还希望为我的按钮们添加边框及颜色。

打开`ViewController.m`后，可以找到其中有一个`viewDidLoad`的函数，也就是view加载时执行的函数，所以我选择在此处更改控件的样式。

帖一点相关的代码：

```
// 设置边框圆角
_zeroBtn.layer.cornerRadius  = _zeroBtn.bounds.size.width / 2.0;
// 设置边框颜色
_zeroBtn.layer.borderColor  = textColor.CGColor;
// 设置边框宽度
_zeroBtn.layer.borderWidth  = 1.0;
```

一顿折腾之后，终于能达到我所期望的一个UI了：

<img src="http://fantasyshao-blog.qiniudn.com/musiculator-1.png" style="width: 50%">

## 计算功能



## 添加音乐



--EOF--