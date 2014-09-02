# Ruby中gets和gets.chomp()的区别 

gets 获取键盘的输入

gets和gets.chomp()都表示读入用户的输入并用于输出，但两者还是有所不同，

其中gets是得到的内容后，在输出时后面接着换行；

而gets.chmop()得到的内容输出时后面不带空格和换行。


e.g. 

Ruby：
    
    > zhu ＝ gets
    12
    ==> "12/n"
    
    > zhu = gets.chomp()
    12
    ==> "12"
    