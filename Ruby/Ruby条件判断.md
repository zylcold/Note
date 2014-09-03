# Ruby 条件判断

逻辑运算符 &&与 ||或 !非

## 语法

### if 语句

[原地址](http://blog.sina.com.cn/s/blog_5d2dc2e50100ha6n.html)


```
 if 条件 then
   语句   
 end
```

```
 if 条件1 then
   语句1
 else 条件2 then
   语句2
 end
```

### Unless 

	在条件不成立的情况下执行语句

```
  unless 条件 then
    语句
  end
```

``` 
  unless 条件 then
    语句1
  else
    语句2
  end
```

### case 语句
    case语句用在”依照某个对象状态的不同而进行不同的动作”这种”情况区分”时。
    是数值对象时，可按照数值的范围或数值本身进行判断；
    是字符串对象时，可按照正则表达式或字符串本身进行判断。
    比较基准会因对象的不同而不同方式处理
    

``` 
  case 想要比较的对象
  when 值1 then
    语句1
  when 值2 then
    语句2
  else
    语句3
  end
```


