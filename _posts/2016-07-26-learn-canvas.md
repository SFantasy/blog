---
layout: post
date: 2016-07-26 21:00:00
title: 學習 Canvas 之二三事
keywords: canvas, javascript
description:
comments: true
category: Front-end
---

最近由於一些原因，要使用 Canvas 來繪製一些內容，也算是正好學習以下這門技術，順便在此分享一二。

下文中的示例代碼均不包含以下初始化的代碼 ﹣﹣ 獲取節點、創建 Canvas 的上下文：

```
var app = document.getElementById('app');
var ctx = app.getContext('2d');
```

## 繪製線條

線條其實是通過當前繪製的線路，然後填充使用指定的 `strokeStyle` 進行填充：

```
// 指定畫布中的起點
ctx.moveTo(0, 0);
ctx.lineTo(40, 40);
ctx.strokeStyle = '#ccc';
ctx.stroke();
```

這樣就可以繪製一條從坐標 (0, 0) 到 (40, 40) 顏色為 `#ccc` 的線條：

<a class="jsbin-embed" href="http://jsbin.com/xecawe/embed?js,output">JS Bin on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.38.10"></script>

當然，`strokeStyle` 還可以賦予不同於顏色的值：

```
ctx.strokeStyle = color;
ctx.strokeStyle = gradient;
ctx.strokeStyle = pattern;
```

## 使用圖片

值得注意的是，在 Canvas 中加入图片都需要在 Image 的 `onload` 方法中使用 `drawImage`  ，否则图片无法正常呈现。

```
// 創建新的 Image 對象
var img = new Image();
img.src = 'http://i.imgur.com/OZup9ew.jpg';

img.onload = e => {
  ctx.drawImage(img, 0, 0);
}
```

<a class="jsbin-embed" href="http://jsbin.com/gaxonow/embed?js,output">Canvas Load Image on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.38.10"></script>

`drawImage` 方法可以接受九個參數，用以控制圖片的大小、位置以及如何剪裁等，具體可以參考 [MDN](https://developer.mozilla.org/en-US/docs/Web/API/CanvasRenderingContext2D/drawImage)。

## 繪製文字

文字的繪製暫時還比較簡單，通過對 `ctx.font` 屬性的賦值可以修改之後 `fillText` 的大小與字體：

```
ctx.font = '20px Arial';
ctx.fillText('復仇者聯盟', 0, 0);
```

另外文字還有一種 `strokeText` 的方法，用於繪製鏤空的文字：

```
ctx.strokeText('鋼鐵俠', 0, 30);
```

<a class="jsbin-embed" href="http://jsbin.com/zusode/embed?js,output">Canvas Text Drawing on jsbin.com</a><script src="http://static.jsbin.com/js/embed.min.js?3.38.10"></script>

## Retina 屏下的 Canvas

在 Retina 屏幕的前提下，直接在 Canvas 上绘制会明显的感觉到内容的不清晰，这时候需要根据设备的 pixelRatio 进行缩放调整，以下这段代码来自 TJ，当然内容也比较简单：

```
var ratio = window.devicePixelRatio || 1;

if (1 !== ratio) {
  app.style.width = app.width + 'px';
  app.style.height = app.height + 'px';
  app.width *= ratio;
  app.height *= ratio;
  ctx.scale(ratio, ratio);
}
```

這樣處理之後，就可以保證使用 Canvas 繪製的內容在 Retina 屏幕下可以完美的展示。

## 輸出圖片

Canvas 轉換成圖片，可以直接使用原生的方法：

```
canvas.toDataURL()
```

這個方法可以接受兩個參數：

- type: 指定輸出圖片的格式，默認的格式為 `image/png`
- encoderOptions: 指定輸出的圖片質量，範圍在 0-1 之間，默認的為 0.92

值得注意的一點是，如果 Canvas 中使用了來自其他域的圖片，是無法使用 `toDataURL()` 進行輸出的 ﹣ 這個問題解決的辦法是需要使用的圖片為「允許跨域」的，因此可能需要通過服務器進行一次轉發，再獲取圖片的地址。

## 參考

- http://weblogs.asp.net/dwahlin/rendering-text-with-the-html5-canvas
