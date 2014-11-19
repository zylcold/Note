# NSFetchedResultsController／TabView使用

<!-- create time: 2014-11-11 15:17:35  -->

    在CoreData为UITableView提供数据的时候，使用NSFetchedReslutsController能提高体验，因为用NSFetchedReslutsController去读数据的话，能最大效率的读取数据库，也方便数据变化后更新界面.
    NSFetchedResultsController的作用就是用来连接NSFetchedResultsController和UITableViewController的，而且连接的方法很强大。首先，它可以回答所有UITableView DataSource、protocol的问题，唯一不能回答的是cellForRowAtIndexPath


##常用方法／属性
objetive-c:

    初始化方法:
    - (id)initWithFetchRequest:(NSFetchRequest *)fetchRequest    //查询请求
          managedObjectContext: (NSManagedObjectContext *)context  //管理对象
            sectionNameKeyPath:(NSString *)sectionNameKeyPath  //暂时不明
                     cacheName:(NSString *)name; //缓存名
                     
    cacheName就是缓存名，缓存速度很快，但有一点要小心：如果改变了fetch request的参数，比如改了predicate或者sortDescriptors,缓存会被破坏。如果真的要通过NSFetchedResultsController改fetch request，那么得删除缓存。NSFetchedResultsController里有个工厂方法可以删除缓存，或者可以就设为null，这样就不会有缓存，对于小型数据库，可以不用缓存。对于一个非常大型的数据库，如果要改request，得先删除缓存。
                     
                     
    
    - (BOOL)performFetch:(NSError **)error;
    //执行请求，YES请求数据成功

    + (void)deleteCacheWithName:(NSString *)name;
    //删除缓存
    
    - (id)objectAtIndexPath:(NSIndexPath *)indexPath;
    //返回具体位置的数据
    
    - (NSIndexPath *)indexPathForObject:(id)object;
    //返回模型数据的具体位置

    - (NSString *)sectionIndexTitleForSectionName:(NSString *)sectionName;
    //返回分组的标题
    
    @protocol NSFetchedResultsSectionInfo
    @property (nonatomic, readonly) NSString *name; 组名
    @property (nonatomic, readonly) NSUInteger numberOfObjects; 每组的数据数
    @property (nonatomic, readonly) NSArray *objects; //这组所有的数据


##使用(以Apple文档中的CoreDataBook为例)
        
###将AppDelegate的NSManagedObjectContext对象传入目标控制器

    NSManagedObjectContext对象创建在AppDelegate的好处，
    可以方便在应用的各个状态中调用[context save:&error];方法保护数据不被丢失
    通过self.window.rootViewController获取到目标控制器，进而将NSManagedObjectContext传出
        
###在目标控制器中重写NSFetchedResultsController对象的get方法，设置代理

objective-c:

    - (NSFetchedResultsController *)fetchedResultsController {
    
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController;
        }
        //创建一个请求
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        //查询的数据库表
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:self.managedObjectContext];
        //设置
        [fetchRequest setEntity:entity];

        //设置查询的条件
        NSSortDescriptor *authorDescriptor = [[NSSortDescriptor alloc] initWithKey:@"author" ascending:YES];
        NSSortDescriptor *titleDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
        NSArray *sortDescriptors = @[authorDescriptor, titleDescriptor];
        //必须添加查询条件
        [fetchRequest setSortDescriptors:sortDescriptors];
            
        //初始化NSFetchedResultsController
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"author" cacheName:@"Root"];
        //设置代理
        _fetchedResultsController.delegate = self;
        return _fetchedResultsController;
}    
        
###将NSFetchedResultsController对象的属性与tableview数据源方法一一对应

objective-c:

    //numberOfSectionsInTableView 一共有多少组数据
    return [[self.fetchedResultsController sections] count];
    //tableView numberOfRowsInSection 每组多少数据
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    //tableView titleForHeaderInSection 每组的头部标题
    [[[self.fetchedResultsController sections] objectAtIndex:section] name];
    
###在数据源cellForRowAtIndexPath中为cell设置数据

设置cell的数据

objective-c:

    - (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath 
    {
        
        Book *book = [self.fetchedResultsController objectAtIndexPath:indexPath];
        cell.textLabel.text = book.title;
    }

    - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        static NSString *CellIdentifier = @"Cell";
        UITableViewCell *cell = 
            [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        //假如缓存池中不存在，则根据storyboard中的模版创建
        [self configureCell:cell atIndexPath:indexPath];
        return cell;
    }

###在代理方法中监听数据管理对象的改变，重新刷新tableview

objective-c:

    //fetched object已经添加完成时调用
    - (void)controller:(NSFetchedResultsController *)controller  
      didChangeObject:(id)anObject      //发生改变的数据
          atIndexPath:(NSIndexPath *)indexPath  //之前数据的位置
        forChangeType:(NSFetchedResultsChangeType)type  //改变的方式
         newIndexPath:(NSIndexPath *)newIndexPath; //现在数据的位置
         
    - (void)controller:(NSFetchedResultsController *)controller 
    didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo //分组改变的数据 
             atIndex:(NSUInteger)sectionIndex    //在第几组
       forChangeType:(NSFetchedResultsChangeType)type; //改变的方式
    //fetched object 即将改变
    - (void)controllerWillChangeContent:(NSFetchedResultsController *)controller;
    // fetched object 已经改变
    - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller;
    //询问NSFetchedResultsController对象返回的标题
    - (NSString *)controller:(NSFetchedResultsController *)controller    
       sectionIndexTitleForSectionName:(NSString *)sectionName 
    
    4中改变类型
    NSFetchedResultsChangeInsert = 1,
	NSFetchedResultsChangeDelete = 2,
	NSFetchedResultsChangeMove = 3,
	NSFetchedResultsChangeUpdate = 4


    
