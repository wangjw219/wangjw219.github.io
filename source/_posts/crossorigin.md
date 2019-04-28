---
title: 跨域
date: 2017-11-01 08:20:47
tags:
- 网络请求
categories: [前端]
---
跨域是前端开发中常见的需求，本文简要介绍跨域的原因及几种常见的跨域方案。
<!-- more -->
### 一、同源策略
**同源**指的是两个页面有相同的协议头、端口号和域名，比如`http://www.baidu.com/index.html`和`htt://www.baidu.com/test.html`这两个页面就是同源的，而`http://www.baidu.com`与`https://www.baidu.com`是不同源的。

**同源策略**限制从一个源加载的文档或脚本与来自另一个源的资源进行交互。这是一个用于隔离潜在恶意文件的关键的安全机制。

> 浏览器都有一个同源策略，其限制之一就是不能通过ajax的方法去请求不同源中的文档。 它的第二个限制是浏览器中不同域的框架 iframe 之间是不能进行 js 交互操作的。不同的框架之间是可以获取window对象的，但却无法获取相应的属性和方法。

**跨域请求**是指一个资源从与该资源本身所在的服务器不同的源请求一个资源时发起的HTTP请求。

出于安全考虑，浏览器会限制从脚本内发起的跨域`HTTP`请求。例如，`XMLHttqRequest`和`Fetch`遵循同源策略。浏览器限制发起跨域请求或者跨域请求可以正常发起，但是返回结果被浏览器拦截了。

### 二、跨域策略
日常开发中，经常需要用到跨域实现数据共享，所以掌握跨域的技术是很重要的。

#### CORS
CORS（跨域资源共享）机制允许 Web 应用服务器进行跨域访问控制，从而使跨域数据传输得以安全进行。

> 整个 CORS 通信过程，都是浏览器自动完成，不需要用户参与。对于开发者来说，CORS 通信与同源的 AJAX 通信没有差别，代码完全一样。浏览器一旦发现 AJAX 请求跨源，就会自动添加一些附加的头信息，有时还会多出一次附加的请求，但用户不会有感觉。
因此，实现 CORS 通信的关键是服务器。只要服务器实现了 CORS 接口，就可以跨源通信。

**原理**
CORS 新增了一组 HTTP 首部字段，允许服务器声明哪些源站有权限访问哪些资源。另外，规范要求非简单请求必须先通过 Options 方法发起预请求。

新增字段：
```
// 请求首部字段
Origin: <origin>
Access-Control-Request-Method: <method>
Access-Control-Request-Headers: <field-name>[, <field-name>]*

// 响应首部字段
Access-Control-Allow-Origin: <origin> | *
Access-Control-Expose-Headers: X-My-Custom-Header, X-Another-Custom-Header
Access-Control-Max-Age: <delta-seconds>
Access-Control-Allow-Credentials: true
Access-Control-Allow-Methods: <method>[, <method>]*
Access-Control-Allow-Headers: <field-name>[, <field-name>]*
```
**场景**
CORS 允许在下列场景中使用跨域 HTTP 请求：
1）由 XMLHttpRequest 或 Fetch 发起的跨域 HTTP 请求
2）Web 字体 (CSS 中通过 @font-face 使用跨域字体资源）
3）WebGL 贴图
4）使用 canvas.drawImage 方法将 Images/video 画面绘制到 canvas
5）样式表（使用 CSSOM）
6）Scripts (未处理的异常)

**优缺点**
优点：CORS 支持所有类型的 HTTP 请求，且可以使用 ajax 方式获取数据。
缺点：并不安全，但可利用 OAuth2 措施加强保障。

#### **postMessage**
window.postMessage() 方法可以安全地实现跨源通信。

**原理**
window.postMessage() 方法被调用时，会在所有页面脚本执行完毕之后（例如, 在该方法之后设置的事件、之前设置的 timeout 事件等）向目标窗口派发一个`MessageEvent` 消息。
```
//向其他页面发送消息
window.postMessage(message, targetOrigin, [transfer]);

// 其他页面监听 message 事件
window.addEventListener("message", (e) => {
  let origin = event.origin || event.originalEvent.origin;
  // 安全性验证
  if (origin !== "http://example.org:8080")
    return;
  }
  console.log(e);
}, false);
```
**安全性问题**
始终使用 origin 和 source 属性验证发件人的身份。

#### **JSONP**
JSONP（JSON with Padding）也是常用的一种跨域方式。

**原理**
HTML 的 script 标签可以加载并执行其他域的 JS 文件。（DOM 天生可以跨域）

JSONP 实际上就是回调函数和被包含在回调函数中的 JSON。JSONP 由两部分组成：回调函数和数据。
```
callback({"name": "wangjw"})
```
回调函数必须在浏览器执行 JSONP 响应时就要存在。

一个完整的 JSONP 请求如下：
```
// 本地脚本文件内容
function foo(response) {
  document.getElementById("output").innerHTML = response.bar;
};

var tag = document.createElement("script");
tag.src = 'somewhere_else.php?callback=foo';

document.getElementsByTagName("head")[0].appendChild(tag);

// 请求脚本文件内容
foo({bar: 'hello world'});
```
浏览器请求到脚本文件并执行的时候就调用 foo() 方法，并把 JSON 内容渲染到页面上。

**场景**
外链 JS 这种方案只支持 GET 方法，一般用于获取数据，不用来提交数据。

**优缺点**
优点：不受同源策略的限制；兼容性好。
缺点：只能用于 GET 请求。

#### **图像Ping**
图像Ping 的跨域方式与 JSONP 一样，利用的也是 DOM 元素天生跨域的特性。

**实现方式**
```
let img = new Image();

img.onload = img.onerror = function() {
  alert('done');
}

img.src = 'http://www.exmaple.com/test?name=wangjw'
```

**应用场景**
常用于跟踪用户点击页面（如百度统计的实现方式就是每次请求一个 gif 图片）或动态广告曝光次数。

**缺点**
只能发送 GET 请求。
无法获取服务器的响应文本，因此只能用于浏览器与服务器间的单向通信。

#### **CSST**
一种用 CSS 跨域传输文本的方案。

**原理**
通过读取 CSS3 content 属性获取传送内容。同样利用的是 DOM 元素（link 元素）天生跨域的特性。

步骤：通过 link 标签向服务器发送请求，服务器返回 CSS 文件，客户端通过获取特定元素的 content 属性来获取响应数据。

**优缺点**
优点：相比 JSONP 更为安全，不需要执行跨站脚本。
缺点：没有 JSONP 适配广，CSST 依赖支持 CSS3 的浏览器。

#### **window.name**
在一个窗口（window）的生命周期内，窗口载入的所有的页面（iframe) 都是共享一个 window.name 的，每个页面都对 window.name 有读写权限，所以可以通过这个属性来共享数据。
```
// iframe a
window.name.data = {
  a: 'hello'
}

// iframe b
document.getElmentById('box').innnerHTML = window.name.data.a;
```
#### **Hack技巧**
1）IE6/7 下不同 iframe 共享一个 navigator 对象，可以用于传递信息。

2）通过 hash 传递信息：同一个页面不同 iframe 是共享 location.hash 属性的，所以也可以通过这一属性进行通信。

### **跨子域策略**
若两个源主域相同，但子域不同，也是无法直接通信的。例如`http://h5.jd.com/a.html`和`http://m.jd.com/b.html`这两个页面就是子域不同。子域不同的两个页面，除了可以使用上面的跨域策略通信外，还有一些额外的方法可以使用。

#### **document.domain**
可以为两个子域不同的源设置相同的 document.domain 属性，这样就可以实现跨子域通信了（当然，只能把document.domain设置成自身或更高一级的父域）。比如有`http://h5.jd.com/a.html`和`http://m.jd.com/b.html`：
```
// iframe a
document.domain = 'jd.com';

// ifram b
document.domain = 'jd.com';
```

**场景**
document.domain 的场景只适用于不同子域的框架（iframe）间的交互，及主域必须相同的不同源。

**限制**
同域 document 提供的是页面间的互操作，需要载入 iframe 页面。

**参考**
[CSST][1]
[HTTP访问控制][2]
[浏览器的同源策略][3]


  [1]: https://github.com/zswang/csst
  [2]: https://developer.mozilla.org/zh-CN/docs/Web/HTTP/Access_control_CORS
  [3]: https://developer.mozilla.org/zh-CN/docs/Web/Security/Same-origin_policy