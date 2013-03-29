---
layout: post
date: 2013-3-28 20:00
title: Prototype chain in JavaScript
comments: true
categories: JavaScript
---

Prototype chain, 也就是原型链.  
> In a purely prototypal pattern, we dispense with classes. We focus on the objects.

这句话是蝴蝶书中的，意在JavaScript中没有传统的类继承(诸如C++, Java等)，而是使用的原型模型. 所以说JavaScript是一门基于原型的语言.

原型继承比类继承模型要简单：一个新对象可以继承一个旧对象的属性.

还是用*代码*来说话吧(import from [stackoveflow](http://stackoverflow.com/questions/572897/how-does-javascript-prototype-work))：

    // 先来定义一个对象
    var Person = function (name) {
	    this.name = name;
	};
	//
	Person.prototype.getName = function () {
	    return this.name;
	};
	// 创建一个新的Person类型的对象
	var john = new Person("John");
	
	console.log(john.getName());
	# John
	
	// 更改Person的原型
	Person.prototype.sayMyName = function () {
	    console.log('Hello, my name is ' + this.getName());
	};
	// 同时也更改了john这个对象中的方法
	john.sayMyName();
    # John
 
接下来，创建一个新的对象
    
    var Customer = function (name) {
	  this.name = name;
	};
	// 将Customer的原型指向一个Person对象的实例
	Customer.prototype = new Person();
	
	var myCustomer = new Customer('Dream Inc.');
	myCustomer.sayMyName();
	
	// 为Customer对象添加新的方法
	Customer.prototype.setAmountDue = function (amountDue) {
	    this.amountDue = amountDue;
	};
	
	Customer.prototype.getAmountDue = function () {
	    return this.amountDue;
	};
	
	// 测试一下
	myCustomer.setAmountDue(2000);
	console.log(myCustomer.getAmountDue());
	
	// Error
	john.setAmountDue(1000);
	
    
