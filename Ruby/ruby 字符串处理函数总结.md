#ruby 字符串处理函数总结

[原地址新浪博客](http://blog.sina.com.cn/s/blog_8184e03301013iqj.html)

1. 返回字符串的长度

    str.length => integer
    
2. 判断字符串中是否包含另一个串（区分大小写）
    ```Ruby
    str.include? other_str => true or false
    ```
    
    e.g:
    
        >"nihao".include? "ni"
        ==> true
        >"nihao".include? ?ni
        ==> true
       
3. 字符串插入

 
   ```Ruby
    str.insert(index, other_str)=> str
    ```
   
   e.g:
   
       > "nihao".insert(0,"H")
       ==> "Hnihao"
       > "nihao".insert(-1."H")
       ==> "nihaoH"
       
4. 字符串分隔,默认分隔符为空格

    ```Ruby
       str.split(pattern=$;, [limit]) => anArray
    ```
    
    e.g:
    
        > "hello world".split
        ==>[ "hello" , "world" ]
        > "hello world".split("llo")
        ==> ["he"," world"]
        
5. 字符串替换

    ```Ruby
        str.gsub(pattern, replacement)=> new_str
    ```
    ```Ruby
        str.gsub(pattern) {|match| block }
    ```
    ```Ruby
        str.replace(other_str)=> str
    ```

    e.g:

        > "hello".gsub(/[aeiou]/, '*')
        ==> "h*ll*"   //将元音字符替换成‘x’
        > "hello".gsub(/./) {|s| s[0].to_s + ' '}
        ==> "104 101 108 108 111 " 
        > "hello".replace("nihao")
        ==> "nihao"
    
6. 字符串删除

     ```Ruby
     str.delete([other_str]+) => new_str
     ```
 
     e.g:
 
         > "hello".delete "l","lo"
         ==> "heo"
         > "hello".delete "lo"
         ==> "he"
         > "hello".delete "hello" , "^e"
         ==> "e"
         > "azbcde".delete "a-d"
         ==> "ze"
     
7. 去除前后的空格

    ```Ruby
    str.lstrip => new_str
    ```
    
    e.g:
    
        > " hello    ".lstrip
        ==> "hello"
8. 字符串匹配

    ```Ruby
    str.match(pattern)=> matchdata or nil
    ```
    
    e.g:
        
        > "hello".match("he")
        ==> #<MatchData "he">
        > "hello".match("hellon")
        ==>nil
        
9. 字符反转

    ```Ruby
    str.reverse => new_str
    ```
    
    e.g:
        
        > "hello".reverse            
        ==> "olleh"
        
10. 去掉重复的字符

    ```Ruby
    str.squeeze([other_str]*) => new_str
    ```
    
    e.g:
    
        > "hahaha".squeeze
        ==> "hahaha"    
        > "hahhhha".squeeze
        ==> "haha"   #默认去除重复字符
        > "hello  world".squeeze(" ")
        ==> "hello world" #去除重复空格
        > "aaaabbbbcccdddddeee".squeeze("a-d")
        ==> "abcdeee" #去除指定范围的重复字符
        
11. 转化成数字

    ```Ruby
    str.to_i=> str 
    ```
    
    
        