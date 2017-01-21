---
layout: post
date: 2016-07-28 00:00:00
title: 可擴展的 Node.js Web 架構
keywords: node.js, node, javascript, architecture, pugna
description: developing an extensible Node.js web architecture based on Koa2
comments: true
category: Node.js
---

在工作中使用 Node.js 開發 Web 項目已經超過一年的時間了，也一直在思考如何將項目中很多的東西進行簡化。

## Node.js 項目的現狀

首先，可能需要介紹一下我所遇到過的項目的現狀 ﹣﹣ 當然這些方式可能已經比較落後。

現在的項目結構是基於 MVC，可能實際上有不少出入，不過大致的目錄結構是這樣的：

```
- public/
  - css/
  - js/
- models/
- controllers/
- views/
- routes/
- app.js
```

M-V-C 各司其職，項目結構在一定的團隊協作之下還是能夠很順利、清晰的運作的。

### 存在的問題

- 在項目變得龐大的時候，各個部分的文件夾、路徑會變得十分繁重
- 不同業務部分之間可能會存在很多通用的代碼，但是又不方便修改

### 解決之道



## 設計一個可擴展架構
