# Objc 和 Swift 之间的桥接

<!-- create time: 2014-11-23 23:29:19  -->

转自[kuma的Swift 与 Objc 方法相互调用](http://kumadocs.com/blog/?p=533)

##Objc 中使用 Swift 的方法

    swift:
    
    import Foundation
    @objc(KDSwift)  //需要用 @objc 把类和方法名字包起来，否则在Objc里面是用不了的
    class KDSwift: NSObject {           
        @objc(sayHello)  // ----实例方法--------👆
        func sayHello() {
            println("objc : Hello")
        }
        
        @objc(sayHello)  //---类方法----------👆
        class func sayHello() {
            println("class objc : Hello")
        }
    }
    
    Objc:
    
    KDObjc.h
    #import <Foundation/Foundation.h>
    @interface KDObjc : NSObject

    @end
    
    KDObjc.m
    #import "KDObjc.h" 
    #import "SwiftAndObjC-Swift.h"    
    ////注意引入头格式是：项目名-Swift.h
    //这个头文件在项目中是找不到的，不过可以按住Command，进入SwiftAndObjC-Swift.h。
    //里面可以看到KDSwift的方法。
    
    @implementation KDObjc
    - (NSString *)sayHello
    {
        [KDSwift sayHello]; //调用类方法
        
        KDSwift *swift = [KDSwift new]; //创建对象 init也可
        [swift sayHello];  //实例方法
    }
    @end
    
    
##在Swift 中使用 Objc 的方法


    Objc:

        KDObjc.h
        #import <Foundation/Foundation.h>
        @interface KDObjc : NSObject
        - (void)sayHello;
        + (void)sayHello;
        @end

        KDObjc.m
        #import "KDObjc.h" 
        @implementation KDObjc
        - (void)sayHello
        {
            NSLog(@"Swift! Hello  - ");
        }
        
        + (void)sayHello
        {
            NSLog(@"Swift! Hello  + ");
        }
        @end

    

    1. 找到 SwiftAndObjC-Bridging-Header.h，系统自动生成的

        如果没有，手动创建头文件，然后在Build Settings->Objective-C Bridging Header设置路径
        注意，设置文件路径
        $(SRCROOT)/SwiftAndObjC/SwiftAndObjC-Bridging-Header.h
        或者 SwiftAndObjC/SwiftAndObjC-Bridging-Header.h
        
    2. 在桥接文件中加入 KDObjc.h 头文件。
    3. Swift 中调用
    
        import Foundation
        class SayHello: NSObject {           
            func sayHello() {
                let objc = KDObjc()   //创建对象
                objc.sayHello()    //调用方法
                 
                KDObjc.sayHello()  //调用类方法
            }
        }

    
    

