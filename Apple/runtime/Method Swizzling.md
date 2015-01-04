# Method Swizzling

<!-- create time: 2014-12-24 19:53:32  -->

> mac osx 10.5以后的新的运行时API“Method Swizzling”

> Method Swizzling其实是方法混合或方法交换

> swizzling无法在类簇上使用。

##例子:

	Test.h

	@interface Test : NSObject
	- (NSInteger)length;
	@end 

	Test.m

	@implementation Test
	- (NSInteger)length
	{
 	   return 100;
	}
	@end

	Test+Logging.h

	@interface Test (Logging)
	- (NSInteger)logLength;
	@end

	@implementation Test (Logging)
	- (NSInteger)logLength
	{
	    return 10000;
	}

	+ (void)load
	{
  	  method_exchangeImplementations(   //运行时交换这两个方法
			class_getInstanceMethod(self, @selector(length)), 
			class_getInstanceMethod(self, @selector(logLength))
		);
	}
	@end

	mian.m
	int main(int argc, const char * argv[]) {
    	@autoreleasepool {

     	   Test *test = [[Test alloc]init];
   	       printf("%d %d\n”, (int)test.length, (int)test.logging);
        	//输出-> 10000 100
   	   }
   		return 0;
	}

method_exchangeImpementations”函数。这个函数将实例方法（在这里，其实是类别方法）length和logLength方法的实现进行交换。也就是说，当我们调用length时，实际上是调用logLength，当我们调用logLength时，实际上是调用length。

实际上，一个方法的方法名和方法体是分开的。方法体是花括号 {} 之间的代码，即方法的 IMP，而在这之前的是方法名，即 SEL。通常情况下，SEL 是与 IMP 匹配的，但在 swizzling之后，length方法的SEL还是叫做length，但IMP却变成了logLength的IMP，logLength的IMP却变成了length的IMP，