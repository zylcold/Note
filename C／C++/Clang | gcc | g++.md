# Clang | gcc | g++

<!-- create time: 2015-02-15 22:16:59  -->


相关文章[g＋＋编译命令选项](http://blog.csdn.net/woshinia/article/details/11060797)


1. 输出可执行为文件
       
        g++/clang++ text.cpp 
        //使用C++标准库
        gcc/clang text.cpp -std=c++1y
        gcc/clang text.cpp -lstdc++
        
        g++/clang++ text.cpp -o text
        
        
2. 输出预编译文件

只激活预处理,这个不生成文件,你需要把它重定向到一个输出文件里 。这一步主要做了这些事情：**宏的替换，还有注释的消除，还有找到相关的库文件**。


        g++/clang++ -E test.cpp > test.i
        
3. 输出编译指令

        g++/clang++ -S test.cpp
        //会生成Test.s文件，.s文件表示是汇编文件