# AddressBook框架操作

<!-- create time: 2014-11-08 21:31:07  -->

##获得访问通讯录的权限
      
     //获得一个通讯录的对象   
     ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
     ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error) {
        if (granted) {
            NSLog(@"允许访问");
            //do SomeThing....
    });
    
    //释放book内存
    CFRelease(book); 
    
    
###查询授权状态

    //调用此方法，返回一个枚举常量
    ABAuthorizationStatus ABAddressBookGetAuthorizationStatus(void)
    
    kABAuthorizationStatusNotDetermined = 0
    用户还没有决定是否授权你的程序进行访问
    
    kABAuthorizationStatusRestricted = 1
    iOS设备上的家长控制或其它一些许可配置阻止了你的程序与通讯录数据库进行交互
    
    kABAuthorizationStatusDenied = 2
    用户明确的拒绝了你的程序对通讯录的访问
    
    kABAuthorizationStatusAuthorized = 3
    用户已经授权给你的程序对通讯录进行访问

##枚举类型头文件ABPerson.h


##获取通讯录信息


    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    //获取所有的联系人(数组)
    CFArrayRef array = ABAddressBookCopyArrayOfAllPeople(book);
    //获取数组的个数
    CFIndex count = CFArrayGetCount(array);
    //遍历数组
    for (int i = 0; i < count; i ++) {
        //取出单条记录
        ABRecordRef person = CFArrayGetValueAtIndex(array, i);
        //通过ABPropertyID从记录中取出单条数据
        CFStringRef fristN = ABRecordCopyValue(person, kABPersonFirstNameProperty);
        CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty);
        //复杂数据返回ABMultiValueRef类型(如Phone／email)
        ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
        //获取ABMultiValueRef的个数
        CFIndex phoneCount = ABMultiValueGetCount(phone);
        //遍历ABMultiValueRef
        for (CFIndex i = 0; i < phoneCount; i ++) {
            //取出ABMultiValueRef中key
            CFStringRef phoneLabel = ABMultiValueCopyLabelAtIndex(phone, i);
            //取出ABMultiValueRef中的value
            CFStringRef phoneS = ABMultiValueCopyValueAtIndex(phone, i);
            NSLog(@"%@, %@", phoneS, phoneLabel);//打印
            
            //释放phoneLabel， phoneS
            CFRelease(phoneLabel);
            CFRelease(phoneS);
        }
        //释放fristN，lastName，phone
        CFRelease(fristN);
        CFRelease(lastName);
        CFRelease(phone);
        
        //NSLog(@"%@, %@",fristN, lastName);
    }
    
    //释放array，book
    CFRelease(array);
    CFRelease(book);
    
    
##向通讯录中添加数据

    //获取通讯录对象
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    //创建一条新的记录
    ABRecordRef addRecord = ABPersonCreate();
    //创建一条信息（必须使用CFStringRef，不然添加时会产生bad access）;
    CFStringRef name = (__bridge CFStringRef)@"zylcold";  //桥接
    //添加数据
    ABRecordSetValue(addRecord, kABPersonLastNameProperty, name, NULL);
    //添加数据到book对象
    ABAddressBookAddRecord(book, addRecord, NULL);
    //保存／同步通讯录
    ABAddressBookSave(book, NULL);
    //ABAddressBookRevert(book); 放弃修改
    //释放book，addRecord
    CFRelease(book);
    CFRelease(addRecord);
    
    
##修改通讯录中的信息(先获取再修改)

    //获取通讯录对象
    ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
    //获得全部数据
    CFArrayRef array = ABAddressBookCopyArrayOfAllPeople(book);
    CFIndex count = CFArrayGetCount(array);
    //遍历数组
    for (CFIndex i = 0 ; i < count; i ++) {
        //读取每条记录
        ABRecordRef record = CFArrayGetValueAtIndex(array, i);
        //获取特定字段
        CFStringRef last =ABRecordCopyValue(record, kABPersonLastNameProperty);
        //CFStringRef 转 NSString
        NSString *lastN = (__bridge NSString *) last;
        //筛选
        if ([lastN isEqualToString:@"zylcold"]) {
            //修改数据
            ABRecordSetValue(record, kABPersonLastNameProperty, (__bridge CFStringRef)@"hehe", NULL);
            ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFStringRef)@"haha", NULL);
            //同步／保存数据
            ABAddressBookSave(book, NULL);
        }
        //释放last
        CFRelease(last);
    }
    //释放array，book
    CFRelease(array);
    CFRelease(book);
    
    
