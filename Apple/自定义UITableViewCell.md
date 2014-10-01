# 自定义UITableViewCell

<!-- create time: 2014-10-01 20:44:48  -->
#通过Xib文件创建自定义的TableviewCell


##通过xib描述一个tableviewcell
    
     在xib中Table View Cell属性里设置identifier 
     e.g “tableviewcell”，方便在缓存池寻找
     
##继承UITableViewCell类来编写自定义的cell类 ->zhuTableViewCell

    将xib文件中的custom class 指定为自定类。
    
> ```在自定义类中完成创建cell和设置cell的数据。```
    
 objective-c:
 
     +(instancetype)zhuTableViewCellWithTableView:(UITableView *)tableview
    {   
        ZTableViewCell *cell = [tableview 
            dequeueReusableCellWithIdentifier:@"tableviewcell"];
        if (cell == nil) {
            //通过UINib 找到资源文件夹中的自定义xib bundle参数nil代表mainbundle
            UINib *nib = [UINib nibWithNibName:@"ZTableViewCell" bundle:nil];
            cell = [[nib instantiateWithOwner:nil options:nil]lastObject];
        }
        return cell;
    }

设置控件的数据，通过创建的外部方法获取控制器传入的模型数据，将模型数据设置在各个控件上。
##在控制器中通过ZhuCell创建cell


objective-c:

    -(UITableViewCell *)tableView:(UITableView *)tableView 
            cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        ZTableViewCell *cell = [ZTableViewCell     
            zTableViewCellWithTableView:self.tableview];
        [cell setDataModel:self.datas[indexPath.row]];
        return cell;
    }
