OperatorTable addAssignOperator(":", "atPutNumber") #一个运算符添加到Io赋值运算符表中。只要Io代码中遇到“:” ,都讲转化为atPutNumber。这样key : value将将转化为atPutNumber("key", value).
	
curlyBrackets := method(                #Io代码遇到大括号({})，转换程序就会自动调用此方法。  Io定义的方法。
	r := Map clone						#创建一个空映射
	call message arguments foreach(arg,    #call message－>message used to call this method/block 赋值给arguments ，arguments调用 foreach 分解每段代码为arg 
		r doMessage(arg) 					# r doMessage(arg) <==> r xxxx : 123566 <==> r atPutNumber("xxxxx", 123566)
	)
	r
 )


Map atPutNumber := method(                 #此方法为将 key : value 转化为 atPutNumber("key", value). 原数据为 "xxxx" : "123456789"  >目的去除"123456789"原数据上的引号("")
	self atPut(
		call evalArgAt(0) asMutable removePrefix("\"") removeSuffix ("\""),     #不懂。。。。 
		call evalArgAt(1)
	)
)

s := File with("phonebook.txt") openForReading contents   #with指定文件名并返回一个文件对象。 openForReading 打开该文件并返回这个文件对象。contents返回该文件内容。
phoneNumbers := doString(s)                                 #doString 是将内容读取为 Io代码，并执行。
phoneNumbers keys println
phoneNumbers values println