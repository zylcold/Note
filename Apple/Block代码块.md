# Block代码块(转)



<!-- create time: 2014-10-18 13:41:29  -->

    代码块本质上是和其他变量类似。不同的是，代码块存储的数据是一个函数体。
    使用代码块是，你可以像调用其他标准函数一样，传入参数数，并得到返回值。
    
    脱字符（^）是块的语法标记。
    按照我们熟悉的参数语法规约所定义的返回值以及块的主体（也就是可以执行的代码）。
    
    
    结构
    
       返回值 (^方法名)(参数类型) ＝ ^(参数类型 参数名){ 执行代码 }
       
       
       e.g
        
       //声明
       int (^zhuMethod)(int, int) = ^(int num1, int num2)
       {
           return num1 + num2;
       }
       
       或者

       int (^zhuMethod)(int, int);
       
       zhuMethod = ^(int num1, int num2)
       {
           return num1 + num3;
           
       }
       
       
       或者在objective-c中定义为宏
       1. 定义宏
       typedef int (^ZhuMethod)(int, int);
       
       2. 声明属性
       
       @property (nonatomic, copy) ZhuMethod zhuMehod;
       
       3. 添加方法
       
       self.zhuMethod = ^(int m, int n)
       {
           return m + n;
       }
       
       4. 调用
       
        self.zhuMethod(10, 11);
        
              
               
       //使用 接近c语言
       
       
       zhuMethod(2, 3); 
  
   
       
##⚠注意事项
    
   1. 内存泄露
   
   在代码块使用的变量，都将默认为强引用，因此在使用时，一定要注意避免强指针的循环引用而导致的内存泄漏问题。
   
   e.g
   代码块中使用self，_成员变量
   
   如果代码块中必须使用这些属性／对象，应该在block前，声明一个弱指针，替代那些属性
   
       __weak ZhuBlock *zhu;
       __unsafe_unretained ZhuBlock *zhu2;
       __weak typeof(self) zhu3;       
       
       利用zhu， zhu2， zhu3 替代self对象
       
##以下转自[容芳志专栏](http://blog.csdn.net/totogo2010/)原创 

 2. 常用功能
 
     * 参数是NSString*的代码块
     
       objective-c:
       
            void (^printBlock)(NSString *x);
            printBlock = ^(NSString* str)
            {
                NSLog(@"print:%@", str);
            };
            printBlock(@"hello world!");
        
        
            ==>print:hello world!
        
     * 代码用在字符串数组排序
     
       objective-c:
       
            NSArray *stringArray = [NSArray arrayWithObjects:
                @"abc 1", @"abc 21", @"abc 12",@"abc 13",@"abc 05",nil];
            NSComparator sortBlock = ^(id string1, id string2)
            {
                return [string1 compare:string2];
            };
            NSArray *sortArray = [stringArray
                         sortedArrayUsingComparator:sortBlock];
            NSLog(@"sortArray:%@", sortArray);
    
            ==>
            sortArray:(
                "abc 05",
                "abc 1",
                "abc 12",
                "abc 13",
                "abc 21"
            )    
     
      * 代码块的递归调用
      
          代码块想要递归调用，代码块变量必须是全局变量或者是静态变量，
              这样在程序启动的时候代码块变量就初始化了，可以递归调用
     
       objective-c:
       
        static void (^ const blocks)(int) = ^(int i)  
        {  
            if (i > 0) {  
                NSLog(@"num:%d", i);  
                blocks(i - 1);  
            }  
        };  
        
        blocks(3);
        
        ==>
            num:3
            num:2
            num:1


     * 在代码块中使用局部变量和全局变量
     
        **在代码块中可以使用和改变全局变量**
     
       objective-c:
       
            int global = 1000;
            int main(int argc, const char * argv[])
            {
                 @autoreleasepool {
                     void(^block)(void) = ^(void)
                     {
                         global++;
                         NSLog(@"global:%d", global);
                     };
                     block();
                     NSLog(@"global:%d", global);
                 }
                return 0;
            }
        
        
      **而局部变量可以使用，但是不能改变**
      
      objective-c:
          
        
        int local = 500;
        void(^block)(void) = ^(void)
        {
             //    local++;
                NSLog(@"local:%d", local);
        };
        block();
        NSLog(@"local:%d", local);
        
        
     **在代码块中改变局部变量编译不通过。怎么在代码块中改变局部变量呢？在局部变量前面加上关键字：__block**
     
     objective-c:
     
         __block int local = 500;  
        void(^block)(void) = ^(void)  
        {  
            local++;  
            NSLog(@"local:%d", local);  
        };  
        block();  
        NSLog(@"local:%d", local); 
               
        ==>
        local:501
        local:501