本地写作切换到 write 分支，部署采用 master 分支。

本地写作步骤：

1）git clone 到本地

2）安装依赖

```
// 安装 hexo 到全局
npm install hexo@3.9.0 -g

// 安装本地依赖
npm install
```

3）安装指定主题
在目录下新建 themes 文件夹，将对应主题 git clone 到目录下
```
git clone https://github.com/theme-next/hexo-theme-next themes/next
```

4）开启本地服务，开始写作并预览页面
```
hexo server
```

写作完成后部署：
```
hexo deploy -g
```