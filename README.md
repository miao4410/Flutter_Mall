# Mall

一个基于flutter2.5的商城 项目结构不是很复杂 适合新手小白 2021年3月份开始弄的 所以版本略低 之前一直放在了Gitee上 现在准备搬到GitHub上。

## Getting Started

UI原型图：https://www.figma.com/file/7KPVVTkHPQF0rZq9czIY8h/%E9%9D%9E%E5%90%8C%E4%BA%8C%E6%9C%9F_Block2.2.0?node-id=1273%3A12512

后端语言：java ，框架springboot （基本简单的增删改查 没意义做参考）。

后端接口文档：https://console-docs.apipost.cn/preview/20afd15b239de091/e7c99b3f94b847f8

此应用用到的插件 为pull_to_refresh（滑动加载）flutter_easyloading （页面加载插件）
![图片描述](https://github.com/miao4410/mall/blob/main/mall.gif)

gif较大(5MB) 刚开始加载偏卡顿 登陆页曾在YouTuBe上看到的（感觉很好看） 就借鉴拿了过来 UI原型图的登陆页也保留着。

因为从事后台Java开发所以文件名就大写了 后来才看到官网推荐小写。页面的文件名都以大写开头，封装的公共组件都以小写开头。

产品详情页（Product.dart）因底部弹框这个组件没有抽离出去 导致代码变多（后期会优化）
若采用的是最新的flutter3.0 启动后会报错 这是引用社区的插件没更新的缘故 不影响运行。Android模拟器启动可能会报Java版本不一样 本人用的是jdk8




