---
layout: post
title: UIKit之自定义UITabBar
keywords: UITabBar, UITabBarItem, iOS, Xcode
description: Customize UITabBar and UITabBarItem via codes in iOS7
date: 2014-09-22 22:00
comments: true
category: iOS
---

几天前，我又开始了学习iOS开发的历程。（之前用Objective-C开发过一个简单的App，可以在此阅读与之相关的文章：[开发Musiculator](http://blog.fantasy.codes/objective-c/2014/01/19/ios-dev-markdown/)

这次我准备开发一个微博的客户端，基于TabBar。因此需要自定义UITabBar以及UITabBarItem。

使用过storyboard的同学一定觉得，对于开发者而言可以在storyboard中很容易地自定义TabBar和TabBarItem。但是我在Xcode5中尝试了之后却失败了（具体过程就不赘述了，可以简单的通过新建一个基于TabBar的应用尝试一下），这着实让我觉得很奇怪。

## UITabBar

在探索了一番StackOverFlow之后，发现没有办法根据自己的需要自定义UITabBar的高度 -- 因为它是一个常量。

不过对于其他的诸如背景色、字体颜色等内容还是可以在`AppDelegate.m`中非常容易处理的：

- 更改背景色:

```
[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
```

- 更改字体颜色：

```
[[UITabBar appearance] setTintColor:[UIColor whiteColor]];
```

## UITabBarItem

在自定义UITabBarItem的图片的时候，着实迷惑了一把。

StackOverFlow上很多的教程和回答给出的方案或是大同小异，或是大相径庭，不幸的是在我所找到的教程和回答中无一能够真正解决问题。

在参考了Apple的API文档以及在模拟器上尝试过之后，终于找到了正确的自定义他们的方法（其中曲折就不细谈了）：

1. 新建一个基于`TabBarViewController`的子类
2. 在Storyboard中设置自定义的类
3. 给UITabBarItem设置图片：

```
// 获取指定的 UITabBarItem
UITabBarItem *itemOne = [tabBar.items objectAtIndex:0];
UIImage *itemOneImage = [UIImage imageNamed:@"image.png"];
itemOneImage = [itemOneImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
itemOne.selectedImage = itemOneImage;
[itemOne setImage:itemOneImage];
```

如果只是阅读这篇博文无法解决你的问题的话，可以参考我放在GitHub上的Demo中的代码：: [TabBarSample](https://github.com/teenworks/iOS-samples/tree/master/TabBarSample/TabBarSample).

-------

更多的API以及细节可以查阅Apple developer center: [UITabBar](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBar_Class/index.html#//apple_ref/doc/uid/TP40007521), [UITabBarItem](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBarItem_Class/index.html#//apple_ref/doc/uid/TP40006928).

--EOF--
