---
layout: post
date: 2016-08-19 00:00:00
title: 初探 Node.js 应用 Docker 化
keywords: storage, localstorage, cookies, IndexedDB
description: using different storages in modern browsers
comments: true
category: Node.js
---

Docker 是当下最流行的容器技术，最近稍稍研究了下如何使用 Docker 来创建一个 Node.js 项目的镜像。

> 此文抛砖引玉，大家可以来讨论一下关于 Docker 的一些知识与应用 :doge:

## 创建一个简单的 Node.js 应用

```js
const express = require('express')
const app = express()
const PORT = 4000

app.get('/', (req, res) => {
  res.send('docker demo')
})

app.listen(PORT, () => {
  console.log('Server started on port %s', PORT)
})
```

## 创建 Dockerfile

Dockerfile 有点类似 Docker 镜像的配置文件

```
FROM node:argon

# 应用在容器中的路径
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# 安装项目依赖
COPY package.json /usr/src/app
RUN npm install

# 将项目挪到之前配置的路径中
COPY . /usr/src/app

# Docker 中应用运行的端口
EXPOSE 4000

# 启动项目
CMD ["npm", "start"]
```

## 构建镜像

```
docker built -t shaochunhua/node-docker-demo
```

构建的过程会先拉取 Dockerfile 中配置的镜像 `node:argon`，但是 Docker 官方的镜像速度会非常慢，所以可以在启动 Docker 的时候使用阿里云的镜像地址：

```
sudo docker --registry-mirror=https://q4spmgrj.mirror.aliyuncs.com -d
```

## 使用构建的镜像

```
docker run -p 4000:4000 -d shaochunhua/node-docker-demo
```

其中可以映射实际上机器访问的地址与 Docker 中的地址，启动之后就可以在 `http://localhost:4000` 访问了。

## 其他

Docker 的安装都可以参照官方的文档，例如 CentOS: [installation](https://docs.docker.com/engine/installation/linux/centos/)

macOS 可以直接安装官方的 App，非常方便。

对于 Docker 进程的管理可以完全通过命令行进行操作，例如 `docker ps` , `docker restart` 等。
