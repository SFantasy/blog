---
layout: post
title: Swift之简单的TableView
keywords: UITableView, iOS, iOS8, Xcode, Swift
description: 使用Swift在iOS8下编写简单的TableView
date: 2014-10-07 22:00
comments: true
category: iOS
---

最近在拿Swift练手做iOS的应用，也是第一次实现一个简单的TableView。

## Storyboard

在新建完项目之后，通过Storyboard添加一个TableView到默认的ViewController中，如图：

![](http://fantasyshao-blog.qiniudn.com/tableview-1.png)

## 关联元素与代码

在Storyboard中可以通过`⌥+⌘+Enter`呼出Storyboard中ViewController所对应的代码中的ViewController类：

![](http://fantasyshao-blog.qiniudn.com/tableview-2.png)

然后通过按住`ctrl`拖动Storyboard中元素的方式，将Storyboard中的元素关联到ViewController类中：

```
@IBOutlet var tableView: UITableView!
```

嗯，在这之后就可以开始编写我们的TableView的代码了。

## TableView

首先我们要定义一个静态的数组，用于在每一个cell中展示：

```
var dataArr: [String] = ["One", "Two", "Three", "Four"]
```

首先，我们需要在`viewDidLoade`方法中「注册」我们的TableView，相应的需要传入cell的标示符，这个标示符其实最好在ViewController类中以静态变量的形式定义:

```
let cellId: String = "cell"
```

不过现在为了方便起见，可以在函数中显示声明这个id：

```
self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
```

要实现TableView必须要实现TableView中的两个方法：`tableView(_:numberOfRowInSection:)`和`tableView(_:cellForRowAtIndexPath:)`，前者返回TableView的行数，后者设置TableView的元素（即cell）。

第一个方法我们只需要直接返回之前定义的`dataArr`的长度即可：

```
return self.dataArr.count
```

第二个方法需要设置cell，这时就需要展示`dataArr`中的内容了，不过还是需要先声明cell：

```
var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
```

然后可以将cell的label中的文字设置为dataArr中的内容：

```
cell.textLabel?.text = self.dataArr[indexPath.row] as String
```

嗯，我们的TableView到这里就已经做好了：

![](http://fantasyshao-blog.qiniudn.com/tableview-3.png)

具体代码可以参考GitHub: [TeenWokrs/iOS-Sample]( https://github.com/teenworks/iOS-samples/tree/master/TableViewSampleSwift)

--EOF--
