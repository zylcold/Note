# 创建XIb

<!-- create time: 2014-11-13 16:57:21  -->

##控制器关联XIb

> 无须手动加载view的xib。xib的名字默认与控制器名一致
> 在xib中的file's owner 中将Custom Class 设置为当前控制器
> 并选中右键将file's owner的outlets 的view 设置为要显示的view
> 
> 注意 viewDidLoad方法，会在xib加载完成后执行
> xib加载，一定会调用(id)initWithCoder:(NSCoder *)aDecoder 方法，


##设置view关联Xib

    id view = [[[UINib nibWithNibName:@"demo" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    可以读取demo.xib中最后一个控件
    xib加载，不会调用- (instancetype)initWithFrame:(CGRect)frame 方法
