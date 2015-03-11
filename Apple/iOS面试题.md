###1、Object-C有多继承吗？没有的话用什么代替？
	cocoa 中所有的根类都是NSObject或NSProxy(抽象类）
	多继承在这里是用protocol 委托代理 来实现的
	不用去考虑繁琐的多继承 ,虚基类的概念.
	ood的多态特性 在 obj-c 中通过委托来实现.
###2、Object-C有私有方法吗？私有变量呢？
	objective-c – 类里面的方法只有两种, 静态方法和实例方法. 
	这似乎就不是完整的面向对象了,按照OO的原则就是一个对象只暴露有用的东西.
	 如果没有了私有方法的话, 对于一些小范围的代码重用就不那么顺手了. 
	
	在类里面声名一个私有方法

	@interface Controller : NSObject { NSString *something; }
	+ (void)thisIsAStaticMethod;
	– (void)thisIsAnInstanceMethod;
	@end
	@interface Controller (private) 
	- (void)thisIsAPrivateMethod;
	@end
	
	@private可以用来修饰私有变量
	在Objective‐C中，所有实例变量默认都是私有的，所有实例方法默认都是公有的

###3、关键字const什么含义？
	const意味着”只读”，下面的声明都是什么意思？
	const int a;
	int const a;
	const int *a;
	int * const a;
	int const * a const; 
	前两个的作用是一样，a是一个常整型数。
	第三个意味着a是一个指向常整型数的指针。
	第四个意思a是一个指向整型数的常指针。
	最后一个意味着a是一个指向常整型数的常指针。
	
	结论：
	• 关键字const的作用是为给读你代码的人传达非常有用的信息.
	• 通过给优化器一些附加的信息，使用关键字const也许能产生更紧凑的代码。
	• 合理地使用关键字const可以使编译器很自然地保护那些不希望被改变的参数，防止其被无意的代码修改。简而言之，这样可以减少bug的出现。 
	（2）对指针来说，可以指定指针本身为 const，也可以指定指针所指的数据为 const，或二者同时指定为 const；
	（3）在一个函数声明中，const 可以修饰形参，表明它是一个输入参数，在函数内部不能改变其值；
	（4）对于类的成员函数，若指定其为 const 类型，则表明其是一个常函数，不能修改类的成员变量；
	（5）对于类的成员函数，有时候必须指定其返回值为 const 类型，以使得其返回值不为“左值”。

###4、关键字volatile有什么含义？并给出三个不同例子？
一个定义为volatile的变量是说这变量可能会被意想不到地改变，这样，编译器就不会去假设这个变量的值了。精确地说就是，优化器在用到这个变量时必须每次都小心地重新读取这个变量的值，而不是使用保存在寄存器里的备份。

下面是volatile变量的几个例子：

	• 并行设备的硬件寄存器（如：状态寄存器）
	• 一个中断服务子程序中会访问到的非自动变量(Non-automatic variables)
	• 多线程应用中被几个任务共享的变量 
	• 一个参数既可以是const还可以是volatile吗？解释为什么。
	• 一个指针可以是volatile 吗？解释为什么。 

下面是答案：

• 是的。一个例子是只读的状态寄存器。它是volatile因为它可能被意想不到地改变。它是const因为程序不应该试图去修改它。

• 是的。尽管这并不很常见。一个例子是当一个中服务子程序修该一个指向一个buffer的指针时。
 
###5、static作用？
1. 函数体内 static 变量的作用范围为该函数体，不同于 auto 变量，该变量的内存只被分配一次，因此其值在下次调用时仍维持上次的值；
2. 在模块内的 static 全局变量可以被模块内所用函数访问，但不能被模块外其它函数访问；
3. 在模块内的 static 函数只可被这一模块内的其它函数调用，这个函数的使用范围被限制在声明它的模块内；
4, 在类中的 static 成员变量属于整个类所拥有，对类的所有对象只有一份拷贝；
5. 在类中的 static 成员函数属于整个类所拥有，这个函数不接收 this 指针，因而只能访问类的static 成员变量。

###6、#import和#include的区别，@class代表什么？
@class一般用于头文件中需要声明该类的某个实例变量的时候用到，在m文件中还是需要使用#import

而#import比起#include的好处就是不会引起重复包含

###7、线程和进程的区别？
进程和线程都是由操作系统所体会的程序运行的基本单元，系统利用该基本单元实现系统对应用的并发性。

进程和线程的主要差别在于它们是不同的操作系统资源管理方式。进程有独立的地址空间，一个进程崩溃后，在保护模式下不会对其它进程产生影响，而线程只是一个进程中的不同执行路径。线程有自己的堆栈和局部变量，但线程之间没有单独的地址空间，一个线程死掉就等于整个进程死掉，所以多进程的程序要比多线程的程序健壮，但在进程切换时，耗费资源较大，效率要差一些。但对于一些要求同时进行并且又要共享某些变量的并发操作，只能用线程，不能用进程。

###8、堆和栈的区别？
管理方式：对于栈来讲，是由编译器自动管理，无需我们手工控制；对于堆来说，释放工作由程序员控制，容易产生memory leak。

申请大小：

栈：在Windows下,栈是向低地址扩展的数据结构，是一块连续的内存的区域。这句话的意思是栈顶的地址和栈的最大容量是系统预先规定好的，在WINDOWS下，栈的大小是2M（也有的说是1M，总之是一个编译时就确定的常数），如果申请的空间超过栈的剩余空间时，将提示overflow。因此，能从栈获得的空间较小。

堆：堆是向高地址扩展的数据结构，是不连续的内存区域。这是由于系统是用链表来存储的空闲内存地址的，自然是不连续的，而链表的遍历方向是由低地址向高地址。堆的大小受限于计算机系统中有效的虚拟内存。由此可见，堆获得的空间比较灵活，也比较大。
碎片问题：对于堆来讲，频繁的new/delete势必会造成内存空间的不连续，从而造成大量的碎片，使程序效率降低。对于栈来讲，则不会存在这个问题，因为栈是先进后出的队列，他们是如此的一一对应，以至于永远都不可能有一个内存块从栈中间弹出
分配方式：堆都是动态分配的，没有静态分配的堆。栈有2种分配方式：静态分配和动态分配。静态分配是编译器完成的，比如局部变量的分配。动态分配由alloca函数进行分配，但是栈的动态分配和堆是不同的，他的动态分配是由编译器进行释放，无需我们手工实现。

分配效率：栈是机器系统提供的数据结构，计算机会在底层对栈提供支持：分配专门的寄存器存放栈的地址，压栈出栈都有专门的指令执行，这就决定了栈的效率比较高。堆则是C/C++函数库提供的，它的机制是很复杂的。

###9、ViewController 的loadView、viewDidLoad、viewDidUnload分别是什么时候调用的，在自定义ViewCointroller时在这几个函数中应该做什么工作？

由init、loadView、viewDidLoad、viewDidUnload、dealloc的关系说起
init方法

在init方法中实例化必要的对象（遵从LazyLoad思想）
init方法中初始化ViewController本身

loadView方法
当view需要被展示而它却是nil时，viewController会调用该方法。不要直接调用该方法。
如果手工维护views，必须重载重写该方法
如果使用IB维护views，必须不能重载重写该方法
loadView和IB构建view
你在控制器中实现了loadView方法，那么你可能会在应用运行的某个时候被内存管理控制调用。 如果设备内存不足的时候， view 控制器会收到didReceiveMemoryWarning的消息。 默认的实现是检查当前控制器的view是否在使用。 如果它的view不在当前正在使用的view hierarchy里面，且你的控制器实现了loadView方法，那么这个view将被release, loadView方法将被再次调用来创建一个新的view。

viewDidLoad方法
viewDidLoad 此方法只有当view从nib文件初始化的时候才被调用。
重载重写该方法以进一步定制view
在iPhone OS 3.0及之后的版本中，还应该重载重写viewDidUnload来释放对view的任何索引viewDidLoad后调用数据Model

viewDidUnload方法
当系统内存吃紧的时候会调用该方法（注：viewController没有被dealloc）
内存吃紧时，在iPhone OS 3.0之前didReceiveMemoryWarning是释放无用内存的唯一方式，但是OS 3.0及以后viewDidUnload方法是更好的方式
在该方法中将所有IBOutlet（无论是property还是实例变量）置为nil（系统release view时已经将其release掉了）
在该方法中释放其他与view有关的对象、其他在运行时创建（但非系统必须）的对象、在viewDidLoad中被创建的对象、缓存数据等 release对象后，将对象置为nil（IBOutlet只需要将其置为nil，系统release view时已经将其release掉了）
一般认为viewDidUnload是viewDidLoad的镜像，因为当view被重新请求时，viewDidLoad还会重新被执行
viewDidUnload中被release的对象必须是很容易被重新创建的对象（比如在viewDidLoad或其他方法中创建的对象），不要release用户数据或其他很难被重新创建的对象
dealloc方法
viewDidUnload和dealloc方法没有关联，dealloc还是继续做它该做的事情

###10、id、nil、SEL、 Method、IMP代表什么？

id和void *并非完全一样。在上面的代码中，id是指向struct objc_object的一个指针，意思是说，id是一个指向任何一个继承了Object（或者NSObject）类的对象。
需要注意的是id是一个指针，所以你在使用id的时候不需要加星号。

nil和C语言的NULL相同，在objc/objc.h中定义。nil表示一个Objctive-C对象，这个对象的指针指向空。

首字母大写的Nil和nil有一点不一样，Nil定义一个指向空的类（是Class，而不是对象）。

SEL是“selector”的一个类型，表示一个方法的名字。

Method（我们常说的方法）表示一种类型，这种类型与selector和实现(implementation)相关

IMP定义为 id (*IMP) (id, SEL, …)。这样说来， IMP是一个指向函数的指针，这个被指向的函数包括id(“self”指针)，调用的SEL（方法名），再加上一些其他参数.说白了IMP就是实现方法。

###12、UIScrollVew用到了什么设计模式？还能再foundation库中找到类似的吗？
组合模式composition，所有的container view都用了这个模式

观察者模式observer，所有的UIResponder都用了这个模式。

模板(Template)模式，所有datasource和delegate接口都是模板模式的典型应用

###13、 timer的间隔周期准吗？为什么？怎样实现一个精准的timer? 
NSTimer可以精确到50-100毫秒. 

NSTimer不是绝对准确的,而且中间耗时或阻塞错过下一个点,那么下一个点就pass过去了

###14、 C语言中讲讲static变量和static函数有什么作用
static关键字有两种意思,根据上下文来判断：

	1,表示变量是静态存储变量 
	表示变量存放在静态存储区. 
	2,表示该变量是内部连接 
	(这种情况是指该变量不在任何{}之内,就象全局变量那样,这时候加上static) ,也就是说在其它的.cpp文件中,该变量是不可见的(你不能用).

当static加在函数前面的时候 表示该函数是内部连接,之在本文件中有效,别的文件中不能应用该函数. 

不加static的函数默认为是全局的. 也就是说在其他的.cpp中只要申明一下这个函数,就可以使用它.

###15、 readwrite，readonly，assign，retain，copy，nonatomic 属性的作用

@property是一个属性访问声明，扩号内支持以下几个属性：

1. getter=getterName，setter=setterName，设置setter与 getter的方法名
2. readwrite,readonly，设置可供访问级别
3. assign，setter方法直接赋值，不进行任何retain操作，为了解决原类型与环循引用问题
4. retain，setter方法对参数进行release旧值再retain新值，所有实现都是这个顺序(CC上有相关资料)
5. copy，setter方法进行Copy操作，与retain处理流程一样，先旧值release，再 Copy出新的对象，retainCount为1。这是为了减少对上下文的依赖而引入的机制。
6. nonatomic，非原子性访问，不加同步，多线程并发访问会提高性能。注意，如果不加此属性，则默认是两个访问方法都为原子型事务访问。锁被加到所属对象实例级。
 
###16、http和scoket通信的区别。
http是客户端用http协议进行请求，发送请求时候需要封装http请求头，并绑定请求的数据，服务器一般有web服务器配合（当然也非绝 对）。 http请求方式为客户端主动发起请求，服务器才能给响应，一次请求完毕后则断开连接，以节省资源。服务器不能主动给客户端响应（除非采取http长连接 技术）。iphone主要使用类是NSUrlConnection。

scoket是客户端跟服务器直接使用socket“套接字”进行连接，并没有规定连接后断开，所以客户端和服务器可以保持连接通道，双方 都可以主动发送数据。一般在游戏开发或股票开发这种要求即时性很强并且保持发送数据量比较大的场合使用。主要使用类是CFSocketRef。

TCP全称是Transmission Control Protocol，中文名为传输控制协议，它可以提供可靠的、面向连接的网络数据传递服务。传输控制协议主要包含下列任务和功能：
* 确保IP数据报的成功传递。
* 对程序发送的大块数据进行分段和重组。
* 确保正确排序及按顺序传递分段的数据。
* 通过计算校验和，进行传输数据的完整性检查。

###17、TCP和UDP的区别
 TCP提供的是面向连接的、可靠的数据流传输，而UDP提供的是非面向连接的、不可靠的数据流传输。简单的说，TCP注重数据安全，而UDP数据传输快点，但安全性一般

###18、什么是沙箱模型？哪些操作是属于私有api范畴?
	某个iphone工程进行文件操作有此工程对应的指定的位置，不能逾越。

iphone沙箱模型的有四个文件夹：documents，tmp，app，Library。
 
1. Documents 目录：您应该将所有de应用程序数据文件写入到这个目录下。这个目录用于存储用户数据或其它应该定期备份的信息。
2. AppName.app 目录：这是应用程序的程序包目录，包含应用程序的本身。由于应用程序必须经过签名，所以您在运行时不能对这个目录中的内容进行修改，否则可能会使应用程序无法启动。
3. Library 目录：这个目录下有两个子目录：Caches 和 Preferences

	3.1 Preferences 目录包含应用程序的偏好设置文件。您不应该直接创建偏好设置文件，而是应该使用NSUserDefaults类来取得和设置应用程序的偏好.

	3.2 Caches 目录用于存放应用程序专用的支持文件，保存应用程序再次启动过程中需要的信息。
4. tmp 目录：这个目录用于存放临时文件，保存应用程序再次启动过程中不需要的信息。

####获取这些目录路径的方法：
#####1. 获取家目录路径的函数：
	NSString *homeDir = NSHomeDirectory();
#####2，获取Documents目录路径的方法：
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *docDir = [paths objectAtIndex:0];
#####3，获取Caches目录路径的方法：
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
	NSString *cachesDir = [paths objectAtIndex:0];
#####4，获取tmp目录路径的方法：
	NSString *tmpDir = NSTemporaryDirectory();
#####5，获取应用程序程序包中资源文件路径的方法：
	//例如获取程序包中一个图片资源（apple.png）路径的方法：
	NSString *imagePath = [[NSBundle mainBundle] pathForResource:@”apple” ofType:@”png”];
	UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
	//代码中的mainBundle类方法用于返回一个代表应用程序包的对象。

文件IO写入
1，将数据写到Documents目录：
	
	- (BOOL)writeApplicationData:(NSData *)data toFile:(NSString *)fileName {
	   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	   NSString *docDir = [paths objectAtIndex:0];
	   if (!docDir) {
	    NSLog(@”Documents directory not found!”); return NO;
	   }
	   NSString *filePath = [docDir stringByAppendingPathComponent:fileName];
	   return [data writeToFile:filePath atomically:YES];
	}

2，从Documents目录读取数据：

	- (NSData *)applicationDataFromFile:(NSString *)fileName {
	   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	   NSString *docDir = [paths objectAtIndex:0];
	   NSString *filePath = [docDir stringByAppendingPathComponent:fileName];
	   NSData *data = [[[NSData alloc] initWithContentsOfFile:filePath] autorelease];
	   return data;
	}
	NSSearchPathForDirectoriesInDomains这个主要就是返回一个绝对路径用来存放我们需要储存的文件。

	- (NSString *)dataFilePath {

	   NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	   NSString *documentsDirectory = [paths objectAtIndex:0];
	   return [documentsDirectory stringByAppendingPathComponent:@"shoppingCar.plist"];
	}

	NSFileManager* fm=[NSFileManager defaultManager];
	if(![fm fileExistsAtPath:[self dataFilePath]]){

	//下面是对该文件进行制定路径的保存
	[fm createDirectoryAtPath:[self dataFilePath] withIntermediateDirectories:YES attributes:nil error:nil];

	//取得一个目录下得所有文件名
	NSArray *files = [fm subpathsAtPath: [self dataFilePath] ];

	//读取某个文件
	NSData *data = [fm contentsAtPath:[self dataFilePath]];

	//或者
	NSData *data = [NSData dataWithContentOfPath:[self dataFilePath]];
	}

####19 你了解哪些加密方式？
   Base64, MD5, 循环右移位，sha1等.