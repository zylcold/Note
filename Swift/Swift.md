# Swift

<!-- create time: 2014-12-19 15:05:36  -->

    Swift是一种适用于iOS和OS X应用的全新编程语言,
    它建立在最好的C和Objective-C 语言之上,并且没有 C 语言的兼容性限制。
    Swift 采用安全的编程模式,增加了现代功能使编程更容易、更灵活、更有趣。

##Swift 中与Objective-C 对应的操作

### #pragma mark 可以 通过 //MARK: 或 //TODO 或 //FIXME 替代使用

##常量变量(Constants and Variables)
    
####常量 
    
    e.g: 
    let num = 5
####变量
    
    e.g: 
    var num = 6
    num = 8 
    // num = "This is will error" -> 不能改变类型
     
     
##数据类型

####整数(Integers)

    Swift provides signed and unsigned integers in 8, 16, 32, and 64 bit forms.
    Int8 Int16 Int32 Int64
    UInt8 UInt16 UInt32 UInt64    
    
####浮点数(Floating-Point Numbers)
    
    Double 64位浮点数 默认
    Float  32位浮点数 
    或 Float32(== Float) Float64(== Double) Float80 Float96 
    
####数值型字面量(Numeric Literals)
    
    A decimal number, with no prefix 十进制数 e.g： var num = 10             -> 10
    A binary number, with a 0b prefix 二进制数 e.g：var num = 0b00000011     -> 3
    An octal number, with a 0o prefix 八进制数 e.g：var num = 0o11           -> 9
    A hexadecimal number, with a 0x prefix  十六进制 e.g var num = 0x11      -> 17

####布尔值(Booleans)

    true  真
    false  假
    
####元祖(Tuples)

    元组内的值可以使任意类型,并不要求是相 同类型。
    声明: var tuples = ("zylcold", 24)  
        // var tuples = (name: "zylcold", age: 24) 
        
    访问 tuples.0    -> zylcold
        // tuples.name    -> zylcold
    
        
    值绑定模式(Value-Binding Pattern):
    值绑定模式绑定匹配的值到一个变量或常量。当绑定匹配值给常量时,用关键字 let,绑定给变量时,用关键之 var。
    var (name, age) = tuples
    name   -> zylcold
    
    通配符模式(Wildcard Pattern):
    通配符模式匹配并忽略任何值,包含一个下划线(_)
    
    var (_, age) = tuples
    age   -> 24
    
####可选值(Optionals)

    使用可选(optionals)来处理值可能缺失的情况
    如果无值返回nil
    
    可选值绑定(Optional Binding)  
    var num: String?                    -> nil
    if let demo = num {
        println("\(demo)")
    } else {
        println("This is nil")          -> This is nil
    }
    num!  // Error!!
    
    var num2: String?                    -> nil
    num2 = "zylcold"
    if let demo = num2 {
        println("\(demo)")              -> zylcold
    } else {
        println("This is nil")      
    }
    num2!                               -> zylcold
    
####集合类型(Collection Types)

#####数组(Array)

    数组使用有序列表存储相同类型的多重数据。数据值在被存储进入􏰂个数组之前类型必须明确,方法是通过显式的类型标注或类型推断
    
######创建

    创建一个已知数组：
    var array = [12, 13, 18]
    var array2: Array<Int> = [12, 13, 18]
    var array3: [Int] = [12, 13, 18]

    创建一个空数组
    var array = []
    var array2 = Array<Int>()
    var array3 = [Int]()
    
######访问数组
    let array = [12, 17, 18, 19]
    
    array8[0]                       -> 12
    array8[0..<2]                   -> [12, 17]
    
    遍历数组(Iterating Over an Array)
    
    //遍历数组的元素
    for item in array {
        item
    }
    
    //遍历数组的元素和下标
    for (index, value) in enumerate(array) {
        println("Item \(index + 1): \(value)")
    }
    
######添加元素
    
    var array = [Int]()
    array.append(12)
    array += [11]
    array.insert(1, atIndex: 2) // 插入范围(0...(array.count + 1))
    array                        -> [12, 11, 1]
    
######修改元素

    var array = [12, 17, 18, 19]
    array[0] = 0
    array[1...4] = [1, 2, 3, 4]  //可添加元素
    array                          -> [0, 1, 2, 3, 4]
    
######删除元素

    var array = [12, 17, 18, 19]
    array.removeAtIndex(1)  //删除第一个
    array.removeLast()  //删除最后一个
    array                   -> [12, 18]
    
    
#####字典(Dictionaries)

######创建
    
    1. 创建一个已知字典
        var dict = ["name" : "zylcold", "age" : "12"]
        var dict: Dictionary<String, String> = ["name" : "zycold", "age" : "12"]
        var dict: [String, String] = ["name" : "zycold", "age" : "12"] 
    2. 创建一个空字典
        var dict = [:]
        var dict = Dictionary<String, String>()
        var dict = [String, String]()
    
######访问
    var dict = ["name" : "zylcold", "age" : "12"]
    
    dict["name"]         -> { Some "zycold" }
    
    for (key, value) in dict {
        println("\(key): \(value)")
    }
    
    for key in dict.keys {
        println("\(key)")
    }
    for value in dict.values {
        println("\(value)")
    }
    
    let keys = [String](dict.keys)
    // keys is ["name", "age"]
     
    let value = [String](dict.values)
    // value is ["zylcold", "12"]
    
######添加元素
    
    var dict = ["name" : "zylcold", "age" : "12"]
    dict["class"] = "class1"
    
######修改元素
    
    var dict = ["name" : "zylcold", "age" : "12"]
    dict["age"] = "18"
    dict.updateValue("zylold", forKey: "name")
######删除元素
    
    var dict = ["name" : "zylcold", "age" : "12"]
    dict["name"] = nil
    dict.removeValueForKey("name")
    
##控制流(Controller flow)
    
    使用 if 和 switch 来进行条件操作,使用 for-in、for、while 和 do-while 来进行循环
    
    注意⚠: 条件必须是一个布尔表达式
    
    if condition {
        statements
    }
    
    for initialization; condition; increment {
        statements
    }
    
    
    
    
    
