# XML属性列表(plist)归档

<!-- create time: 2014-11-02 19:56:04  -->

    属性列表是一种XML格式的文件，拓展名为plist
    如果对象是`NSString、NSDictionary、NSArray、NSData、NSNumber`等类型，
    就可以使用`writeToFile:atomically:`方法直接将对象写到属性列表文件中

objective-c:

    -->写入
    // 将数据封装成字典
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"母鸡" forKey:@"name"];
    [dict setObject:@"15013141314" forKey:@"phone"];
    [dict setObject:@"27" forKey:@"age"];
    // 将字典持久化到Documents/stu.plist文件中
    [dict writeToFile:path atomically:YES];
    -->读取
    // 读取Documents/stu.plist的内容，实例化NSDictionary
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];

    
    - (void)setObject:(id)anObject
           forKey:(id<NSCopying>)aKey
           
    关于anObject       
    The value for aKey. A strong reference to the object is maintained by the dictionary.
    
    
    IMPORTANT
    Raises an NSInvalidArgumentException if anObject is nil. If you need to represent a nil value in the dictionary, use NSNull.
    
    [imageDictionarysetObject:[NSNull null] forKey:indexNumber];
    [NSNull null]表示的是一个空对象，并不是nil，注意