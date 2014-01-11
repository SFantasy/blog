---
layout: post
date: 2013-3-28 20:00
title: Prototype in JavaScript
comments: true
categories: JavaScript
---
  
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


其实以上例子就已经构建了一个*原型链*：
   
    myCustomer [Customer的实例]
	{ name: 'Dream Inc.' , amountDue: 2000 }
	
	    Customer.prototype [Person的实例]
		{ name: undefined,
		  setAmountDue: [Function],
		  getAmountDue: [Function] }
		  
	        Person.prototype 
			{ getName: [Function], sayMyName: [Function] }
			
这种继承的方式就是JavaScript中*原型链*的继承方式.

### 属性查找

在这种通过原型链继承的方式中，属性是只在读取的时候发生*属性继承*的，而在写入属性值的时候是不会发生的.  
也就是说，如果一个对象O从某个对象Q的原型继承而来，那么对象O中的属性P也是从Q中继承而来的，也就是所谓的属性继承，在O中设置了P的值，相当于在O中直接新建了一个P属性。  
而在后续程序中用到这个P属性的时候，发现P在O中已经定义，就不会通过原型链向上追溯了.

## 性能

要尽量避免原型链过长带来的性能问题，因为如果一个属性在原型链的上端就需要通过原型链不断向上查找，特别的，如果一个属性不存在，那么查找这个属性就会悲剧的遍历整个原型链.



  --EOF--
