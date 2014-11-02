# Preference(偏好设置)

<!-- create time: 2014-11-02 20:23:15  -->


    保存用户名、密码、字体大小等设置，iOS提供了一套标准的解决方案来为应用加入偏好设置功能
    每个应用都有个NSUserDefaults实例，通过它来存取偏好设置
 
 objective-c:
     
    -->写入
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"itcast" forKey:@"username"];
    [defaults setFloat:18.0f forKey:@"text_size"];
    [defaults setBool:YES forKey:@"auto_login"];
    -->读取
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [defaults stringForKey:@"username"];
    float textSize = [defaults floatForKey:@"text_size"];
    BOOL autoLogin = [defaults boolForKey:@"auto_login"];
    
    [defaults synchornize];
    
    注意：UserDefaults设置数据时，不是立即写入，
    而是根据时间戳定时地把缓存中的数据写入本地磁盘。
    所以调用了set方法之后数据有可能还没有写入磁盘应用程序就终止了。
    出现以上问题，可以通过调用synchornize方法强制写入
    
