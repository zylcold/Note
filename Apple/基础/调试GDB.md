##GDB 非图形调试器

####GDB之x命令

	可以使用examine命令(简写是x)来查看内存地址中的值。x命令的语法如下所示：

	x/<n/f/u> <addr>
	n、f、u是可选的参数
	
	n是一个正整数，表示需要显示的内存单元的个数，也就是说从当前地址向后显示几个内存单元的内容，一个内存单元的大小由后面的u定义。
	f 表示显示的格式，参见下面。如果地址所指的是字符串，那么格式可以是s，如果地十是指令地址，那么格式可以是i。
	u 表示从当前地址往后请求的字节数，如果不指定的话，GDB默认是4个bytes。u参数可以用下面的字符来代替，b表示单字节，h表示双字节，w表示四字 节，g表示八字节。当我们指定了字节长度后，GDB会从指内存定的内存地址开始，读写指定字节，并把其当作一个值取出来。
    　　<addr>表示一个内存地址。
	　　注意：严格区分n和u的关系，n表示单元个数，u表示每个单元的大小。
	
	    n/f/u三个参数可以一起使用。例如：
    　　命令：x/3uh 0x54320 表示，从内存地址0x54320读取内容，h表示以双字节为一个单位，3表示输出三个单位，u表示按无符号十进制显示。
	
	(gdb) help x
	Examine memory: x/FMT ADDRESS.

	ADDRESS is an expression for the memory address to examine.

	FMT is a repeat count followed by a format letter and a size letter.

	Format letters are o(octal八进制), x(hex), d(decimal小数), u(unsigned decimal),

	t(binary二进制), f(float), a(address地址), i(instruction指令), c(char) and s(string).

	Size letters are b(byte), h(halfword), w(word), g(giant, 8 bytes).

	The specified number of objects of the specified size are printed

	according to the format.
	
####GDB常用命令

[GDB十分钟教程](http://blog.csdn.net/liigo/article/details/582231)

	si 执行一行汇编代码
	s 执行一行源程序代码，如果此行代码中有函数调用，则进入该函数；
	n: 执行一行源程序代码，此行代码中的函数调用也一并执行。
	p <变量名称>	Print的简写，显示指定变量（临时变量或全局变量）的值。
	r	Run的简写，运行被调试的程序。
	c	Continue的简写，继续执行被调试程序，直至下一个断点或程序结束。
	
	list ：显示程序中的代码，常用使用格式有
		list　　输出从上次调用list命令开始往后的10行程序代码。
		list -  输出从上次调用list命令开始往前的10行程序代码。
		list n　输出第n行附近的10行程序代码。
		list function 输出函数function前后的10行程序代码。