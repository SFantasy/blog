---
layout: post
date: 2015-10-07 20:00
title:  Weibo OAuth in React Native
keywords: Weibo, OAuth, ReactNative, React
description: Implement Weibo OAuth in ReactNative;在 ReactNative 中实现 Weibo OAuth
comments: true
category: React
---

> 本次的开发过程基于 React Native v0.11.0, Node.js v4.0.0 版本。

最近计划用 ReactNative 实现一个简单的微博客户端。

新浪微博为 iOS, Android 等 App 开发者提供了[相应的 SDK](http://open.weibo.com/wiki/SDK)，而对于 Node.js, Python 等 Web 开发平台也有很多第三方的开发者提供了很多开源的 SDK。

而这次我要实现的则是在 React Native 中实现 Weibo 的 OAuth 过程，获取用以调用 API 的 access_token。

在进行编码之前，需要先在微博的开放平台上[创建应用](http://open.weibo.com/development/mobile)。「授权回调页」的地址可以直接填写微博给定的默认页面：[https://api.weibo.com/oauth2/default.html](https://api.weibo.com/oauth2/default.html)。

对 OAuth2.0 的过程不了解的可以参阅一下：[授权机制说明](http://open.weibo.com/wiki/%E6%8E%88%E6%9D%83%E6%9C%BA%E5%88%B6%E8%AF%B4%E6%98%8E)

## 授权页

这一部分主要使用 WebView 的方式访问微博的授权页，页面地址可以在微博的开放平台上获取，然后按照要求填写里面的参数即可：

```
var OAUTH_URL = [
  'https://api.weibo.com/oauth2/authorize',
  '?client_id=' + config.app_key,
  '&response_type=code',
  '&redirect_uri=' + config.redirect_uri
].join('');
```

然后在进入 App 的时候就访问 WebView：

```
<WebView
  ref={'webview'}
  url={OAUTH_URL}
  automaticallyAdjustContentInsets={false}
  onNavigationStateChange={this.onNavigationStateChange.bind(this)}
  startInLoadingState={true}
  scalesPageToFit={true} />
```

这里面有不少参数，比较重要的就是里面的`url`和`onNavigationsStateChange`。前者即我们需要访问的授权页，后者是用来监听 URL 改变的方法，这在稍后会需要用到。

![](http://7b1ff1.com1.z0.glb.clouddn.com/oauth1.png)

## 获取 Code

OAuth2 的流程在此之后会跳转到填写的回调页：

![](http://7b1ff1.com1.z0.glb.clouddn.com/oauth2.png)

在回调页的 URL 中会添加一个参数名为`code`的值：`redirect_uri/?code=CODE`

因此我们可以通过上文中提到的`onNavigationsStateChange`方法获取：

```
var urlObj = url.parse(navState.url, true);

if (urlObj.pathname == url.parse(config.redirect_uri).pathname) {
  // 获取code
  var code = urlObj.query.code;
}
```

`url` 现在是 Node.js 核心库的一部分，用来解析 URL 路径等。在监听到WebView 中当前 URL 地址和填写的回调地址一致的时候，获取 URL 中的 "code"。

## 获取 access_token

获得了 code 之后就可以去交换 access_token (调用接口的凭证)了。

这一次我采用的是 React Native 中内置的 `fetch` 方法：

```
fetch(auth_url, {
  method: 'post'
}).then((response) => response.json())
  .then((responseData) => {
    this.setState({
      login: true,
      token: responseData.access_token
    });
  })
  .catch((err) => console.log(err))
  .done();
```

获取到 access_token 之后就可以进行 API 的调用了。当然要记得用一个 state 来标记登录的状态，进入 App 判断之后再进行 View 之间的切换。

--EOF--
