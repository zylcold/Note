# XCode 宏指令

<!-- create time: 2014-11-24 21:29:56  -->


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

