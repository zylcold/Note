# CoreData数据存储

<!-- create time: 2014-11-10 22:52:38  -->

参考[任海丽的IOS之分析网易新闻存储数据](http://blog.csdn.net/rhljiayou/article/details/18037729)

    1、NSManagedObjectContext
    管理对象，上下文，持久性存储模型对象
    2、NSManagedObjectModel
    被管理的数据模型，数据结构
    3、NSPersistentStoreCoordinator
    连接数据库的
    4、NSManagedObject
    被管理的数据记录
    5、NSFetchRequest
    数据请求
    6、NSEntityDescription
    表格实体结构
    
    此外还需要知道.xcdatamodel文件编译后为.momd或者.mom文件


通常使用系统CoreData模版，系统会默认在AppDelegate中添加2个方法，3个属性

    @property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;  //管理对象
    @property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;   //被管理的数据模型，数据结构
    @property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
    //数据库连接
    - (void)saveContext; //保存数据库
    - (NSURL *)applicationDocumentsDirectory; //返回Documents文件夹路径
    
##步骤

###创建数据库。

    New -> Files -> IOS -> Core Data -> Data Model
    
###添加表/字段 

    Add Entity 
    
    字段 Attribute  -> +

###创建模型

    Editor -> Create NSManagedObject SubClass
    
    Xcode会根据数据库来创建相应的属性。继承自NSManagedObject类
    
###连接数据库
#### 获取NSManagedObjectModel对象
   
       - (NSManagedObjectModel *)managedObjectModel {
          if (_managedObjectModel != nil) {
              return _managedObjectModel;
          }
          NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"MyData" withExtension:@"momd"];
          _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
          return _managedObjectModel;
      }
      
####创建数据库，并关联
        
objective-c:
        

    - (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
        //判断是否创建
        if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }   
        //通过managedObjectModel创建一个persistentStoreCoordinator对象
        _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
        //创建数据库文件
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"CoreDataDemo.sqlite"];
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        //关联数据库
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
            //发生错误，设置错误信息
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
            dict[NSLocalizedFailureReasonErrorKey] = failureReason;
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
        return _persistentStoreCoordinator;
    }

###创建NSManagedObjectContext 管理对象
    
objective-c:
   
    - (NSManagedObjectContext *)managedObjectContext {
       if (_managedObjectContext != nil) {
           return _managedObjectContext;
       }
       NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
       if (!coordinator) {
           return nil;
       }
       _managedObjectContext = [[NSManagedObjectContext alloc] init];
       [_managedObjectContext setPersistentStoreCoordinator:coordinator];
       return _managedObjectContext;
   }

###增删改查
    e.g 当前我数据库创建了一个Student表，包含name，age，uid 3个属性
####增
    
objective-c:

    - (void)insertCoreData {
    NSManagedObjectContext *contents = self.managedObjectContext;
    for (int i = 0; i < 100; i ++) {
        Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student"
                                                     inManagedObjectContext:contents];
        stu.name = [NSString stringWithFormat:@"zylcold-%d",i];
        stu.age = @(arc4random_uniform(1000));
        stu.uid = @(arc4random_uniform(13300));
    }
    
    
    NSError *error;
    if ([contents save:&error]) {
        if (error) {
            NSLog(@"%@", error);
        }
    }
    
}    
####删

objective-c:

    
       - (void)deleteData {
        //获取管理对象
        NSManagedObjectContext *contents = self.managedObjectContext;
        //获取Student的表格结构体
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:contents];
        //创建请求
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        //
        [request setIncludesPropertyValues:NO];
        //设置请求的表格
        [request setEntity:entity];
        NSError *error = nil;
        //从管理对象中取出数据
        NSArray *datas = [contents executeFetchRequest:request error:&error];
        if (!error && datas && [datas count])
        {
            for (NSManagedObject *obj in datas)
            {
                //执行删除操作
                [contents deleteObject:obj];
            }
            //执行保存操作
            if (![contents save:&error])
            {
                NSLog(@"error:%@",error);
            }
        }

    } 
    

    
###改

objective-c:

    - (void)updateData {
        NSManagedObjectContext *contents = self.managedObjectContext;
        //创建查询条件
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like[cd] %@",@"zylcold"];
        //建立一个request
        NSFetchRequest * request = [[NSFetchRequest alloc] init];
        [request setEntity:[NSEntityDescription entityForName:@"Student" inManagedObjectContext:contents]];
        //设置查询条件
        [request setPredicate:predicate];
        NSError *error = nil;
        //获取查询结果
        NSArray *result = [contents executeFetchRequest:request error:&error];//这里获取到的是一个数组，你需要取出你要更新的那个obj
        //遍历数组，更改数据
        for (Student *stu in result) {
            stu.name = @"hahah";
        }
        //保存数据
        if ([contents save:&error]) {
            //更新成功
            NSLog(@"更新成功");
        }
    }


###查

[Apple官方查询语句文档](https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/Predicates/Articles/pCreating.html)

objective-c:

    - (void)selectData {
        NSManagedObjectContext *contents = [self managedObjectContext]; 
        //创建查询条件
        NSPredicate *predicate = [NSPredicate
                                  predicateWithFormat:@"(age > %d) AND (uid < %d)",50, 120];
        //查询请求
        NSFetchRequest *request = [[NSFetchRequest alloc] init]; 
        // 限定查询结果的数量
        [request setFetchLimit:10];
        // 查询的偏移量
        [request setFetchOffset:0];
        //设置查询条件
        [request setPredicate:predicate];
        //创建表格结构对象
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:contents];
        [request setEntity:entity];
        NSError *error;
        //获取结果
        NSArray *fetchedObjects = [contents executeFetchRequest:request error:&error];
        NSMutableArray *resultArray = [NSMutableArray array];
        for (Student *stu in fetchedObjects) {
            NSLog(@"id:%@", stu.name);
            NSLog(@"title:%@", stu.uid);
            [resultArray addObject:stu];
        }
    }
    
##生成的数据

    在应用沙盒的Documents文件夹下会生成3个文件
    
    e.g
    
    |-Documents
    |---->CoreDataDemo.sqlite
    |---->CoreDataDemo.sqlite-shm
    |---->CoreDataDemo.sqlite-wal
    
    数据库里面通常有3张表
    Z_METADATA里面记录了一个本机的UUID。
    Z_PRIMARYKEY里面是所有自己创建的表格的名字。
    ZSTUDENT是自己创建的表格，打开里面就是我们的数据记录。(根据表名)
