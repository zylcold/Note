##grep
//搜索

	-e 使用扩展的正则表达式
	-o 只显示匹配内容

	例子;
	pod search LlamaKit | grep Source | grep -o '\(https.*\)' | awk '{print $0}' 
	
	https://github.com/LlamaKit/LlamaKit.git


##读取上一个管道数据
pod search LlamaKit | grep Source | grep -o '\(https.*\)' | while read filename;do open -a safari $filename; done

pod search ConciseKit  | grep -o http:.\* | read url; echo $url