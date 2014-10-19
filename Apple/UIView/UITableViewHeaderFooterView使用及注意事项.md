# UITableViewHeaderFooterView使用及注意事项

<!-- create time: 2014-10-09 23:54:31  -->

##自定义UITableViewHeaderFooterView目前只能通过代码创建，storyboard暂时未提供相应的控件

HeaderFooterView创建于自定义cell的创建类似。

1. 首先通过tableview dequeueReusableCellWithIdentifier 方法在缓存池找对象标记能重用控件
2. 如果缓存池不存在，在进行创建。
3. 在重写的initWithReuseIdentifier:(NSString *)reuseIdentifier 方法中，添加控件。
4. 在layoutSubviews(控件加载完成时调用)中设置控件的frame
5. 在模型的set方法中，对HeaderFooterView内的每个控件设置数据。


##注意事项
1. HeaderFooterView和cell类似，将添加的控件添加到contentView上
2. 关于空间的重用问题，一定要注意空间重用时，保证每个空间数据和```属性```完全覆盖
3. 获取HeaderFooterView空间的frame一定要在layoutSubviews之后，不能在initWith...之中
4. 每当tableview 调用reloadData 方法，tableview将不会再缓存池中取出重用的组件，将重新创建，
因此，如果想在reloadData之后，在修改HeaderFooterView内的控件属性，应该在didMoveToSuperview（当组件添加到父控件时，调用）中进行设置。
