# self-sizing --不用计算Cell高度的TableView实现方案

<!-- create time: 2014-11-20 21:31:12  -->

转自[伯竹的IOS8 不用计算Cell高度的TableView实现方案](http://my.oschina.net/u/1418722/blog/322623)

    利用IOS8的新特性“self-sizing”，可以实现自动调整Cell高度的TableView。再也不用手动计算Cell高度了。这个新特性，意味着View被Autolayout调整frame后，会自动拉伸和收缩SupView。


    重点:具体到Cell,要求cell.contentView的四条边都与内部元素有约束关系。

    
    在TableViewController里

    - (void)viewDidLoad {
        [super viewDidLoad];
        //添加这两行代码
        self.tableView.estimatedRowHeight = 44.0f;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }

    搞定，不用实现任何计算Cell高度的方法，已经好了。
