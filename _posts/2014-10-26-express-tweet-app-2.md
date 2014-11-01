---
layout: post
date: 2014-10-30 22:22
title: Express4开发Web应用(2)
keywords: Express, Node, Web开发
description: 使用Express4和MongoDB开发一个简单的Web应用
comments: true
category: Node.js
---

此文接上篇。

---

上文中定义了一个最简单的名为User的Model:

```
var UserSchema = new Schema({
  name: { type: String },
  password: { type: String }
});
```

亦即每个User只有两个属性：`name`和`password`。

## 注册

要实现注册功能，其实无非是在数据库中创建一条User的记录。此次通过自上而下（从Web界面到数据库操作）的方式来介绍。

一般的登陆功能，或者说前后端的交互都是通过Web请求(GET or POST)来实现的（或者还有其他的方式？）。

请求的入口就在前端（这里使用的是[Jade](//jade-lang.com)），以form表单的形式：

```
form(action='/register', method='post')
    input(placeholder='name', name='name')
    input(placeholder='password', name='password', type='password')
    input(placeholder='password again', name='re_password', type='password')
    input(value='submit', type='submit')
```

在点击submit按钮之后，浏览器就会向服务器发送一个POST请求。接下来我们就需要编写Node服务端的代码来「捕获」这个请求。

上文中提到了我们将所有的路由代码都挪到了单独的`routes.js`文件中：

```
var site = require('./controllers/site');

module.exports = function (app) {
    app.get('/', site.index);
};
```

在这里我们要接受的是`/register`的POST请求：

```
app.post('/register', function (req, res, next) {
    // 逻辑
});
```

由于代码结构分离的原因，需要把这个请求的回调写到名为User的controller中（这个就不细讲了，具体可以参考[代码](https://github.com/SFantasy/Riki/blob/master/controllers/user.js#L28)）。

至此，我们的逻辑已经从Web前端到了controller中，马上就能看到曙光了。

在controller中，我们可以通过`req`参数来获取POST请求的参数：

```
var name = req.param('name');
var pass = req.param('password');
```

然后就可以交给service来对model进行操作了，以下为部分service中的代码：

```
User.newAndSave = function (name, password, callback) {
    // New User Model
    var user = new User();

    user.name = name;
    user.password = password;

    user.save(callback);
};
```

由于使用的Mongoose，因此就可以通过`new` JavaScript中对象的方式生成一条新的user数据，并通过`save`存储到MongoDB中。

至此，注册功能就已经实现了。

## 登录

在实现了注册之后，理所当然的要实现的是登录的功能。与注册一样，在提交登录请求时，例如`/login`，请求由controller获取，然后通过service的方法查找数据库中是否存在该登录用户。

若存在，则通过session存储登录用户的信息：

```
req.session.user = u;
```

随后根据需求进行重定向即可。而登出的功能也很简单，只要把存储的session删除就行了。

---

To be continued.
