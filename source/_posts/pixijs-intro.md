---
title: PixiJS
date: 2019-04-28 21:14:29
tags:
- 互动技术
categories: [前端]
---

PixiJS 是一个 2D 渲染引擎，用于创建丰富的交互式图形、跨平台应用程序和游戏。

<!-- more -->
#### 简介
PixiJS 会优先采用 WebGL API 来进行渲染，当浏览器不支持 WebGL 时会使用 canvas API 来渲染。

PixiJS 封装了 WebGL API，能够让我们在不了解底层 WebGL 知识的情况下享受 WebGL 带来的硬件加速渲染效果，所以 PixiJS 渲染性能是很高的。

#### 使用 PixiJS 的基本步骤
使用 PixiJS 创建动效一般来说有一下三步：

1）创建应用并挂载到页面
```
const app = new PIXI.Application({
    width: window.innerWidth,
    height: window.innerHeight
});
// app.view 实际上是一个 canvas 元素的引用
document.body.appendChild(app.view);
```
2）添加素材并渲染到页面
```
// 加载图片素材
const texture = PIXI.Texture.from('img/bunny.png');
const sprite = new PIXI.Sprite(texture);
// 设置图片素材的位置
sprite.anchor.set(0.5, 0.5);
sprite.position.set(app.screen.width * 0.5, app.screen.height * 0.5);
// 添加到页面上
app.stage.addChild(sprite);
```
3）添加动效
```
// app.ticker 类似于 setInterval，会定时执行
app.ticker.add(() => {
    sprite.rotation += 0.1;
});
```
#### PixiJS 应用的结构

![pixijs-application-structure][3]

一个应用 (application) 下只有一个根容器（container)，根容器下面可以包含其他容器（container)、图片 (sprite) 和文本 (text) 以及其他素材。

#### PixiJS 中类的继承关系

![pixijs-class-inherent][4]

参考
[PixiJS doc][1]
[PixiJS Examples][2]

[1]: http://pixijs.download/release/docs/index.html
[2]: https://pixijs.io/examples/#/demos-basic/container.js
[3]: https://ws1.sinaimg.cn/large/e250b5bdgy1g2lkne9ovej20m80eht9g.jpg
[4]: https://ws1.sinaimg.cn/large/e250b5bdgy1g2lkgqq9cij22ju0uqaeb.jpg