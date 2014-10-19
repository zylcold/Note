# UITableView性能优化和数据更新

<!-- create time: 2014-09-30 21:07:42  -->

##性能优化的第一步，利用缓存池，减少UITablViewcell对象的创建。


objective-c:

    //数据源创建UITableViewCell方法
    -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:        
        (NSIndexPath *)indexPath
    {
     static NSString *ID = @"zhuGroup"; //static关键词在局部变量中，只创建一次
     
      //根据cell设置的ID标记在缓存池中找出相同标记的cell重复利用
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
     //cell为空时调用
     if (cell == nil) {
        NSLog(@"-----初次加载");
        
        //创建cell并添加ID标记。
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle 
            reuseIdentifier:ID];
        
        //为cell添加右侧的指示器
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //设置指示器
     }
    
     //取出模型数据
     ZhuGroup *groups = self.datas[indexPath.section]; 
     ZhuData *datas =groups.arrays[indexPath.row];
    
     //为cell设置数据
     cell.detailTextLabel.text = datas.disc;
     cell.textLabel.text = datas.icon;
     cell.imageView.image = [UIImage imageNamed:datas.icon];
    
     //返回cell对象
     return cell;
    }
    
    
##UITableView的数据更新 
    
 值得注意的是tableview的代理方法中NSIndexPath数据的创建。
 
 objective-c:
 
         NSIndexPath * index = [NSIndexPath indexPathForRow:row 
                  inSection:section];
 
 刷新局部数据
 
 objective-c:
 
     [self.tableview reloadRowsAtIndexPaths:@[index]     
                         withRowAnimation:UITableViewRowAnimationFade];
                         
     //[self.tableview reloadData]; 全部加载