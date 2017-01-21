---
layout: post
date: 2016-09-28 23:00
title: 如何实现 @providesModule
keywords: fbjs, providesModule, Node.js, facebook
description: Facebook @providesModule 的原理分析与简单实现
category: Node.js
comments: true
---

在 Facebook 的 Github 代码仓库中，我们经常能看到这样的依赖声明方式：

```js
const DefaultDraftBlockRenderMap = require('DefaultDraftBlockRenderMap');
const DefaultDraftInlineStyle = require('DefaultDraftInlineStyle');
const DraftEditorCompositionHandler = require('DraftEditorCompositionHandler');
const DraftEditorContents = require('DraftEditorContents.react');
const DraftEditorDragHandler = require('DraftEditorDragHandler');
const DraftEditorEditHandler = require('DraftEditorEditHandler');
const DraftEditorPlaceholder = require('DraftEditorPlaceholder.react');
const EditorState = require('EditorState');
const React = require('React');
const ReactDOM = require('ReactDOM');
const Scroll = require('Scroll');
const Style = require('Style');
const UserAgent = require('UserAgent');
```

可以看到，对于项目内的文件依赖和 NPM 模块的依赖在声明的时候并没有任何区别 -- 这与我们平时需要写相对路径的方式不同。

我们知道，JavaScript 语言本身是不支持这种语法的，那么 Facebook 在项目中究竟使用了何种「黑魔法」呢？

带着疑问，我们来探索一下 Draft.js (v0.9.1) 这个项目 -- 当然你也可以将 React 或者其他 Facebook 的项目 clone 下来研究：

```sh
git clone git@github.com:facebook/draft-js.git
cd draft-js
npm i
```

## 声明

打开一个项目内的文件，我们可以看到如下代码：

```js
/**
 * Copyright (c) 2013-present, Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *
 * @providesModule DraftEditor.react
 * @typechecks
 * @flow
 */
```

注意文件注释的倒数第三行：`@providesModule DraftEditor.react`

> 另外两行与 [flow](https://github.com/facebook/flow) 相关，可以暂时忽略

没错，项目内的模块就是以这种注释的方式进行声明的。

## 原理分析

打开 `package.json` 文件，可以在 `scripts` 字段处看到以下部分：

```
{
  "prepublish": "npm run build",
  "build": "gulp"
}
```

可以看到 draft-js 项目在发布到 NPM 之前，是使用 gulp 进行打包的，因此接下来寻找一下项目中的 gulpfile.js：

draft-js 项目包含了多个 gulp tasks，我们只需要针对的寻找一下对模块依赖进行处理的 task:

```js
gulp.task('modules', function() {
  return gulp
    .src(paths.src)
    .pipe(babel(babelOptsJS))
    .pipe(flatten())
    .pipe(gulp.dest(paths.lib));
});
``

基本上可以确定 Facebook 是使用 babel 做这个处理的。

## 参考资料

- [facebook/draft-js](https://github.com/facebook/draft-js)
- [facebook/fbjs](https://github.com/facebook/fbjs)
