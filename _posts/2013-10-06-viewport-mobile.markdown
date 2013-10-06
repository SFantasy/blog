---
layout: post
title: 对viewport在实战中的一些研究
date: 2013-10-06 16:00
comments: true
categories: front-end-dev
---

之前的一篇[Blog](http://blog.fantasyshao.com/2013-09-coding-life/)中也提到过最近的工作是在做手机上的网站，那篇文章中也提到过一些工作中遇到的问题，不过其实最大的问题是这篇文章中要提到的 -- viewport.  

事实上一开始在接触这个属性的时候并没有想到会遇到如此多的问题，而无论是Google或者StackOverflow出来的答案都没有能够完全解决我的问题.说实话网上有很多博客都谈到过viewport，但是往往他们的文章……都好不负责任，谈及viewport，介绍一下有那些属性，有那些属性值，然后就over了.

其实实战起来真的没有那么简单，特别是对付现在那么多的Android设备，那么多的分辨率，那么多不同的浏览器（不同厂商还一定要搞一个「自主研发的」内核），不是单纯的一句话就搞定了的.

好吧，废话不多说，简单的来讲讲我是怎么面对这么多「敌人」来找出一个还算兼容的方案的.

## 缘起

由于我们的网站一开始是按照640px宽度来设计的，所以最初我们的viewport是这样的：


    <meta content="target-densitydpi=device-dpi, 
    	width=device-width, 
    	initial-scale=0.5,
    	user-scalable=no" name="viewport">


对页面进行缩放，为原来的0.5倍.

(BTW, 关于viewport属性的说明可以参照[MDN](https://developer.mozilla.org/en-US/docs/Mozilla/Mobile/Viewport_meta_tag). 关于viewport还可以参考一下[quirksmode.org](http://www.quirksmode.org/mobile/viewports.html)上的几篇文章.)

起初项目开发的时候，由于功能还没有完善，所以并没有花费很多时间去考虑这方面的问题，所以做完之后也仅仅是用iPhone的safari以及我自己的Sony LT26ii上的Chrome看看页面的效果.

于是，似乎一切都没有什么问题的继续进行着……

## 曲折

后来发现在使用Chrome调试的时候，发现[`target-densitydpi`被弃用了](http://stackoverflow.com/questions/11592015/support-for-target-densitydpi-is-removed-from-webkit).这也给后面的开发过程埋下了伏笔.

最初爆出问题的是480P分辨率的Android设备，网站会比设备屏幕的宽度要更宽，导致浏览的体验并不是很好。随后在像发现新大陆一样，找来各种分辨率的手机进行测试 -- 720P的Note2上页面会比设备小不少，1080P的Galaxy S4上页面就更小了……当然，最完美的就是iPhone4, 4S, 5了（据说viewport是Apple发明的……当然iPhone的单一化让开发者省心很多）.

于是我就觉得是因为屏幕的分辨率不同，以至于不能使用同一种缩放比 -- 0.5. 所以我觉得是时候用JavaScript动态调整缩放比了：

**HTML**

    <meta id="viewport" content="
        user-scalable=no, 
        width=device-width, 
        initial-scale=0.5" name="viewport" />

**JavaScript**

var viewPortScale;
    var dpr = window.devicePixelRatio;
    
if(dpr <= 2) {
    viewPortScale = 1 / window.devicePixelRatio;
} else {
    viewPortScale = 0.5
}

document.getElementById('viewport').setAttribute(
        'content', 
        'user-scalable=no, 
         width=device-width, 
        initial-scale=' + viewPortScale);

没错，在这里我完全扔掉了`target-densitydpi`，因为前文提到它被弃用了。

事实上这次使用动态改变viewport之后，已经能让note2等主流分辨率手机正常显示了（720P, 1080P）.

但是这时候我发现了国内用户量巨大的QQ浏览器表现和其他的浏览器有异 -- 缩放不正常. 其实当时也是调试了很久才给出了上文中那个「比较」兼容的方案，所以在Google无门，SO上又没有合适的答案解释（木有人研究过QQ浏览器么=_=）的情况下，我在平时逛的比较多的三个网站上扔出了自己的问题（[知乎](http://www.zhihu.com/question/21665607)，[SegmentFault](http://segmentfault.com/q/1010000000309418), [html-js](http://f2e.html-js.com/qa/41)）.

好吧，除了SF上有位同学赞了我的提问，有位同学给了一条几乎没有用的评论之外，没有其他一点点收获（其实当时挺无助的，:( ）.

后来我原来在的前端组老大派了一个经验丰富的女汉子来帮助我了……终于看到了点希望.

那几天算是比较系统的研究了一些viewport属性，也对于480P~1080P的手机以及现在市场占有率最高的几个浏览器进行了更为全面的测试，并且给出了一份比较「全面」的报告. 

最后我们的讨论的结果是对于480P和320P的设备调整CSS -- 也就是开始了用响应式的旅程. 

其实还是觉得挺不情愿的，因为毕竟感觉如果能在所有设备和所有浏览器上能够正常缩放的话，根本不需要做响应式. 当然做响应式也是挺不错的……毕竟之前没有怎么实践过（(^_^)）

话说其实花了2~3天的时间就改完了，毕竟需要用到响应式的其实并没有多少. 于是在320P和480P的设备上就已经可以正常显示了我们的网站了.

## 后来

其实使用响应式并不是这件事的终点. 在调试响应式的过程中，我依旧坚持着通过viewport来控制页面缩放的方法的研究.

事实证明，仍旧有些浏览器（如QQ、UC浏览器）是受`target-densitydpi`影响的. 

比如在UC中使用该属性，则其`DevicePixelRatio`就会改变(如原来是2，现显示为1)，而其他浏览器则不会.而关于UC还有一个比较奇怪的事情是，UC有很多自己定义的`meta`属性，对于viewport，UC更是有一个`uc-fitscreen`属性……过程就不赘述了，反正最后还是没有用到这个属性，因为用了之后反而更是一团糟.所以对于UC，就不能使用`target-densitydpi`.

另外，对于QQ浏览器而言，`target-densitydpi`也让人十分困惑 -- 正如在上文中提到的问题那样，缩放会不正常. 而如果没有使用到这个属性则能够正常显示网页. 所以就需要在JavaScript中增加对QQ浏览器的判断.

最后…终于给出了一个更为兼容的方案，实践证明已经在大多数主流浏览器和分辨率（480~1080P）设备上缩放正常了！

    var viewPortScale = 0.5;
    var dpr = window.devicePixelRatio;

    var detectBrowser = function(name) {
        if(navigator.userAgent.toLowerCase().indexOf(name) > -1) {
            return true;
        } else {
            return false;
        }
    };

    if(detectBrowser('ucbrowser') || 
    	dpr == 3  || 
       	detectBrowser('mqqbrowser')) {
           document.getElementById('viewport').setAttribute(
               'content', 
               'width=device-width, 
           	   minimum-scale=0.5, 
               initial-scale=' + viewPortScale);
           } else {
           		document.getElementById('viewport').setAttribute(
            	'content', 
            	'target-densitydpi=device-dpi, 
            	width=device-width, 
    	        minimum-scale=0.5, 
        	    initial-scale=' + viewPortScale);
           }

这里漏掉的一点是，对于1080P设备（dpr为3）使用`target-densitydpi`会让页面缩放的很小……具体原因不得而知，如果有了解原理的同学请你一定要联系我！



--EOF--







