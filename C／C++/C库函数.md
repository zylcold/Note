# C库函数

<!-- create time: 2015-02-09 02:12:40  -->

## 标准头文件的特性：幂等性，相互独立性，声明等价性

###幂等性－>使用*宏保护*实现

    
    //-><stdio.h>
    #ifndef STDIO_H_
    #define STDIO_H_
    
    //do something…    

    #endif


> 注意 assert.h 并不使用此机制，它的行为受到程序员可选择的宏名NDEBUG控制

assert.h:

    #ifdef NDEBUG
    #define	assert(e)	((void)0)
    #else
因此，
禁用断言:

    #define NDEBUG
    
    
重新启用断言:

    #undef NDEBUG

###相互独立性
####类型可能被重复定义

1. *宏保护*实现:

        #ifndef SIZE_T_
        #define SIZE_T_
        typedef usigned int size_t
        #endif
    

2. *宏的良性重定义*->一个翻译单元中包含宏的多个事例不会造成损耗(必须具有相同的记号序列) 

        #define NULL (void *)0
        
####