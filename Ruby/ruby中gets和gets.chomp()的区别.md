# Ruby中gets,gets.chomp,gets.chop的区别 

gets 获取键盘的输入

gets和gets.chomp都表示读入用户的输入并用于输出，但两者还是有所不同，

其中gets是得到的内容后，在输出时后面接着换行；

而gets.chmop得到的内容输出时后面不带空格和换行。

gets.chop 去掉字符串末尾的最后一个字符,不管是\n\r还是普通字符

e.g. 

Ruby：
    
    > zhu ＝ gets
    12
    ==> "12/n"
    
    > zhu = gets.chomp
    12
    ==> "12"
    
    > zhu = gets.chomp("\n")
    \nihaoni
    ==> "\nnihaoni"
    
    > "nihaoni".chomp("ni")
    ==> "nihao"