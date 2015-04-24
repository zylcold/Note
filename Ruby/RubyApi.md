###文字处理

	S = "Hello"
	
	操作符替代
	s.concat(" Zyl")	    => Hello Zyl #追加字符串  
		== s << " Zyl"
	s.insert(5, " Hi") 		=> Hello Hi Zyl #插入指定位置字符串
		== s[5] = "Hi"
	s.slice(0, 5) 			=>Hello #获取指定区间的字符串
		== s[0, 5]
	s.slice!(5, 6) 			=>Hi #删除指定区间的字符串
		== s[5, 6] = ""        
	s.eql?("HelloHi") 		=>false #判断字符串是否相等
		== s == "HelloHi"
	
	获取字符串长度	
	s.length  
	s.size
	s.bytesize  #Ruby 1.9 last
	s.empty?  ==> false
	
	查找和替换文本
	s = "Hello"
	
	s.index('l') ==> 2 #返回第一个匹配字符的位置
	s.index(?l)  ==> 2 #同上，匹配单个字符
	s.index(/l+/) ==> 2 #同上，使用正则表达式
	s.index('l', 3) ==> 3 #返回一个位置在3或3之后的匹配字符的位置
	s.index('Ruby') ==> nil #返回指定字符串位置
	s.rindex('l')  ==> 3 #反向查找第一个匹配字符的位置
	s.rindex('l', 2) ==> 2 #反向查找位置为2或者2之前的匹配字符的位置
	
	s.start_with? "Hell"  ==> true  
	s.end_with? "llo"  ==> true
	
	s.include?("ll") ==> true  #是否包含"ll"
	s.include?(?H)  ==> true
	
	s =~ /[aeiou]{2}/ ==> nil ＃正则表达式匹配
	s.match(/[aeiou]/) { |m| m.to_s } ==> e #正则表达式匹配，并捕获
	
	分割
	"This is it".split ==> ["This", "is", "it"] #字符串分割，默认"\n"
	"Hello".split ==> ["He", "", "o"]
	"1,  2,3".split(/,\s*/) ==> ["1", "2", "3"]  #正则表达式分割
	分组
	"banana".partition("an") ==> ["b", "an", "ana"]
	"banana".rpartition("an") ==> ["ban", "an", "a"]
	"a123b".partition(/\d+/) ==> ["a", "123", "b"]
	
	替换
	s.sub("l", "L") ==> "HeLlo"  #返回替换第一个匹配字符后的字符串
	s.gsub("l", "L") ==> "HeLLo" ＃返回替换所有匹配字符后的字符串
	s.sub!(/(.)(.)/, '\2\1') ==> "eHllo" ＃匹配并交换前两个字符
		== s.sub1(/(.)(.)/, "\\2\\1")
		
	"hello world".gsub(/\b./) {|match| match.upcase}
	
	字符串特殊处理
	s = "world"
	s.upcase => "WORLD"  ==> 返回大写字符串
	s.upcase! => "WORLD"
	s.downcase
	s.capitalize => "World" => 返回首字母大写
	s.capitalize!
	s.swapcase => "wORLD"  => 返回反向变换
	
	s.casecmp("B")  == s <=> "B"
	
	增加删除空白符
	s = "hello\r\n"
	s.chomp!  => "hello" 删除换行空格 默认删除特殊字符
	s.chomp  
	
	s.chomp("o") => "hell" 删除字符o
	
	
	
	
	