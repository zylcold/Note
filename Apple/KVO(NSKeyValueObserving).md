# KVO(NSKeyValueObserving)

<!-- create time: 2014-11-02 20:43:45  -->

    KVO,即：Key-Value Observing，它提供一种机制，当指定的对象的属性被修改后，
    则对象就会接受到通知。简单的说就是每次指定的被观察的对象的属性被修改后，
    KVO就会自动通知相应的观察者了。
    
     NSKeyValueObservingOptionNew = 0x01,  变化的时候只会notify新的值
     NSKeyValueObservingOptionOld = 0x02,

     NSKeyValueObservingOptionInitial NS_ENUM_AVAILABLE(10_5, 2_0) = 0x04,

     NSKeyValueObservingOptionPrior NS_ENUM_AVAILABLE(10_5, 2_0) = 0x08


##使用方法


1. 注册，指定被观察者的属性，
2. 实现回调方法
3. 移除观察(通常在dealloc方法中执行移除操作)



e.g

1. 创建一个被观察者(任何继承自NSObject的对象),指定被观察的属性。

    objective-c :
    
        //创建一个Person类，有3个属性
        -> Person.h
        @interface Person : NSObject
        @property (nonatomic, copy) NSString *name;
        @property (nonatomic, assign) int age;
        @property (nonatomic, strong) NSNumber *income;
        @end
        
        //创建Person的对象，设置原始数值，并将属性组册
        -> ViewController.m
        
        Person *person = [Person new];
        person.name = @"Zyl";
        person.age = 21;
        person.income = @0;
        
        //组册监听
        [person addObserver:self        //选定观察者
            forKeyPath:@"age"            // 选择要坚听的属性名
            options:NSKeyValueObservingOptionPrior    //监听的模式
            context:nil         //传给回调方法的参数
        ];
        
2. 实现回调方法

    objective-c :
    
        -> ViewController.m
        - (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
        {
            NSLog(@"%@", change);
            
            //keyPath 被监听者改变的属性名
            //object  监听对象
            //change  改变的参数(因监听模式的不同而不同)
            //context 传递的参数
        }
 
       
3. 移除观察

    objective - c:
    
        -> ViewController.m
       
        - (void)dealloc
        {
            [self.person removeObserver:self forKeyPath:@"age"];
        }
       
       
