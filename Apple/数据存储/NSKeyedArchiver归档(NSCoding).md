# NSKeyedArchiver归档(NSCoding)

<!-- create time: 2014-11-02 20:20:52  -->

  如果对象是NSString、NSDictionary、NSArray、NSData、NSNumber等类型，可以直接用NSKeyedArchiver进行归档和恢复
    不是所有的对象都可以直接用这种方法进行归档，只有遵守了NSCoding协议的对象才可以


* 遵守NSCoding协议的2个方法:
    1. `encodeWithCoder:`每次归档对象时，都会调用这个方法。一般在这个方法里面指定如何归档对象中的每个实例变量，可以使用encodeObject:forKey:方法归档实例变量
    2. `initWithCoder:`每次从文件中恢复(解码)对象时，都会调用这个方法。一般在这个方法里面指定如何解码文件中的数据为对象的实例变量，可以使用decodeObject:forKey方法解码实例变量

* 归档(编码)

   objvetive-c:
   
       Person *person = [[[Person alloc] init] autorelease];
       person.name = @"Zhu";
       person.age = 23;
       person.height = 1.83f;
       [NSKeyedArchiver archiveRootObject:person toFile:path];
* 恢复(解码)

    objvetive-c:

        Person *person = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

* 注意
    1. 归档／恢复 NSArray对象
        objvetive-c:
            
            -->归档
            NSArray *array = [NSArray arrayWithObjects: @"a", @"b",nil];
            [NSKeyedArchiver archiveRootObject:array toFile:path];

            -->读取
            NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    2. 归档对象时注意 
    
        1. 如果父类也遵守了NSCoding协议，请注意：应该在encodeWithCoder:方法中加上一句
        
            [super encodeWithCode:encode];确保继承的实例变量也能被编码，即也能被归档
            
        2. 应该在initWithCoder:方法中加上一句self = [super initWithCoder:decoder];

            确保继承的实例变量也能被解码，即也能被恢复