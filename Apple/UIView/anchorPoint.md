# anchorPoint

<!-- create time: 2014-11-10 20:17:53  -->
[参考一剑](http://maccrazy.diandian.com/post/2011-12-06/7526624)

>anchorPoint（锚点）简单来说是用来确定“动画效果“的

通过设置layer的anchorPoint，进而改变其frame

anchorPoint:Defines the anchor point of the layer’s bounds rectangle. Animatable. default (0.5, 0.5)

> layer.point所指定的点

     //设置锚点为底边中心
     btn.layer.anchorPoint = CGPointMake(0.5, 1.0);
     //设置frame的宽高 锚点只对view的frame无效
     btn.frame = CGRectMake(0, 0, btnW, btnH);
     btn.layer.position = CGPointMake(btnX, btnY);
     
     
简而言之，涉及图层操作，动画效果，anchorPoint都会对其有效，因此对view的transfrom操作，anchorPoint也会对其同样起效。
