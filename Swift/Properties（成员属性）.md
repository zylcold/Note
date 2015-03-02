# Properties（属性）

<!-- create time: 2015-02-13 23:43:58  -->

> Properties associate values with a particular class, structure, or enumeration.

>属性将值跟特定的类、结构体或枚举关联。

包括：**存储属性（Stored Properties）和 计算属性（Computed Properties）**

> 存储属性：**只能用于类和结构体**

> 计算属性：可用于类，结构体或枚举

##Stored Properties(存储属性)
###可以在定义存储属性时指定默认值，也可以在构造器中设置或修改值，甚至是修改常量存储属性的值(未设置默认值的情况下)。
> 构造器结束后，所有的存储属性必须初始化完毕


###Lazy Stored Properties(延迟存储属性)
关键字 lazy

>只能将变量存储属性声明为lazy，因为常量存储属性在构造过程完成之前毕业要有初始值。

```Swift

    class Equilater {
        let siderLength: Double
        lazy var friend = NamedShape(name: "zylcold")
        init(sideLength: Double, name: String) {
            self.siderLength = sideLength
        }
        var perimeter: Double = 10 {
            willSet{  //属性观察器Property Observers
                println(newValue)
            }
        }
    }

```


##Computed Properties(计算属性)
计算属性不直接存储值，而是提供一个getter来获取值，一个可选的setter来间接的设置其他属性的值。

```Swift

    struct Rect {
        var x = 0
        var y = 0
        var h = 0
        var center: (Int, Int) {
            get {
                let centerX = x + h / 2
                let centerY = y + h / 2
                return (centerX, centerY)
            }
            set(newCenter) {
                x = newCenter.0 - h / 2
                y = newCenter.1 - h / 2
            }
         // 便捷setter声明
         // set {
         //    x = newValue.0 - h / 2
         //    y = newValue.1 - h / 2
         //}
        }
        //只读计算属性
       var centerReadOnly: (Int, Int) {
           let centerX = x + h / 2
           let centerY = y + h / 2
           return (centerX, centerY)
       }
    }

```

##Property Observers(属性观察器)
> willSet和didSet观察在属性初始化的过程中不会被调用。

> willSet -> newValue传入的值

>didSet -> oldValue之前的值




