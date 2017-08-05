---
layout: post
title: 小窥 React v16 
category: React
date: 2017-08-05 23:00
keywords: react
description: meet the future of React
comments: true
---

大约一周前，React 发布了第一个 16 版本的 beta 包，也就是说广大前端码农同学已经可以开始在自己的工程中使用新一个大版本的 React 了。截至现在，已经发布了三个 beta 版本，修复了一些已知的问题。

那么这个版本的 React 究竟给我们带来了什么呢？不妨跟着我来先睹为快。

现在可以立即马上通过 `npm i react@next react-dom@next` 来给你的项目安装 beta 版本的 React。

## 关于 React v16

值得注意的是，React v16 是一个对于 React 核心代码重写的版本，在此前透露的代号为 Fiber。

重写核心的目的在于：

1. 移除一些旧的内部的抽象，我的理解是减少了很多冗余的核心代码；
2. 发布一些众多开发者所期待的特性（这将会在下文中介绍一下）；
3. 开始实验组件的异步渲染，以便提供更好的用户体验。

不过 React 的开发团队也表示，异步组件渲染还没有在当前的 beta 版本中开放。

## 特性概览

- 首先要介绍的是多数 React 开发者都所亟需的一个特性：支持直接 render 数组。

举一个简单的例子，之前需要渲染一个元素的数组，我们需要在外面增加一个空的标签进行包裹：

```js
render() {
  return (
    <div>
      <p>paragraph one</p>
      <p>paragraph two</p>
    </div>
  )
}
```

而现在 React 在众多开发者的要求下，总算支持了直接 return 一个数组，可以减少很多无意义的嵌套：

```js
render() {
  return (
    [
      <p>paragraph one</p>,
      <p>paragraph two</p>
    ]
  )
}
```

### Error boundries

此前，React 组件出现异常的时候，会让整个应用崩溃，导致的结果就是页面白屏。

针对这种情况，React 在新版本中做出了不少努力。例如，对于出错的组件，React 会直接 unmount，减少对整体应用的影响。更令人值得高兴的一点是，React 提供了一种名为 Error boundries 的错误处理机制，可以通过简单的编码对错误进行比较优雅的处理。

举一个比较简单的例子来对这个特性进行了解。

例如，有这样一个程序：

```js
class Counter extends Component {
  state = {
    num: 0
  }

  render() {
    const { num } = this.state;
    
    if (num === 5) {
      throw new Error('buggy!');
    }

    return (
      <button
        onClick={() => {
          this.setState({
            num: num + 1
          })
        }}
      >
        {num}
      </button>
    );
  }
}

class App extends Component {
  render() {
    return <Counter />
  }
}
```

除非在 Counter 组件的 `render` 方法中对代码进行 `try-catch`，否则我们无法对异常进行捕获。而就真实的开发场景而言，没有办法对每个可能出错的场景都进行 `try-catch`，这也不现实。

而在 v16.x 的 React 之中，开发者获得了一种组件级别的 `try-catch` 能力，让我们来先看代码：

``` js
// 省略刚才的 Counter 代码

class ErrorBoudary extends Component {
  state = {
    error: null
  }

  componentDidCatch(error, info) {
    this.setState({
      error
    });
  }

  render() {
    const { error } = this.state;

    return (
      <p>{error && error.toString()}</p>
    );
  }
}

class App extends Component {
  render() {
    return (
      <ErrorBoundary>
        <Counter />
      </ErrorBoundary>
    );
  }
}
```

相信你已经明白是怎么一回事了：React 提供了一个 `componentDidCatch` 方法，允许开发者在组件中捕获 `children` 中出现的异常，而具体如何优雅的处理异常，则交给开发者来自己定义。可以相像的是，我们将会在日后的项目中，针对各种异常的情况定制一些 Error Boundary 组件，优雅的给用户以提示。

## 一些注意事项

- 这个版本的 React 依赖了 Map 与 Set 这两种集合类型，因此出于兼容性考虑，需要引入对应的 Polyfill，例如官方以使用 core-js 为例：

```js
import 'core-js/es6/map';
import 'core-js/es6/set';

import React from 'react';
import ReactDOM from 'react-dom';

ReactDOM.render(
  <h1>Hello, world!</h1>,
  document.getElementById('root')
);
```

- 虽然重写了 React 的核心代码，但是如果开发者已经移除了 v15 中所提示的废弃的 API，那么这个版本的 React 能很好的与你当前的代码和谐共处。
- 如果使用了第三方的 React 模块，那么这是一个不错的机会去催促作者将废弃的 API 移除，也是为了未来做准备。

## 参考

- [React 16 beta - facebook](https://github.com/facebook/react/issues/10294)
- [Error handling in React 16](https://facebook.github.io/react/blog/2017/07/26/error-handling-in-react-16.html)
