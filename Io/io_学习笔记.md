# Io 学习笔记

[简介](http://my.oschina.net/u/563463/blog/285060?p=2#comments)

[安装](http://iobin.suspended-chord.info/) 

[官网](http://iolanguage.com)

##原型语言
[简介](http://lxneliu.iteye.com/blog/1675514)

> 一切都是对象，对象继承对象，这就是原型语言。


1. 通过复制创造对象

    Io:

        Io> Vehicle := Object clone
        ==>Vehicle_0x392260:
          type             = "Vehicle"
      
2. 对象是一组槽(Slot)

    Io:

        Io> Vehicle description := "Hello world"
        ==> "Hello world"
    
3. 通过发送消息获取其槽的值

    Io:

        Io> Vehicle description 
        => "Hello world"
        Io> Vehicle sloName
        ==> list("type","descripton")
    
4. 继承

  发送槽名给对象可获得该槽，如果该糟不存在，则调用父对象的槽。
  
  继承机制：
>  以大写字母开头的对象是类型，Io会为其设置type
>  以小写字母开头的对象，则会调用父对象的type槽。Io不会为其设置type

Io:

    Io> Car := Vehicle clone 
    ==> Car_0x52c210:
      type             = "Car"
    Io> Car type
    ==> Car
    
    Io> ferrari :=  Car
    ==>Car_0x532bd0:
    Io> ferrari type
    ==> Car
    
    
5. 方法

    Io:
        
        Io> method("Hello world ." println)  //==>创建方法
        ==>method(
            "Hello world ." println
        )
        Io> method type  //==>方法类型
        ==> Block
        Io> Car drive := method    //==>获取方法
        ==>method(
            "Hello world ." println
        )
        Io> Car drive   //==>调用方法
        ==>Hello world 

        Io> Car proto // ==>现实方法的所有方法，包括父对象
        ==>

  
6. 循环

 loop(执行语句) ==> 无限循环
 while(条件 ，执行语句)
 for(计数器，初始值，终止值，可选增量，执行语句)
 
 Io:
 
     Io> for (i , 1 , 11, i println);"This one goes up to 11" println
     1
     2
     3
     4
     5
     6
     7
     8
     9
     10
     11
     This one goes up to 11
     ==> This one goes up to 11
     
     Io> for(i, 1, 11, i = i + 2, i println)
     1
     4
     7
     10
     ==> 10
     
     Io> for(i, 1, 11, 2, i println)
     1
     3
     5
     7
     9
     11
     ==> 11
     
     Io> i := 1
     Io> while (i <= 5, i println; i = i + 1);"this is one goes up to 5" println
     1
     2
     3
     4
     5
     this is one goes up to 5
     ==> this is one goes up to 5
     
     
7. 判断语句

    if(conditon , true code , flase code)
    
    Io:
    
        Io> if(true , "true" , "flase" )
        ==> true
        
        
8. 消息

   > 一个消息由三部分组成，发送者（sender），目标（target）和参数（arguments）；
   
   
9. 并发

   1. 协议
   协议时并发的基础，提供了进程的自动挂起和恢复执行的机制。你可以把协议进程看作带有多个入口和出口的函数。每次调用yield都会自动挂起当前进程，并把控制权转到另一个进程中，通过在消息前加上@或@@，就可以异步出发消息。前者返回future后者返回nil，并在其自身中触发消息。
   
   Io:
   
        vizzini := Object clone
        vizzini talk := method(
            "Hello" println
            yield
            "Zhu" println
        )   
        fezzik := Object clone
        fezzik rhyme := method(
            "World" println
            yield
            "Yunlong" println
        )
        
        vizzini @@talk; fezzik @@ rhyme
        ==> "Hello"
        ==> "World"
        ==> "Zhu"
        ==> "Yunlong"
   2. actor
   3. futrue
   
   
   
   
优势：原型语言通常具有良好的可塑性。强大，现代的并发库。
1. 占用空间很小。大多数应用在嵌入式系统中。
2. 简单。
3. 灵活。
4. 并发。

劣势：社区规模较小。
1. 语法。
2. 社区。
3. 性能。