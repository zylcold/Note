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
      
      
##注意事项

   1. 处理文字和图片，通常调用Oc封装好的draw..方法，因为Quart2D绘制的坐标为左下角，使用Quart2D
   需要进行相应的坐标转换。
   2. 自定义view 需要重写里面的(void)drawRect:(CGRect)rect;方法。此方法自在创建view的时候调用一次
   3. 线段的宽度改变时，图形的坐标一般取线段中点，图形的半径一般为从圆心到线段的中点。
   4. Quartz会跟踪current point一般执行完一个相关函数后，current point都会相应的改变.但CGContextClosePath(ctx); 合并路径时，Quartz会找最后一个设置的起点的point。
   5. 
       