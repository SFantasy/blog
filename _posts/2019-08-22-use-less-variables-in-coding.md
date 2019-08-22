---
layout: post
title: Coding style - less variables
category: JavaScript
comments: true
date: 2019-08-22 00:30
keywords: javascript, coding
description: how to write javascript with less variables
---

Everyone has his own coding style, after being a programmer for years, I have my opinions on how to write clean and concise codes.

In this post, I'm going to talk about "how to code with less variables". It is really a small but important point of everybody's daily coding life.

As we know, "variables" exsit in JavaScript as a common circumstances, we have `var`, `let` and `const` to declare them (yet `const` is for "constant").

Let's take a piece of code as the first example:

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

We want to get a title via the parameter `type`, so lots of programmers would like to declare a variable with a default empty value (e.g. empty string `''` above).

Take 10 seconds to think how to optimize this example.

...

Emm, you must have a great idea to deal with it.

For me, I would transform like this:

```js
function getTitleViaType(type) {
  if (type === 'add') return 'Add page';
  if (type === 'edit') return 'Edit page';
  return '';
}
```

As you see, the function body reduced from 7 lines to 3 lines, and it became clean and clear obviously.

Is it the same idea with yours?

## Second example

```js
function objToArray(obj) {
  let arr = [];
  Object.keys(obj).forEach(id => {
    arr.push(obj[id]);
  });
  return arr;
}
```

This function is going to transform an `Object` into an `Array`. In the `forEach` loop, the array `arr` which is initialized as an empty array get its members.

However, the variable `arr` is quite redundant here and we can remove it for sure:

```js
function objToArray(obj) {
  return Object.keys(obj).map(id => {
    return obj[id];
  });
}
```

It is such an eazy solution to make your codes cleaner. And it is really neccessary for every to think one more step when working on your programs.
