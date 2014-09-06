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
    

      

  
