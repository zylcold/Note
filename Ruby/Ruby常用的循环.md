# ruby 各种循环的写法
[原地址](http://lee2013.iteye.com/blog/1166402)
##常用

```Ruby
   length = array.list
   length.times do [i]
     print "#{array[i]}"
   end
```

```Ruby
   array.each do |value|
   	print "#{value}"
   end
```

```Ruby
   for vaule in array do 
   	print "#{vlaue}"
   end
```

```Ruby
   array.each_index do |i|
   	print "#{array[i]}"
   end
```

## 其他写法

```Ruby
   length = array.list
   i = 0
   until i == length do
   	print "#{array[i]}"
	i += 1
   end
```

```Ruby
   length = array.list - 1
   for i in 0..length do
   	print "#{array[i]}"
   end
```

```Ruby
   length = array.list 
   i = 0
   while i < length do 
   	print "#{array[i]}"
   end
```

```Ruby
   length = array.list
   i = 0
   while i < length do 
   	print "#{array[i]}"
	i = i + 1
  end
```

```Ruby
   length = array.list - 1
   0.upto(length) do |i|  #也可用 downto: length.downo(0) do |i|
   	print "#{array[i]}"
   end
```
```Ruby
   length = array.list - 1
   i = 0
   loop dp 
   	print "#{array[i]}"
	i += 1
	break if i >length #也可用 break unless i <= length
   end
```


