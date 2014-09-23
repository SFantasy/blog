---
layout: post
title: Customize UITabBar and UITabBarItem
keywords: UITabBar, UITabBarItem, iOS, Xcode
description: Customize UITabBar and UITabBarItem via codes in iOS7
date: 2014-09-22 22:00
comments: true
category: iOS
---

Days ago, I've started to learn iOS development again. You can reach my former post about developing Musiculator [here](http://blog.fantasy.codes/objective-c/2014/01/19/ios-dev-markdown/) (written in Chinese).

This time I'm trying to develop a Weibo (The Twitter clone in China) client.

As the app is designed as a TabBar based application, so I need to customize the UITabBar and UITabBarItem.

If you are familiar with the storyboard, it seems really easy for developers to customize the TabBar and TabBarItem in it. However, I've tried to do this in Xcode5 and failed. It's really strange.

## UITabBar

The height of UITabBar is a constant, so we are not able to change it to meet our need.

We could simply change the background color and the text color of UITabBar in the file AppDelegate.m:

- Change the background color:

```
[[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];
```

- Change the text color:

```
[[UITabBar appearance] setTintColor:[UIColor whiteColor]];
```

## UITabBarItem

It' really confusing to customize the image of the UITabBarItem.

Different tutorials or answers on StackOverflow would teach us set the image in different ways. (However, none of the really solve the issue)

After referring the API doc and trying on the simulator, I found the right way to customize them:

1. New a Objective-C file which is the sub-class of `TabBarViewController`
2. Set the customized class in the Storyboard.
3. Set images for UITabBarItem:

```
// Get the specified UITabBarItem
UITabBarItem *itemOne = [tabBar.items objectAtIndex:0];
UIImage *itemOneImage = [UIImage imageNamed:@"image.png"];
itemOneImage = [itemOneImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
itemOne.selectedImage = itemOneImage;
[itemOne setImage:itemOneImage];
```

If this does help to solve your problem, you can check my GitHub repository demo and have a look at it: [TabBarSample](https://github.com/teenworks/iOS-samples/tree/master/TabBarSample/TabBarSample).

-------

For more API and details, you can just check out the Apple developer center: [UITabBar](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBar_Class/index.html#//apple_ref/doc/uid/TP40007521), [UITabBarItem](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UITabBarItem_Class/index.html#//apple_ref/doc/uid/TP40006928).


--EOF--
