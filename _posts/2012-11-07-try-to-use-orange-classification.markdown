---
layout: post
title: "Try to use ORANGE: Classification"
date: 2012-11-07 11:18
comments: true
categories: [Python,Data Mining]
---

### 环境
***
Kubuntu 12.04/Python 2.7.3/Orange 2.0b  


### 准备工作
***
	#1.下载Orange的源码和Numpy的源码
	#2.编译Numpy
	#3.安装Python开发包
	sudo apt-get install python-dev
	#4.安装Python networkx包
	sudo apt-get install python-networkx
	#5.编译Orange
	python install.py build

### 测试
***
	import orange
	#导入orange
	orange.version
	'2.0b (21:58:41, Nov 3 2012)'

### Classification
***
从[UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/)下载一个测试数据集；比如Voting.tab  
#### Naive Bayes classifier
	import orange
	data = orange.ExampleTable("voting")
	classifier = orange.BayesLearner(data)
	for i in range(5):
		c = classifier(data[i])
		print("original",data[i].getclass(),"classified as ",c)
输出结果

	original republican classified as  republican
	original republican classified as  republican
	original democrat classified as  republican
	original democrat classified as  democrat
	original democrat classified as  democrat
	
可以看出，Naive Bayes在第三个实例处出现了错误，但是其他的都是正确的。  

	import orange
	data = orange.ExampleTable("voting")
	classifier = orange.BayesLearner(data)
	corrcetNum = 0
	#计数器
	for i in data:
	    a = i.getclass()
	    b = classifier(i)
	    if a == b:
	        corrcetNum += 1
	    
	print "CA:%.3f" %(float(corrcetNum)/len(data))
	#计算分类正确率
	#输出结果
	Possible classes: <republican, democrat>
	CA:0.9034
	
可见，Naive Bayes在数据量比较大的时候分类的正确率还是比较高的。
#### 参考资料
***

* Orange reference : [http://orange.biolab.si/doc/reference/](http://orange.biolab.si/doc/reference/)
* Orange tutorial : [http://orange.biolab.si/doc/tutorial/](http://orange.biolab.si/doc/tutorial/)
