
#####void CGContextSetShouldAntialias(CGContextRef context, bool shouldAntialias) 

	是否开启抗锯齿
	
[开启抗锯齿LineWidth为1的问题](http://jingyan.baidu.com/article/4f7d571291085c1a2119277e.html)

#####CGContextRef UIGraphicsGetCurrentContext(void)

	获取当前上下文
	
#####void CGContextSetLineWidth(CGContextRef c, CGFloat width)

	设置线宽
	
#####void CGContextSetStrokeColorWithColor(CGContextRef c,  CGColorRef color)

	设置路径颜色
	
	
#####void CGContextMoveToPoint(CGContextRef c, CGFloat x, CGFloat y)

	设置一个起始点
	
	
#####void CGContextAddLineToPoint(CGContextRef c, CGFloat x, CGFloat y)

	追加一条线，从先前点
	
	
#####CGContextStrokePath(CGContextRef c)

	画当前上下文的路径
	
#####CGContextBeginPath(CGContextRef c)

	开始一个新路径，丢弃旧路径
	
#####void CGContextSetRGBFillColor(CGContextRef context, CGFloat red,  CGFloat green, CGFloat blue, CGFloat alpha)
	
	填充颜色
	
#####void CGContextAddArc(CGContextRef c, CGFloat x, CGFloat y, CGFloat radius, CGFloat startAngle, CGFloat endAngle, int clockwise)

	添加一个圆
	
	(x, y)圆心， radius半径， startAngle开始角度， endAngle结束角度， clockwise（1 顺时针， 0 逆时针)
	
#####void CGContextFillPath(CGContextRef c)

	填充整个路径
	
#####void CGContextFillRect(CGContextRef c, CGRect rect)

	填充一个矩形