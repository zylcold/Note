[Facebook Pop 使用指南](http://www.cocoachina.com/industry/20140527/8565.html)
[转自卢克进的博客](http://geeklu.com)

	Facebook Pop其实是基于CADisplayLink(Mac平台上使用的CVDisplayLink)实现的独立于Core Animation之外的动画方案。
	Core Aniamtion中进行插值计算所依赖的时间曲线由CAMediaTimingFunction提供。 
	Pop Animation在使用上和Core Animation很相似，都涉及Animation对象以及Animation的载体的概念，不同的是Core Animation的载体只能是CALayer，而Pop Animation可以是任意基于NSObject的对象。

####POPBasicAnimation  基础动画 可以在给定时间的运动中插入数值调整运动节奏

	基本动画，接口方面和CABasicAniamtion很相似，
	使用可以提供初始值fromValue，这个 终点值toValue，
	动画时长duration以及决定动画节奏的timingFunction。timingFunction直接使用的CAMediaTimingFunction,
	是使用一个横向纵向都为一个单位的拥有两个控制点的贝赛尔曲线来描述的，横坐标为时间，纵坐标为动画进度。
####POPSpringAnimation 弹性动画 可以赋予物体愉悦的弹性效果

	弹簧动画是Bezier曲线无法表述的，所以无法使用PopBasicAniamtion来实现。PopSpringAnimation便是专门用来实现弹簧动画的。
	
	1.springBounciness 弹簧弹力 取值范围为[0, 20]，默认值为4
	2.springSpeed 弹簧速度，速度越快，动画时间越短 [0, 20]，默认为12，和springBounciness一起决定着弹簧动画的效果
	3.dynamicsTension 弹簧的张力
	4.dynamicsFriction 弹簧摩擦
	5.dynamicsMass 质量 。张力，摩擦，质量这三者可以从更细的粒度上替代springBounciness和springSpeed控制弹簧动画的效果
####POPDecayAnimation 衰减动画 可以用来逐渐减慢物体的速度至停止

	基于Bezier曲线的timingFuntion同样无法表述Decay Aniamtion，所以Pop就单独实现了一个 PopDecayAnimation，用于衰减动画。
	衰减动画一个很常见的地方就是 UIScrollView 滑动松开后的减速，这里就基于UIView实现一个自己的ScrollView，然后使用PopDecayAnimation实现 
	此代码可以详细参见 KKScrollView 的实现，当滑动手势结束时，根据结束的加速度，给衰减动画一个初始的velocity，用来决定衰减的时长。
####POPCustomAnimation	自定义动画 可以让设计值创建自定义动效，只需简单处理CADisplayLink，并联系时间-运动关系

	POPCustomAnimation 并不是基于POPPropertyAnimation的，它直接继承自PopAnimation用于创建自定义动画用的，通过POPCustomAnimationBlock类型的block进行初始化
	typedef BOOL (^POPCustomAnimationBlock)(id target, POPCustomAnimation *animation);
	此block会在界面的每一帧更新的时候被调用，创建者需要在block中根据当前currentTime和elapsedTime来决定如何更新target的相关属性，以实现特定的动画。
	当你需要结束动画的时候就在block中返回NO，否则返回YES。
	
####Pop Animation相比于Core Animation的优点

	Pop Animation应用于CALayer时，在动画运行的任何时刻，layer和其presentationLayer的相关属性值始终保持一致，而Core Animation做不到。 
	Pop Animation可以应用任何NSObject的对象，而Core Aniamtion必须是CALayer。