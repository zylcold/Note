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
       
       
##通知观察者属性的变化

[NSKeyValueObserving(KVO)](http://southpeak.github.io/blog/2015/04/23/nskeyvalueobserving-kvo/)

通知观察者的方式有自动与手动两种方式。

默认情况下是自动发送通知，在这种模式下，当我们修改属性的值时，KVO会自动调用以下两个方法：

	- (void)willChangeValueForKey:(NSString *)key
	- (void)didChangeValueForKey:(NSString *)key
	
这两个方法的任务是告诉接收者给定的属性将要或已经被修改。需要注意的是不应该在子类中去重写这两个方法。

但如果我们希望自己控制通知发送的一些细节，则可以启用手动控制模式。手动控制通知提供了对KVO更精确控制，它可以控制通知如何以及何时被发送给观察者。采用这种方式可以减少不必要的通知，或者可以将多个修改组合到一个修改中。

实现手动通知的类必须重写NSObject中对automaticallyNotifiesObserversForKey:方法的实现。这个方法是在NSKeyValueObserving协议中声明的，其声明如下：

	+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
	
这个方法返回一个布尔值(默认是返回YES)，以标识参数key指定的属性是否支持自动KVO。如果我们希望手动去发送通知，则针对指定的属性返回NO。

假设我们希望PersonObject对象去监听BankObject对象的bankCodeEn属性，并希望执行手动通知，则可以如下处理：

代码清单4：关闭属性的自动通知发送

	@implementation BankObject

	+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {

	    BOOL automatic = YES;
	    if ([key isEqualToString:@"bankCodeEn"]) {
	        automatic = NO;
	    } else {
	        automatic = [super automaticallyNotifiesObserversForKey:key];
	    }

	    return automatic;
	}

	@end
这样我们便可以手动去发送属性修改通知了。需要注意的是，对于对象中其它没有处理的属性，我们需要调用[super automaticallyNotifiesObserversForKey:key]，以避免无意中修改了父类的属性的处理方式。

手动控制通知发送

	- (void)setBankCodeEn:(NSString *)bankCodeEn {

	    if (bankCodeEn != _bankCodeEn) {
	        [self willChangeValueForKey:@"bankCodeEn"];
	        _bankCodeEn = bankCodeEn;
	        [self didChangeValueForKey:@"bankCodeEn"];
	    }
	}