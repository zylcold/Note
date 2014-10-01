# UITableView基础使用

<!-- create time: 2014-09-29 21:49:57  -->

## 控制器中增加UITableViewDataSource协议

## UITableView对象委托给控制器对象

    self.tableView.dataSource = self;
    
## 重写数据源协议中的部分方法。

#几个常用的协议方法

* -(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView; 
 ```设置分组。返回值。```

* -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
```设置每组的行数row。返回值。```
```section 第几组```

* -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
```设置每个UITableViewCell 的数据```
```indexPath （包含section,row属性)```

* -(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
```设置每组中的头部显示信息。```
* -(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
```设置每组尾部的显示的信息```



## UITableViewCell 常用的方法和属性
初始化UITableViewCell

objective-c:

    UITableViewCell *cell = [[UITableViewCell     
        alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];

    //UITableViewCellStyleSubtitle 显示两行label ,上下两行 cell.textLabel为主
    //UITableViewCellStyleDefault 显示一行label cell.textLabel这行
    //UITableViewCellStyleValue1 显示两行label, 并排两行，cell.textLabel为主
    //UITableViewCellStyleValue2显示两行label,无imageView并排两行，cell.textLabel为主
    
    
    
    
    
##其他知识

有关快速将Dictionary数据转换到自定义模型中

［self setValuesForKeysWithDictionary:dic］;

* 注意使用此方法，字典中的每个key在数据模型中都必须有相同的对应才行。