# Quartz2D

<!-- create time: 2014-10-14 00:00:42  -->

        Quartz 2D是一个二维绘图引擎，同时支持iOS和Mac系统
        Quartz2D的API是纯C语言的
        Quartz2D的API来自于Core Graphics框架
        
        绘制图形:线条\三角形\矩形\圆\弧等   -> 涂鸦画板
        绘制文字                     -> 添加水印
        绘制\生成图片(图像)            ->手势解锁 ，报表：折线图\饼状图\柱状图
        读取\生成PDF
        截图\裁剪图片     -> 剪裁图片
        自定义UI控件  ->iOS中大部分控件的内容都是通过Quartz2D画出来的
        

##概述

1. 图形上下文
    
        图形上下文（Graphics Context）：是一个CGContextRef类型的数据

   * 图形上下文的作用
   
       1. 保存绘图信息、绘图状态
       2. 决定绘制的输出目标(输出目标可以是PDF文件、Bitmap或者显示器的窗口上)
   
   * Quartz2D提供了以下几种类型的Graphics Context:

       1. Bitmap Graphics Context
       2. PDF Graphics Context 
       3. Window Graphics Context
       4. Layer Graphics Context        
       5. Printer Graphics Context 
       
       
2. 创建步骤

    1. 获得图形上下文对象
        
             CGContextRef ctx = UIGraphicsGetCurrentContext();
             //为C语言，创建对象无需加*
        
    2. 拼接路径
    
            CGContextMoveToPoint(ctx, 10, 10);
            CGContextAddLineToPoint(ctx, 100, 100);
            .....其他操作
            
    3. 绘制路径
            
            CGContextStrokePath(ctx);  绘制空心的图形
            // CGContextFillPath(ctx); 绘制实心的图形
            CGContextDrawPath(ctx, CGPathDrawingMode mode)
            //Mode参数决定绘制的模式
            其中的枚举函数
            num CGPathDrawingMode  {
               kCGPathFill ,
               kCGPathEOFill ,
               kCGPathStroke ,
               kCGPathFillStroke ,
               kCGPathEOFillStroke 
            };

            
3. 常用的拼接函数

    objective-C:
    
        //新建一个起点
        void CGContextMoveToPoint(CGContextRef c, CGFloat x, CGFloat y)
        //添加一个线段到x，y
        void CGContextAddLineToPoint(CGContextRef c, CGFloat x, CGFloat y)
        //添加一个大小为rect的矩形
        void CGContextAddRect(CGContextRef c, CGRect rect)
        //添加一个大小在rect内的椭圆
        void CGContextAddEllipseInRect(CGContextRef context, CGRect rect)
        //添加一个圆心为x,y 半径为radius 起始弧度为startAngle
        //结束弧度为endAngle,顺时针0／逆时针1
        void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y,
          CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)
        // 假如想创建一个完整的圆圈，那么 开始弧度就是0 结束弧度是 2Pi(M_PI * 2)
        
        三次曲线函数
        void CGContextAddCurveToPoint (
            CGContextRef c,
            CGFloat cp1x, //控制点1 x坐标
            CGFloat cp1y, //控制点1 y坐标
            CGFloat cp2x, //控制点2 x坐标
            CGFloat cp2y, //控制点2 y坐标
            CGFloat x,  //直线的终点 x坐标
            CGFloat y  //直线的终点 y坐标
        );
        
        二次曲线函数
         void CGContextAddQuadCurveToPoint (
            CGContextRef c,
            CGFloat cpx,  //控制点 x坐标
            CGFloat cpy,  //控制点 y坐标
            CGFloat x,  //直线的终点 x坐标
            CGFloat y  //直线的终点 y坐标
         );
          
##常用的CGContextset方法

   objective-C:
   
      Line width  -->线段的x，y为线段的中央
      void CGContextSetLineWidth (
         CGContextRef c,
         CGFloat width
      );
      
      Line join：线转弯的时候的样式，比如圆滑的方式
      void CGContextSetLineJoin (
         CGContextRef c,
         CGLineJoin join
      ); 
      
      Line cap：线的两端的样式，比如两端变的圆滑
      void CGContextSetLineCap (
         CGContextRef c,
         CGLineCap cap
      );
      
      Miter limit：当Line join的模式是Miter join的时候，这个参数会有影响
      void CGContextSetMiterLimit (
         CGContextRef c,
         CGFloat limit
      );
      
      Line dash pattern：虚线相关
      void CGContextSetLineDash (
         CGContextRef c,
         CGFloat phase,
         const CGFloat lengths[],
         size_t count
      );
      
      设置颜色可以在其中通过Oc语法设置
      
 
 
##图像的重绘（刷帧）
   
   调用重绘view对象的
   
       - (void)setNeedsDisplay; 刷新全部view
       
       - (void)setNeedsDisplayInRect:(CGRect)rect; 刷新区域为rect的view
       
  执行此方法时，系统回重新调用view的(void)drawRect:(CGRect)rect（切勿手动调用）
      
          因为系统在执行此方法时，会自动创建CGContextRef对象，我们通过        
          UIGraphicsGetCurrentContext()就可以获取此对象，
          而手动创建无法自动创建此对象。
          
  
  
##图形上下文栈

    将当前的图形上下文对象保存到一个特定的栈中储存
    CGContextSaveGState(CGContextRef c)
    
    //将栈中的图形上下文对象取出，替换当前的上下文对象
    CGContextRestoreGState(CGContextRef c)
    
    
    
##创建图像路径

   1. 首先需要调用CGContextBeginPath来标记Quartz 
   2. CGMutablePathRef tpr = CGPathCreateMutable();创建路径对象（此非单例对象）
   3. CGPathMoveToPoint／CGPathAdd../绘制路径（第二个参数CGAffineTransform（坐标变换）可为NULL）
   4. CGContextAddPath(ctx,tpr);  将路径添加到图形上下文
   5. CGPathRelease(tpr);释放tpr内存。
   
   
###⚠ 注意事项 
    使用含有“Create”或“Copy”的函数创建的对象，使用完后必须释放，否则将导致内存泄露

    使用不含有“Create”或“Copy”的函数获取的对象，则不需要释放

    如果retain了一个对象，不再使用时，需要将其release掉

    可以使用Quartz 2D的函数来指定retain和release一个对象。
    例如，如果创建了一个CGColorSpace对象，则使用函数CGColorSpaceRetain和
        CGColorSpaceRelease来retain和release对象。

    也可以使用Core Foundation的CFRetain和CFRelease。注意不能传递NULL值给这些函数 
          



##矩阵操作

    矩阵操作，要在操作图像之前声明
    
    view之所以能够显示视图，是因为它的上面有layer,将来图形也是渲染到layer上面。
        因此，旋转的时候是整个layer都旋转了
    
   1. 旋转CGContextRotateCTM(<#CGContextRef c#>, <#CGFloat angle#>)图形上下文，弧度
   2. 缩放CGContextScaleCTM(<#CGContextRef c#>, <#CGFloat sx#>, <#CGFloat sy#>)
       图形上下文，x方向的缩放比例，y方向上的缩放比例
   3. 平移CGContextTranslateCTM(<#CGContextRef c#>, <#CGFloat tx#>, <#CGFloat ty#>)
       （图形上下文，x方向的偏移量，y方向上的偏移量）


##图像上下文

   1. 开启一个基于位图的图形上下文
   UIGraphicsBeginImageContextWithOptions(CGSize size, BOOL opaque, CGFloat scale)
       //图像的范围，透明度，比例
       
   2. 获取一个图形上下文
       CGContextRef ctx = UIGraphicsGetCurrentContext();
       
   3. 对图像的操作，添加水印／剪切等等
   
   4. 从上下文中取出图像 UIImage* UIGraphicsGetImageFromCurrentImageContext();
   
   5. 结束基于位图的图形上下文  UIGraphicsEndImageContext();

###⚠注意事项

   1. 不同于在drawRect:中，必须先手动创建一个图形上下文才能获取其对象，在使用结束后必须手动通过UIGraphicsEndImageContext();释放内存。
   2. 取出图像的操作必须在释放内存之前进行，
   3. 在其中的所有的操作，均在size范围内，超出不会显示。
   
   
   
   
##屏幕截图

        截图，就是获取view larer的图层。
        
   相关代码:
   
          - (void)renderInContext:(CGContextRef)ctx;
          调用某个view的layer的renderInContext:方法即可
          也需在图像的上下文中操作。

   
          
##⚠注意事项

   1. 处理文字和图片，通常调用Oc封装好的draw..方法，因为Quart2D绘制的坐标为左下角，使用Quart2D
   需要进行相应的坐标转换。
   2. 自定义view 需要重写里面的(void)drawRect:(CGRect)rect;方法。此方法自在创建view的时候调用一次
   3. 线段的宽度改变时，图形的坐标一般取线段中点，图形的半径一般为从圆心到线段的中点。
   4. Quartz会跟踪current point一般执行完一个相关函数后，current point都会相应的改变.但CGContextClosePath(ctx); 合并路径时，Quartz会找最后一个设置的起点的point。
   5. 
       