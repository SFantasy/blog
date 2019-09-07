---
layout: post
title: 编码风格 - 更少的使用变量
category: JavaScript
comments: true
date: 2019-08-22 00:30
keywords: javascript, coding
description: how to write javascript with less variables
---

每一位程序员都有自己的编码风格，在从事编码多年之后，对于这个话题我也有了一些自己的看法和经验。

我们知道，在 JavaScript 中使用『变量』是一种很常见的场景。我们可以用 `var`, `let` 或者 `const` 声明，当然稍微严谨点的说， `const` 在字面上是用来声明『常量』的。

在接下来的内容中，我将会讨论的一个点是『如何在编码的时候使用更少的变量』-- 这是一个非常小的点，但是对于每个人平时的编程工作而言还是比较重要的。

## 不要在一开始就先给变量赋默认值

我们先来看一段代码：

```js
function getTitleViaType(type) {
  let title = '';
  if (type === 'add') {
    title = 'Add page';
  } else if (type === 'edit') {
    title = 'Edit page';
  }
  return title;
}
```

上述代码的目的很简单 -- 通过入参 `type` 来获取『标题』。

很多程序员在写代码的时候，习惯于在开始实现某个逻辑的时候先声明一个字面量为空值的「变量」，比如在上述例子中就是一个空字符串 `''`。

你可以花费 5秒钟的时间去思考下如何优化这个示例的代码。

...

嗯，我觉得你肯定已经有了非常棒的主意。于我而言，我会将代码修改成如下：

```js
function getTitleViaType(type) {
  if (type === 'add') return 'Add page';
  if (type === 'edit') return 'Edit page';
  return '';
}
```

正如你看到的那样，我们将函数体从 7 行缩减到了 3 行，更重要的是，这段代码相比之下显得更为简洁和清晰。

## 使用合适的 API 去避免使用变量

```js
function objToArray(obj) {
  let arr = [];
  Object.keys(obj).forEach(id => {
    arr.push(obj[id]);
  });
  return arr;
}
```

上述函数的目的是想要将一个 `Object` 转换成 `Array`：在每一次 `forEach` 的循环过程中，一开始初始化为空数组的 `arr` 会不断增加元素。

但实际上，变量 `arr` 在这个例子中是相对多余的，我们可以很干脆的将它从代码中移除：

```js
function objToArray(obj) {
  return Object.keys(obj).map(id => {
    return obj[id];
  });
}
```

没错，将这些代码修改的过程其实非常简单，而且只需要花费很少的时间。但实在是有太多的职业程序员没有在日常的工作中实践这些真理。

## 混合逻辑的场景

```js
function getGroupIndexArr(plainArr) {
  const rootArr = plainArr.filter(item => item.level === 0);

  const groupArr = [];
  let flag = 0;

  rootArr.forEach(element => {
    groupArr.push({
      key: flag,
      range: element.range
    });

    flag += element.range;
  });

  return groupArr;
}
```

上述代码的目的就是为了在循环生成新数组的过程中，通过额外的字段进行一个计数操作。因此，这边使用了 `groupArr` 和 `flag` 两个『变量』。

但实际上，我们完全可以避免额外的『变量』去实现这个遍历过程。至于具体如何修改，就不再此进行赘述。

## 其他一些示例

```js
let { duration } = this.props;
if (duration > 800) {
  duration = 800;
}
```

从入参或者其他地方（上述是从 React 组件的 `props` 中）获取，然后通过一些判断条件再进行重新赋值，也是一个比较常见的场景。

其实 ESLint 是有规则对入参的修改进行提示的，但仍然无法避免很多类似的编程习惯。

比如上述例子，很显然我们可以通过 `Math.min()` 来返回需要的值。

## 总结

本文简单探讨了下如何使用适当的手段，减少日常编程过程中一些使用『变量』的不太优雅的姿势。

值得注意的是，文章中的大部分『不太好』的代码片段都是我从同事们的日常工作中『扣』出来的。

当然，你可能觉得文中的示例都过于简单，但其实也有更为复杂的例子，不过在我看来其中的思想是一模一样的。比如在编写一个函数或者一段逻辑之前，就应该先思考下要使用哪些变量，使用什么方式去实现。这是关乎程序员职业素养的事情，而不是打开编辑器就先声明一个变量 -- 之后随机应变。

后续，我会挖掘一些更为有意思的关于『编码风格』的思考，希望对大家的日常工作有所帮助。
