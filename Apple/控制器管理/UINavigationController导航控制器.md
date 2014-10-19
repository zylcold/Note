# UINavigationController导航控制器

<!-- create time: 2014-10-17 15:10:53  -->

##设置主题

    通过设置主题，可以改变整个nav导航栏的样式。
    
  * 由于主题设置只进行一次，且与导航器对象操作无关，建议放到类的初始化方法中进行。
  
      objective-c:
      
        + (void)initialize{  //当类创建的时候调用，只调用一次。
    
            UINavigationBar *nav = [UINavigationBar appearance];  
                //获取整个应用的nav主题
            [nav setBackgroundImage:[UIImage imageNamed:@"NavBar64"]     
                    forBarMetrics:UIBarMetricsDefault];
                //设置导航栏的背景
            nav.tintColor = [UIColor whiteColor]; 
                //设置导航栏左边的颜色（文字和指示器）
                
             //创建属性字典
             //常用的key值，存放在NSAttributedString.h.中
            NSMutableDictionary *arrts = [NSMutableDictionary dictionary];
            arrts[NSForegroundColorAttributeName] = [UIColor whiteColor];
            [nav setTitleTextAttributes:arrts];
    
    
               //UINavigationItem *navItem = [UINavigationItem ] 无法创建此主题
            UIBarButtonItem *item = [UIBarButtonItem appearance];
                // [item setTitle:@"返回"]; 报告nil异常
                
            //同上
            NSMutableDictionary *arrtsItem = [NSMutableDictionary dictionary];
            arrtsItem[NSFontAttributeName] = [UIFont systemFontOfSize:14];
            [item setTitleTextAttributes:arrtsItem forState:UIControlStateNormal];
        }
     
     
     
     
##统一处理跳转的控制器

    对于跳转后的控制器是否要显示底部的bar，跳转后的返回按钮的文字，是否显示跳转动画。建议在重写的导航控制器条状方法中添加，修改。
    
   objective-c:
       
        //在此方法中可以获得跳转控制器，通过self.visibleViewController可以获得当前控制器
       -(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
    {
        //目标控制器是否隐藏底部的bar
        viewController.hidesBottomBarWhenPushed = YES;
        
        //创建item，并添加到backButtionItem中
        //self.visibleViewController.
        //        navigationItem.backBarButtonItem.title = @"返回"; 无效
        UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
        [item setTitle:@"返回"];
        [self.visibleViewController.navigationItem setBackBarButtonItem:item];
    
        //必须调用父类的方法，否则不会条状
        [super pushViewController:viewController animated:animated];
    
    }