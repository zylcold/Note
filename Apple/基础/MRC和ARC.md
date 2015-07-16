####MRC和ARC混编
	
	使用了ARC之后如果你想复用以前写过的使用MRC的类, 方法比较简单， 只需要做下面的一个步骤就可以解决：

	在targets的build phases选项下Compile Sources下选择要不使用arc编译的文件，双击它，输入 -fno-objc-arc 即可

 
	MRC工程中也可以使用ARC的类。方法如下：

	在targets的build phases选项下Compile Sources下选择要使用arc编译的文件，双击它，输入 -fobjc-arc 即可
	
	
	
	或者将文件打包成静态库放入项目中