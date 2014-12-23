# XCode 宏指令

<!-- create time: 2014-11-24 21:29:56  -->


##判断设备版本／判断编译器的版本

    #define IOSDevice [[[UIDevice currentDevice] systemVersion] floatValue] //手机版本
    - (CGSize)sizeWithRange:(CGSize)range wihtFont:(UIFont *)font
        {
            CGSize size;
            if (IOSDevice < 7.0) {
    #if __IPHONE_OS_VERSION_MAX_ALLOWED <= 70000  //编译器最高的版本
                size = [self sizeWithFont:font constrainedToSize:range];
    #endif
            } else {
    #if __IPHONE_OS_VERSION_MIN_REQUIRED >= 70000 //编译器最低版本
                NSMutableDictionary *dict = [NSMutableDictionary dictionary];
                dict[NSFontAttributeName] = font;
                size = [self boundingRectWithSize:size      
                    options:NSStringDrawingUsesLineFragmentOrigin 
                 attributes:dict context:nil].size;
    #endif
            }
            return size;
        }

##断言

    NSAssert(condition, desc, ...);
    NSAssert(i > 10, @"error"); 如果i < 10 ,打印 error警告
    
    //无法使用
    STAssertNotNil(a1, description, ...);
    STAssertTrue(expr, description, ...);
    STAssertEquals(a1, a2, description, ...);  比较指针
    STAssertEqualObjects(a1, a2, description, ...); 比较内容
    
    NSParameterAssert(block != nil); 

##判断ARC，MRC

    #if ! __has_feature(objc_arc)
	[alert release];
    #endif

##废弃方法或者属性

    .h 文件中
    
    - (id)demoMethod();
    - (id)deprecatedMethod() __deprecated_msg("Method deprecated. Use `demoMethod`");

##忽略警告
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Wundeclared-selector" 
        objc_msgSend(demoArray, @selector(sayHello:), @"nihao");
    #pragma clang diagnostic pop
