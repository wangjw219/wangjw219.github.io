---
title: 移动端开发总结
date: 2017-09-10 19:54:34
tags:
- 移动端
categories: [前端]
---
入职以来就一直在做[妈网必修课][1]这个移动端语音及文字直播项目，到现在也有两个多月了，第一次做这种移动端项目，踩了不少坑，也收获了不少经验，现在总结一下。
<!-- more -->
### 滚动相关
**使用原生滚动方案**
类似 iscroll 等模拟滚动的库在移动端性能比较一般，特别是 ios 下有时卡顿很厉害，严重影响页面体验，所以尽量不要使用模拟滚动，而采用原生滚动。

**隐藏原生滚动条**
采用原生滚动时，页面如果很长，浏览器会渲染出一个很难看的滚动条，影响页面的整体感觉，可以采用以下两种办法隐藏该原生滚动条：

1）使用浏览器私有属性进行隐藏

```css
::-webkit-scrollbar {
  display: none;
}
```
该方法的限制很明显，只有 webkit 内核的浏览器（比如 chrome）支持该私有属性。

2）使用 hack 方法
在滚动元素上添加内边距和负的外边距
```css
.box {
  margin-right: -20px;
  padding-right: 20px;
}
```
### 输入框相关
**软键盘遮挡输入框**
在 ios 及部分 android 系统下，如果输入框处于靠近页面底部的位置，则当页面聚焦到输入框，弹出的软键盘会遮挡该输入框，解决办法如下：

1）从设计层面上，输入框的位置尽量不要放在页面底部

2）代码层面上的解决方案
```javascript
// 在输入框获取焦点时，开启一个定时器
// input 是输入框元素
let timer = setInterval(() => {
  input.scrollIntoView({ block: 'end', behavior: 'smooth'});
}, 500);

// 在输入框失去焦点时，移除定时器
clearInterval(timer);
```

**自增高的输入框**
`input`和`textarea`元素的高度都是固定的，当内容的高度超过其高度时，内容自会自动进行滚动，所以这两个元素的高度无法自动增高；而`div`等元素则会随内容自动增高，再加上`contentEditable`属性，就可以模拟出`input`元素展现的输入框。

<p data-height="265" data-theme-id="dark" data-slug-hash="brQLOW" data-default-tab="js,result" data-user="Sakura0219" data-embed-version="2" data-pen-title="自增高的输入框" class="codepen">See the Pen <a href="https://codepen.io/Sakura0219/pen/brQLOW/">自增高的输入框</a> by Sakurrrrra (<a href="https://codepen.io/Sakura0219">@Sakura0219</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

### 固定定位相关
**固定定位元素错位**
使用`position: fixed`属性的元素在移动端（特别是 ios 系统）下，容易出现以下问题：

1） 滑动页面时，元素会出现抖动。
2）软键盘弹出时，`position: fixed`属性会失效，元素会随着页面向上滚动。

目前的解决办法是：采用内滚动。如果页面需要部分地方滚动，部分地方位置固定，则可以只在需要滚动的地方使用`overflow: scroll`属性使其滚动，其他部分则正常流动或者采用绝对定位。

<p data-height="265" data-theme-id="dark" data-slug-hash="gxVjKB" data-default-tab="css,result" data-user="Sakura0219" data-embed-version="2" data-pen-title="内滚动" class="codepen">See the Pen <a href="https://codepen.io/Sakura0219/pen/gxVjKB/">内滚动</a> by Sakurrrrra (<a href="https://codepen.io/Sakura0219">@Sakura0219</a>) on <a href="https://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

**滚动穿透**
如果弹层使用`position: fixed`定位，在弹层是用手指进行滑动时，会导致弹层下的页面也跟着滚动，这就是"滚动穿透"。

解决办法：在弹层出现时，给`body`元素添加属性，使其无法进行滚动。
```css
.body--fixed {
  position: fixed;
  overflow: hidden;
  height: 100%;
}
```

[1]: http://van.mama.cn/live/wap/wkt


