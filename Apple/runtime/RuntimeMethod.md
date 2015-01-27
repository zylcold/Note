# RuntimeMethod

<!-- create time: 2015-01-04 23:17:28  -->

<h1 id=“anchor0”>类与对象操作函数</h1>
	
runtime提供了大量的函数来操作类与对象。类的操作方法大部分是以class为前缀的，而对象的操作方法大部分是以objc或object_为前缀	

<h3>类相关操作函数</h3>
####类名(name)

	//获取类的类名
	const char * class_getName ( Class cls );

####父类(super_class)和元类(meta-class)

	//获取类的父类
	//当cls为Nil或者cls为根类时，返回Ni
	Class class_getSuperclass ( Class cls );
	// 判断给定的Class是否是一个元类
	BOOL class_isMetaClass ( Class cls );

####实例变量大小(instance_size)

	//获取实例大小
	size_t class_getInstanceSize ( Class cls );

####成员变量(ivars)及属性
在objc_class中，所有的成员变量、属性的信息是放在链表ivars中的。ivars是一个数组，数组中每个元素是指向Ivar(变量信息)的指针。

#####成员变量操作函数，主要包含以下函数：

	//获取类中指定名称实例成员变量的信息
	//返回一个指向包含name指定的成员变量信息的objc_ivar结构体的指针(Ivar)
	Ivar class_getInstanceVariable ( Class cls, const char *name ); 

	//获取类成员变量的信息
	//一般认为Objective-C不支持类变量,返回的列表不包含父类的成员变量和属性
	Ivar class_getClassVariable ( Class cls, const char *name );

	//添加成员变量
	//此方法只能在objc_allocateClassPair函数与objc_registerClassPair之间调用。
	//另外，这个类也不能是元类。
	BOOL class_addIvar(
					Class cls, 
					const char *name,  
					size_t size, 
					uint8_t alignment, 
					const char *types );

	//获取整个成员变量列表
	//返回一个指向成员变量信息的数组，
	//数组中每个元素是指向该成员变量信息的objc_ivar结构体的指针。
	//这个数组不包含在父类中声明的变量。outCount指针返回数组的大小。
	//注意必须使用free()来释放这个数组
	Ivar * class_copyIvarList ( Class cls, unsigned int *outCount );

#####属性操作函数

	//获取指定的属性
    objc_property_t class_getProperty ( Class cls, const char *name );

	//获取属性列表
    objc_property_t* class_copyPropertyList 
               ( Class cls, unsigned int *outCount ); 
	//为类添加属性
    BOOL class_addProperty (
                Class cls, 
                const char *name, 
                const objc_property_attribute_t *attributes, 
                unsigned int attributeCount );
	//替换类的属性
    void class_replaceProperty ( 
                Class cls, 
                const char *name, 
                const objc_property_attribute_t *attributes, 
                unsigned int attributeCount );

#####在MAC OS X系统中,使用垃圾回收器。
runtime提供了几个函数来确定一个对象的内存区域是否可以被垃圾回收器扫描，以处理strong/weak引用。

	const uint8_t * class_getIvarLayout( Class cls );
	void class_setIvarLayout( Class cls, const uint8_t *layout );
	const uint8_t * class_getWeakIvarLayout( Class cls );
	void class_setWeakIvarLayout( Class cls, const uint8_t *layout );

#####方法(methodLists)
一个Objective-C方法是一个简单的C函数，它至少包含两个参数—self和_cmd。所以，我们的实现函数(IMP参数指向的函数)至少需要两个参数.
	
	void myMethodIMP(id self, SEL _cmd)
	{
		// implementation ....
	}

	//添加方法
	//class_addMethod的实现会覆盖父类的方法实现，但不会取代本类中已存在的实现，
	//如果本类中包含一个同名的实现，则函数会返回NO。
	BOOL class_addMethod
			(Class cls, SEL name, IMP imp, const char *types);

	//获取实例方法
	Method class_getInstanceMethod ( Class cls, SEL name );
	//获取类方法
	Method class_getClassMethod ( Class cls, SEL name );
	//获取所有方法的数组
	Method* class_copyMethodList 
			( Class cls, unsigned int *outCount );
	//class_getInstanceMethod、class_getClassMethod函数，
	 //与class_copyMethodList不同的是，这两个函数都会去搜索父类的实现。

	
	//替代方法的实现
	IMP class_replaceMethod ( 
				Class cls, SEL name, IMP imp, const char *types );

	//返回方法的具体实现
	IMP class_getMethodImplementation ( Class cls, SEL name );
	IMP class_getMethodImplementation_stret ( Class cls, SEL name );

	//类实例是否响应指定的selector
	BOOL class_respondsToSelector ( Class cls, SEL sel );

#####协议(objc_protocol_list)

	//添加协议	
	BOOL class_addProtocol ( Class cls, Protocol *protocol );

	//返回类是否实现指定的协议
	//可以使用NSObject类的conformsToProtocol:方法来替代
	BOOL class_conformsToProtocol ( Class cls, Protocol *protocol );

	//返回类实现的协议列表
	//返回的是一个数组，在使用后我们需要使用free()手动释放
	Protocol * class_copyProtocolList 
							( Class cls, unsigned int *outCount );

<h3>动态创建类和对象</h3>

#####动态创建类

为了创建一个新类，我们需要调用objc_allocateClassPair。然后使用诸如class_addMethod，class_addIvar等函数来为新创建的类添加方法、实例变量和属性等。完成这些后，我们需要调用objc_registerClassPair函数来注册类，之后这个新类就可以在程序中使用了。
实例方法和实例变量应该添加到类自身上，而类方法应该添加到类的元类上。

	//创建一个新类和元类
	//如果我们要创建一个根类，则superclass指定为Nil。
	//extraBytes通常指定为0，该参数是分配给类和元类对象尾部的索引ivars的字节数。
	Class objc_allocateClassPair 
			( Class superclass, const char *name, size_t extraBytes );
	
	//销毁一个类及其相关联的类
	void objc_disposeClassPair ( Class cls );

	//在应用中注册由objc_allocateClassPair创建的类
	void objc_registerClassPair ( Class cls );

#####动态创建对象

	//创建类实例
	//创建实例时，会在默认的内存区域为类分配内存。
	//extraBytes参数表示分配的额外字节数。
	//这些额外的字节可用于存储在类定义中所定义的实例变量之外的实例变量。
	//该函数在ARC环境下无法使用。
	id class_createInstance ( Class cls, size_t extraBytes );

	//在指定位置创建类实例
	//在指定的位置(bytes)创建类实例
	id objc_constructInstance ( Class cls, void *bytes );
	
	//销毁类实例
	//销毁一个类的实例，但不会释放并移除任何与其相关的引用。
	void * objc_destructInstance ( id obj );

#####实例操作函数