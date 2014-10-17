# UICollectionView|Controller

<!-- create time: 2014-10-16 19:50:09  -->

    UICollectionView 和 UICollectionViewController 类是iOS6 新引进的API，
    用于展示集合视图，布局更加灵活，可实现多列布局，
    用法类似于UITableView 和 UITableViewController 类。
    
    使用UICollectionView 必须实现    
    UICollectionViewDataSource, //数据源方法
    UICollectionViewDelegate, //代理方法
    UICollectionViewDelegateFlowLayout //管理view里面的item
    这三个协议。
    
    
 [关于UICollectionViewLayout介绍](http://blog.csdn.net/majiakun1/article/details/17204921)
 
 [UICollectionView详解](http://blog.csdn.net/majiakun1/article/details/17204693)
    
###步骤1.注册cell(告诉collectionView将来创建怎样的cell)
    通常在初始化操作中进行
  objective-c:
    
    //通过代码创建UICollectionViewCell时，使用
    [self.collectionView registerClass:
      [UICollectionViewCell class] forCellWithReuseIdentifier:@"product"];
    //通过Xib创建时，使用 
    //标记通过xib绑定
    [self.collectionView registerNib:nib     
      forCellWithReuseIdentifier:reuseIdentifier];
      
      
      
      
###步骤2.从缓存池中取出cell
    如果缓存池中不存在，则根据注册的cell，进行创建。
    
   objective-c:
   
       - (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
    {
	    UICollectionViewCell *cell = [collectionView     
	        dequeueReusableCellWithReuseIdentifier:@"product"         
	                    forIndexPath:indexPath];

        return cell;
    }
    
    
###步骤3.创建布局参数UICollectionViewFlowLayout
    UICollectionView 必须使用UICollectionViewFlowLayout创建的对象才能设置item的参数
    
    一般或通过UICollectionView／UICollectionViewController的    
        initWithCollectionViewLayout方法传入布局对象，或者重写init方法传入。
        
 objective-c:
     
     //重写init方法
     
     - (id)init
    {
        // 1.流水布局
        // 官方提供了一些常用的布局类
        	UICollectionViewFlowLayout *layout =
        	         [[UICollectionViewFlowLayout alloc] init];
        // 2.每个cell的尺寸
    	    layout.itemSize = CGSizeMake(100, 100);
           return [super initWithCollectionViewLayout:layout];
    }