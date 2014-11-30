# CALayer图层操作

<!-- create time: 2014-10-19 22:05:37  -->
    QuartzCore框架中
    为了保证可移植性，QuartzCore不能使用UIImage、UIColor，
    只能使用CGImageRef、CGColorRef
    QuartzCore框架和CoreGraphics框架是可以跨平台使用的，在iOS和Mac OS X上都能使用
    但是UIKit只能在iOS中使用
    
    UIView之所以能显示在屏幕上，完全是因为它内部的一个图层
    
    在创建UIView对象时，UIView内部会自动创建一个图层(即CALayer对象)，
    通过UIView的layer属性可以访问这个层(readonly,retain) CALayer *layer;
    
    当UIView需要显示到屏幕上时，会调用drawRect:方法进行绘图，
    并且会将所有内容绘制在自己的图层上，绘图完毕后，系统会将图层拷贝到屏幕上，
    于是就完成了UIView的显示
    
    换句话说，UIView本身不具备显示的功能，是它内部的层才有显示功能

<h3>CALayer的作用</h3>

    通过操控的图层对象可以很方便的调整UIView的一些外观属性：
    阴影，圆角，边框的宽度／颜色，为图层添加动画。
    
    
<h3>CALayer的一些属性</h3>

1. 宽度和高度  @property CGRect bounds;

2. 位置(默认指中点，具体由anchorPoint决定) @property CGPoint position;

    //用来设置CALayer在父层中的位置 ,以父层的左上角为原点(0, 0)

3. 锚点(x,y的范围都是0-1)，决定了position的含义 @property CGPoint anchorPoint;

    //决定图层那个点做为图层的position点。(anchorPoint默认为（0.5，0.5）即图层的中点为position点)
    //称为“定位点”、“锚点”

4. 背景颜色(CGColorRef类型) @property CGColorRef backgroundColor;

5. 形变属性 @property CATransform3D transform;
6. 边框颜色(CGColorRef类型) @property CGColorRef borderColor;

7. 边框宽度 @property CGFloat borderWidth;

8. 圆角半径 CGFloat cornerRadius;

9. 内容(比如设置为图片CGImageRef) @property(retain) id contents;

<h3>CALayer和UIview的区别</h3>

CALayer和UIview都能显示内容。
不同的是，UIView继承自UIResponder，具有事件处理的功能，而CALayer不具有。
因此向一些无需与用户交互的界面可以使用CALayer。


<h3>图层的隐式动画</h3>

    每一个UIView内部都默认关联着一个CALayer，我们可用称这个Layer为Root Layer（根层）

    所有的非Root Layer，也就是手动创建的CALayer对象，都存在着隐式动画


    当对非Root Layer的部分属性进行修改时，默认会自动产生一些动画效果
    而这些属性称为Animatable Properties(可动画属性)

    列举几个常见的Animatable Properties：
    bounds：用于设置CALayer的宽度和高度。修改这个属性会产生缩放动画
    backgroundColor：用于设置CALayer的背景色。修改这个属性会产生背景色的渐变动画
    position：用于设置CALayer的位置。修改这个属性会产生平移动画
    
*隐式动画的取消*

    可以通过动画事务(CATransaction)关闭默认的隐式动画效果
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.myview.layer.position = CGPointMake(10, 10);
    [CATransaction commit];