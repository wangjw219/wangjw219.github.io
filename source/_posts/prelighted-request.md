---
title: 预检请求
date: 2019-06-27 21:23:58
tags:
- 网络
- HTTP
categories: [前端]
---
预检请求（Preflighted Requests）是跨域资源共享机制（CORS）中一种透明服务器验证机制。
<!--more -->
“需预检的请求”（也可称作非简单请求）必须首先使用 OPTIONS 方法发起一个预检请求到服务器，以获知服务器是否允许该实际请求。"预检请求“的使用，可以避免跨域请求对服务器的用户数据产生未预期的影响。

跨域资源共享中什么情况下需要发送预检请求？满足以下任意条件即可：

1）使用了以下任意 HTTP 方法：
```
PUT、DELETE、CONNECT、OPTIONS、TRACE、PATCH
```
2）认为设置了对 CORS 安全的首部字段集合之外的其他首部字段，该首部字段集合如下：
```
Accept
Aceept-Language
Content-Language
Content-Type
DPR
Downlink
Viewport-Width
Width
```
3）Content-Type 不属于以下之一：
```
text/plain
application/x-www-form-urlencoded
multipart/form-data
```
4）请求中的 XMLHttpRequestUpload 对象注册了任意多个事件监听器

5）请求中使用了 ReadableStream 对象