##Ruby

###Ruby注释

	＃这是注释

	＝begin
	＝这是注释
	＝end

###Ruby 数据类型

	Ruby支持的数据类型包括基本的Number、String、Ranges、Symbols，以及true、false和nil这几个特殊值，
	同时还有两种重要的数据结构——Array和Hash


####数值类型(Number)

1. 整型（Integer）：Fixnum(四字节), Bignum(八字节)

		123   					#Fixnum 十进制
		1_23 					#Fixnum 十进制
		0377 					#Fixnum 八进制
		0xff   					#Fixnum 十六进制
		0b1011  					#Fixnum 二进制
		?a						#Fixnum 'a'的字符编码
		?\n						#Fixnum 换行符(0x0a)的编码
		12345678901234567890    #Bignum

2. 浮点类型（Float）

		123.4                       # 浮点值
		1.0e6                      # 科学记数法
		4E20                       # 不是必需的
		4e+20                     # 指数前的符号

3. 字符串类型（String）八字节序列

	
	转义
	puts   ' Hello "\\" '  => Hello \
	
	使用序列 #{ expr } 替换任意 Ruby 表达式的值为一个字符串

	puts "Value : #{24*60*60}"; => "Value : 86400"

####数组（Array）任意类型

	
	ary = [ "Hello", 12, "World" ];
	ary.each do |i|
		puts i
	end

####哈希类型（Hash）任意类型

	
	hsh = { "Red" => 0xf00, "Green" => 0x0f0 }
	hsh.each do |key, value|
		puts key, " is ", value, "\n"
	end

####范围类型（Ranges）表示一个区间

	范围可使用 s..e 和 s...e 来构造，或者通过 Range.new 来构造
	使用 .. 构造的范围从开始值运行到结束值（包含结束值）。
	使用 ... 构造的范围从开始值运行到结束值（不包含结束值）。

	(1..5)    => 1, 2, 3, 4, 5
	(1...5)   => 1, 2, 3, 4

###类对象

	
	#声明类

	class Customer					 #类
	
		@@no_of_customers = 0    	  #类变量

		def	initialize(id, name, addr)   #初始化方法
			@cust_id = id                	 #成员变量
			@cust_name = name    
			@cust_addr = addr
		end

		def sayHello()                               #成员函数
			puts "Hello Ruby, #{@cust_id}"
		end

	end


	#创建对象

	cust1 =  Customer.new("1", "Zylcold", "Hello")
	
	#调用方法

	cust1.sayHello()


###变量

####全局变量

	全局变量以 $ 开头。未初始化的全局变量的值为 nil

	$global_variable = 10

	class Class1
		def print_global
			puts "Global is #$global_variable"
		end
	end

	在 Ruby 中，您可以通过在变量或常量前面放置 # 字符，来访问任何变量或常量的值

####实例变量

	实例变量以 @ 开头。未初始化的实例变量的值为 nil

####类变量

	类变量以 @@ 开头，且必须初始化后才能在方法定义中使用。
	引用一个未初始化的类变量会产生错误。
	类变量在定义它的类或模块的子类或子模块中可共享使用。

####局部变量

	局部变量以小写字母或下划线 _ 开头。
	局部变量的作用域从 class、module、def 或 do 到相对应的结尾或者从左大括号到右大括号 {}。

	当调用一个未初始化的局部变量时，它被解释为调用一个不带参数的方法。

####常量

	常量以大写字母开头。定义在类或模块内的常量可以从类或模块的内部访问，定义在类或模块外的常量可以被全局访问。

	常量不能定义在方法内。引用一个未初始化的常量会产生错误。对已经初始化的常量赋值会产生警告。

	class Example
		VAR1 = 100
		def show()
			puts "Value is #{VAR1}"
		end
	end

####伪变量

	特殊的变量，有着局部变量的外观，但行为却像常量。
	不能给这些变量赋任何值。

	self: 当前方法的接收器对象
	true，false: boolean值
	nil: 代表 undefined 的值
	__FILE__: 当前源文件的名称
	__LINE__: 当前行在源文件中的编号

###运算符
####算术运算符 
		
	+加	-减	*乘	/除	%求模	**指数

####比较运算符 a= 10, b = 20

运算符    | 描述    | 事例
------------|----------|-------
==| 等于  | a == b => false
!= | 不等于| a != b => true
> | 大于 | a > b  => false
< | 小于 | a < b => true
>=|大于等于|a >= b => false
<=|小于等于| a <= b => true
<=> | 联合比较运算符, a大返回1，相等返回0，b大返回-1 | a <=> b => -1
=== |用于测试 case 语句的 when 子句内的相等|(1...10) === 5 返回 true。
.eql? | 如果接收器和参数具有相同的类型和相等的值,则返回 true |1 == 1.0 返回 true，但是 1.eql?(1.0) 返回 false。
.equal? | 如果接收器和参数具有相同的对象 id，则返回 true。|如果 aObj 是 bObj 的副本，那么 aObj == bObj 返回 true，a.equal?bObj 返回 false，但是 a.equal?aObj 返回 true。

####赋值运算符

####并行赋值

	Ruby 也支持变量的并行赋值。这使得多个变量可以通过一行的 Ruby 代码进行初始化。

	a, b, c = 10, 20, 30
	a, b = b, c

####位运算符

	&按位与 |按位或 ^按位异或 ~按位取反 <<左移运算符 >>右移运算符

####逻辑运算符

	and 	逻辑与运算符
	&& 		逻辑与运算符
	or 		逻辑或运算符
	||		逻辑或运算符
	not 		逻辑非运算符
	! 		逻辑非运算符

####三元运算符

	?: 条件表达式

####范围运算符

	..   
	...

####defined? 运算符

	defined? 是一个特殊的运算符，以方法调用的形式来判断传递的表达式是否已定义。
	它返回表达式的描述字符串，如果表达式未定义则返回 nil。
	
	1. 用于变量
	defined? variable # 如果 variable 已经初始化，则为 True
	
	foo = 43
	defined? foo    =>  "local-variable"
	defined? $_     # => "global-variable"
	defined? bar    # => nil（未定义）

	2. 用于方法
	
	defined? method_call # 如果方法已经定义，则为 True
	defined? puts        # => "method"
	defined? puts(bar)   # => nil（在这里 bar 未定义）
	defined? unpack      # => nil（在这里未定义）

	defined? super   # 如果存在可被 super 用户调用的方法，则为 True
	defined? super     # => "super"（如果可被调用）
	defined? super     # => nil（如果不可被调用）
	
	3. 用于yield	
	
	defined? yield   # 如果已传递代码块，则为 True
	defined? yield    # => "yield"（如果已传递块）
	defined? yield    # => nil（如果未传递块）

####点运算符 "." 和双冒号运算符 "::"

	可以通过在方法名称前加上模块名称和一条下划线来调用模块方法。	可以使用模块名称和两个冒号来引用一个常量。
	:: 是一元运算符，允许在类或模块内定义常量、实例方法和类方法，可以从类或模块外的任何地方进行访问。
	在 Ruby 中，类和方法也可以被当作常量。
	只需要在表达式的常量名前加上 :: 前缀，即可返回适当的类或模块对象。
	如果未使用前缀表达式，则默认使用主 Object 类。

	MR_COUNT = 0        # 定义在主 Object 类上的常量
	module Foo
		  MR_COUNT = 0
		  ::MR_COUNT = 1    # 设置全局计数为 1
		  MR_COUNT = 2      # 设置局部计数为 2
	end
	puts MR_COUNT       # 这是全局常量
	puts Foo::MR_COUNT  # 这是 "Foo" 的局部常量 

