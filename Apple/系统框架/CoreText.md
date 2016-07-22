##Core Text
###流程
 1、生成要绘制的NSAttributedString对象。 
 2、生成一个CTFramesetterRef对象，然后创建一个CGPath对象，这个Path对象用于表示可绘制区域坐标值、长宽。 
 3、使用上面生成的setter和path生成一个CTFrameRef对象，这个对象包含了这两个对象的信息（字体信息、坐标信息）
 4、CTFrameDraw方法绘制。


	 - (void)_drawRectWithContext:(CGContextRef)context
	{
	  // generate NSAttributedString object
	    NSAttributedString *contentAttrString = [self _generateAttributeString];

	  // path 
	    CGRect bounds = CGRectInset(self.bounds, 10.0f, 10.0f);
	    CGMutablePathRef path = CGPathCreateMutable();
	    CGPathAddRect(path, NULL, bounds);

	    // ------------------------ begin draw
	    // draw coretext
	    CTFramesetterRef framesetter
	        = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(contentAttrString));

	    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
	    CTFrameDraw(frame, context);

	    CFRelease(frame);
	    CFRelease(path);
	    CFRelease(framesetter);
	    // ------------------------ end draw
	}