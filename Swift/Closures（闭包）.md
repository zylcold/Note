# Closures（闭包）

<!-- create time: 2015-02-13 22:59:45  -->


几种常见的闭包形式:

```Swift

    func makeIncrementer(mfunc: Int->Int) -> Void {
        mfunc(100)
    }
    func mfunc(num: Int) -> Int { return num * 1; }
    makeIncrementer(mfunc) //传递函数
    makeIncrementer({(num:Int) -> Int in return num * 2}) 
    //完整闭包
    makeIncrementer{(num:Int) -> Int in return num * 3} 
    //当最后一个参数是闭包时，使用Trailing Closures(尾随闭包)
    makeIncrementer{(num:Int) -> Int in num * 4} 
    //单个语句时可省略return
    makeIncrementer{(num:Int) in num * 5} 
    //省略声明的返回值类型
    makeIncrementer{num in num * 6} // 省略参数类型
    makeIncrementer{ $0 * 7 } //通过参数位置来引用参数

```