---
layout: post
comments: true
title: 合并分支上的特定文件
date: 2013-04-08 21:08
categories: Git
---

**问题**

虽然说`merge`在Git的使用中还是很常见的一个操作，但是以前只用过`git merge branchname`这样的命令，今天遇到了一个情况，是这样的： 

在一个repository中，我需要在`master`分支里`merge`一个`gh-pages`分支中的文件，也就是说，使用合并另一个分支上的特定文件。

**解决办法**

[Stackoverflow](http://stackoverflow.com/questions/449541/how-do-you-merge-selective-files-with-git-merge)上提到了很多解决的办法，其中被采纳的答案中提到了两种，具体可以看前文给出的链接。不过我都没有尝试，因为accepted的answer并不是最好的，至少在这里是这样的。

    git checkout branchename path/to/file1 path/to/file2
	git commit -m "'Merge' code from 'branchname' branch"

简单、实用，这就是我要找的答案。

> 如果这是一趟旅行，誓要发现途中最美的景色。
