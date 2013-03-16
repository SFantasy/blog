---
layout: post
title: "Learn CSS Selectors"
comments: true
categories: Front-end-Dev
---

虽说自己蛮喜欢做前端开发的，但是说起来还是有很多知识都是“野生”的，这一说来感觉自己更像是一个“野生的程序员”……嘿，前方出现一个野生的程序员！  

玩笑开到这，还是进入正题，所谓“野生”的，也只是想调侃一下自己，毕竟都是自己看书浏览各种教程网站所得——也一直想系统的学习下这方面的知识，所以也就顺便撰文一篇markdown一下，从头开始！  

>In CSS, pattern matching rules determine which style rules apply to elements in the document tree. These patterns, called selectors, may range from simple element names to rich contextual patterns. If all conditions in the pattern are true for a certain element, the selector matches the element.

这是[W3C](http://www.w3.org/TR/CSS2/selector.html)上的一段话，有点像定义. 简单的翻译一下就是：  

>在CSS中，模式匹配规则决定了文档树中元素应该匹配的样式规则.这些模式，叫做选择器，(选择器的)范围从简单的元素名到复杂的上下文关系模式.如果所有的模式都(匹配)为对应的元素，那么这个选择器就匹配了这个对应的元素.

当然，我们可以很容易的在W3C官网上找到[所有的CSS选择器](http://www.w3.org/TR/selectors/#selectors)，从level1~3.

从CSS标准进化的角度来看下所有的selector:
(先截取一段本页面的html源代码，以之为示例)

    <header>
      <h1>Fantasy's Homepage</h1>
    </header>
    <nav class="mainNav">
      <span id="homeSpan"><a href="/">HOME</a></span>
      <span><a href="/categories.html"></a></span>
    </nav>
    <article>
      <section>
        <h2>Learn CSS Selectors</h2>
	    <div class="postContent">
	      <p>...</p>
	    </div>
      </section>
    </article>  
	
### CSS level1：

* 标签选择器`E`  

匹配所有使用该标签的元素:  

    h2 { ... }
	
* class选择器`.class`

匹配所有类元素中包含该指定class的元素：

    .mainNav { ... }
    nav.mainNav { .. }	

* id选择器`#id`

匹配所有id属性为该指定id的元素:

    #homeSpan { ... }
    span#homeSPan { ... }

* 后代元素选择器`E F`

匹配所有E元素的后代元素F：

    span a { ... }

* 链接伪类`E:link` `E:visited`

匹配所有(未)被点击的链接：

    a:link { ... }  
    a:visited { ... }
	
* 用户操作伪类`E:active` `E:hover` `E:focus` 

匹配一些用户操作的选择：

    /*按下链接，但未释放*/  
    a:active { ... }  
    /*鼠标移动到链接上*/  
    a:hover { ... }  
    /*元素获得焦点*/ 
    a:focus { ... }  
    /*这里的问题是如何判断链接获得焦点呢？所以更多的，:focus伪类用于input标签等*/
	
* first伪元素`E::first-line` `E::first-letter` 

匹配E元素下的第一行(字母)

    p::first-line {
      text-transform: uppercase;
    }  
    /*p元素下首行文字被transform为大写*/  
    p::first-letter {
    text-transform: uppercase;
    }  
    /*p元素下的第一个字母变为大写*/
	
	
### CSS level 2

* 通用元素选择器`*` （匹配所有元素）  
`* { ... }`
	
* 属性选择器`E[foo]` `E[foo="bar"]` `E[foo~="bar"]` `E[foo|="en"]`

根据不同选择条件进行匹配：

    a[href] { ... }  
    /*匹配带有href属性的a标签*/  
    a[href="/home.html"] { ... }  
    /*匹配href属性为"/home.html"的a标签*/ 
    a[rel~="copyright"] { ... }  
    /*若a元素下的rel属性为"copyright copyleft copymiddle"，这样就能匹配到该元素，而不用使用a[rel="copyright copyleft copymiddle"]*/
    a[hreflang|="en"] { ... }  
    /*匹配所有a标签下hreflang属性中带有连字符的并以"en"开始的元素*/  
	
* 结构化伪类`E:first-child` 

匹配所有E元素，条件是E元素为其父元素的第一个子元素

    p:first-child { ... }

* 语言伪类`E:lang(fr)`

匹配所有语言类型为'fr'的元素

    <body lang=fr>
      <p>Je suis français.</p>
    </body>

    /*如果匹配条件为[lang|=fr]，那么只会匹配到body元素;
	而如果是:lang(fr)那么会匹配到body和p元素，因为它们都是用法语的内容.*/
	
* `E::before` `E::after` 伪元素

在指定元素前生成指定内容

    /*在E元素前生成内容*/
	p::before { content:"note:" }
	

* 子元素选择器`E > F`

匹配所有E元素下的F元素

    nav > span { ... }
	
* 毗邻元素选择器`E + F` 

匹配紧跟着E元素的同级F元素

    header + nav { ... }
    

### CSS level 3

* 属性选择器`E[foo^="bar"]` `E[foo$="bar"]` `E[foo*="bar"]` 

根据不同条件进行匹配

    E[foo^="bar"]  
    /*E标签中foo属性的值以"bar"开始的元素*/   
    E[foo$="bar"]  
    /*与上面一个正好相反，E标签中foo属性的值以"bar"结尾的元素*/  
    E[foo*="bar"]  
    /*E标签中foo属性的值含有"bar"的元素*/  
	
* 结构化伪类`E:root` `E:nth-child(n)` `E:nth-last-child(n)` `E:nth-of-type(n)` `E:nth-last-of-type(n)`

具体解释如下

    E:root  
    /*文档的root元素，在HTML4中，永远是html标签(W3C这样说的，实际对于上HTML文件都是html)*/
    E:nth-child(n)  
    /*E的父亲元素的第n个子元素*/  
    E:nth-child(odd)  
    /*就可以表示E的父亲元素下奇数号的元素*/
    E:nth-last-child(n)  
    /*与E:nth-child相反，从E的父亲元素下最后一个子元素向前计数*/
    E:nth-of-type(n)  
    /*与E:nth-child(n)相似，但是只能匹配与E为同类(siblings)的元素标签*/
    E:nth-last-of-type(n)  
    /*与E:nth-of-type相反*/
	
* 结构化伪类`E:last-child` `E:first-of-type` `E:last-of-type` `E:only-child` `E:only-of-type` `E:empty`

具体解释如下

	E:last-child  
	/*等同于E:nth-last-child(1),匹配所有以E为最后元素的父元素下的子元素E*/
	ol > li:last-child  
	/*匹配ol中的最后一个li元素*/
	E:first-of-type  
	/*等同于E:nth-of-type(1)*/
	E:last-of-type  
	/*等同于E:nth-last-of-type(1)*/
	E:only-child  
	/*匹配一个有父亲元素但是该父亲元素没有其他子元素的元素*/
	E:only-of-type  
	/*匹配一个有父亲元素但是该父亲元素没有相同扩展元素名的子元素的元素*/
	E:empty  
	/*匹配一个不包含任何子元素的节点（包含文本节点）*/
	
* 目标伪类 `E:target` 
 
有些URI指向的是同一份资源中的一部分，也就是常见的带有#标记的链接

    html:target { ... }
	/*为html文档中所有target元素添加样式*/
   
* UI元素状态伪类 `E:enabled` `E:disabled` `E:checked` 

匹配所有状态为`enabled` `disabled`或者`checked`的元素，特地查看了下, enable/disable想必大家都了解，
所谓checked就是指一些`radio-button`或`checkbox`中的状态
	
* 否定伪类 `E:not(s)`

匹配所有符合否定条件的元素
  
    button:not([DISABLED])  
	/*匹配所有可以点击的按钮*/
	html:not(nav) { ... }  
	/*匹配所有除nav元素以外的元素*/
	
* 同级元素选择器 `E ~ F` 

匹配所有在E之后的并与E同级的元素F

     h2 ~ p { ... }

### 参考资料

* [w3.org](http://www.w3.org)
* [阮一峰的网络日志](http://www.ruanyifeng.com/blog/2009/03/css_selectors.html):这篇文章发布于2009年，
但是内容已经很详尽，不过感觉缺少稍微详细点的描述以及更为生动的例子.



>本文整理了很久，真的只有整理了，才知道自己的知识有多凌乱不堪。

--EOF--
