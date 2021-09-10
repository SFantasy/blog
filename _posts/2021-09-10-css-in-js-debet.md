---
layout: post
title: CSS-in-JS 技术解惑
category: CSS
comments: true
date: 2021-09-10 21:00
keywords: CSS, CSS-in-JS
description: 进一步了解 CSS-in-JS 技术
---

早在 2018 年的 7 月，我曾写过一篇《styled-components 的实践贴》

彼时，由于 CSS-in-JS 的方案有限，styled-components 作为当时此项技术的代表吸引了关注者们的眼球，也顺理成章的成为了我在公司内尝试这门技术的首选。

没想到过了 4 年，styled-components 仍然是 CSS-in-JS 技术领域的的领头羊之一：

https://npmcharts.com/compare/styled-components,@emotion/core,jss,emotion,tailwindcss?interval=30&log=true

经过 3 年的成长和进化 ，时下的 CSS-in-JS 技术，可谓进入了一个较为成熟的阶段。

先来简单回顾一下 CSS-in-JS 的特性，以免部分没有体验、使用过的同学一头雾水。

## Scoped CSS

<sup>Almost</sup> 所有的 CSS-in-JS 方案都会生成唯一的 CSS classname

![[Pasted image 20210708141257.png]]

当然，此特性当以 CSS Modules 为代表。

classname 的生成规则，对于每个框架而言都不一样，例如，Emotion 的 classname 是通过 `css-${hash}` 的规则生成的，而 styled-components 的生成规则则是：

```js
const className = hash(componentId + evaluatedStyles);
```

这一特性，对于从组件思维出发进行编程的开发者而言，无疑是一剂救世良方。

当然，你可能不喜欢这些随机生成的字符串，更倾向于 BEM 等偏向于通过「约定」的方式来处理 CSS 命名冲突，那么这就是另一个值得一谈的话题了。我们且不在此文中进行论述。

## Vendor autoprefixer

Vendor autoprefixer --「自动前缀补齐」 -- 这个特性对于习惯使用 Sass 或者 Less 等 Preprocessor 或者 PostCSS 等方案的开发者来说，恐怕再熟悉不过了。

可以说，Autoprefixer 已经是 CSS 编程领域的必备功能，毕竟没有人愿意去手写那一堆当下看来还需要去写的浏览器前缀。

而对于 CSS-in-JS 技术而言，这个特性的实现上刚好满足期望，这可以让我们在编程的时候，不再依赖任何的预处理或者后置处理工具。

## 样式的定义

示例：

```js
const Header = styled.h1`
  font-size: 20px;
  color: #333;
  line-height: 1.5;
  ${(props) => {}};
`;
```

我们可以跟平日里写 CSS 一样去写 CSS-in-JS 的代码，区别仅仅是将其用 JS 的模板字符串语法，将其包裹起来。

而在此之外，你可以用到任何的 JS 语法，例如：

```js
import theme from 'common/theme';

const Header = styled(Button)`
  font-size: ${theme.mainFontSize};
  color: ${theme.mainBlack};
  line-height: 1.5;

  .zent-btn {}
`;
```

话说……

谁记得 Sass 里的循环和函数是怎么写的？

……

当然，除了上述以 styled-components 为代表的 React 组件语法，众多 CSS-in-JS 方案都提供了另一种方式：

```js
const header = css({
	fontSize: '12px',
	color: '#333',
});

const Header = () => <div className={header}>WTF</div>;
```

这种方式，有点类似现在在 Scss 语法中使用 `:local(.header) {}` 。

像 Emotion 这样的方案，还开始支持了作为 props 的方式进行传入

```js
const Header = () => <div css={{ fontSize: '12px' }}>WTF</div>;
```

这种方式似乎和被我们唾弃的 `inline style` 是一样的，而实际上几乎当前还存活着的 CSS-in-JS 方案，都不会最终生成 `inline style`。

所以，上述不同的方式，只是在语法上看起来相似而已 -- 最终 Emotion 等方案，还是会将其生成唯一的 className，而在对于 CSS 样式的表达能力上，与上文提到的 `styled` 的方式几乎无异。

无论是 `styled`，`className` 还是 `css props` 的方式，CSS-in-JS 库的作者们希望能提供足够多的方式去满足开发者的编程癖好。

不过我觉得这三种主流方式的外在表现形式，其实都不是特别重要，可能对于真正的开发者在实操的时候，只是编码方式上存在部分区别 -- 毕竟条条大路通罗马。

对于我们来说，最重要的，**IT IS ALL JAVASCRIPT**

## 实现方式

CSS-in-JS 被人诟病最多的，可能就是其性能问题 -- 这与具体 CSS-in-JS 的实现方式息息相关。

一般来说，会有两种方式去实现：

① 动态插入 `<style>` 标签

此方案使用 [CSSOM](https://developer.mozilla.org/zh-CN/docs/Web/API/CSS_Object_Model) 的 CSSStyleSheet API 动态管理 CSS -- 可以通过 `insertRule` 或者 `deleteRule` 管理 CSS。

最终通过 1~N 个 `<style>` 标签插入到 HTML head 标签中。

② 编译时生成静态的 CSS 文件

这种方式与直接编写 CSS 相比，除了编码时使用 CSS / JS 的区别，在运行时来讲是几乎一致的。

两种实现方式各有优劣：

例如，动态插入的方式，需要引入运行时的 JS 库，而这部分运行时的代码则决定了之后性能。

静态编译则会需要将所有的样式编译到 CSS 中，这可能会增加不少额外的 CSS 文件内容。从而增大了整体程序的体积。

大多数的 CSS-in-JS 方案，都是通过第 ① 种方式实现的。

还是以 styled-components 为例，在去年发布了 v5 版本之后，官方的数据表示：

客户端样式更新的性能相比 v4 提升了 18%，bundle 体积减少了 19%。当我们回顾历史版本的 styled-components 时，会发现：

- v2 -> v3 性能提升了 10 倍
- v3 -> v4 提升了 25%
- v4 -> v5 提升了 19%

那么 v2 到 v5，性能提升了将近 15 倍 -- 而 v6 则已经在路上了。

在现代浏览器性能日益提升的 21 世纪 20 年代，以及各个类库开发人员对内部引擎代码的优化和改善，性能问题似乎不再成为我们技术选型的最大瓶颈。


-EOF-
