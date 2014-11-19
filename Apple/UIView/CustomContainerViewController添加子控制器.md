# CustomContainerViewController添加子控制器

<!-- create time: 2014-11-13 19:34:50  -->
    在iOS 5之前苹果是不允许出现自定义的Container的 ，也就是说你创建的一个View Controller的view不能包含另一个View Controller的view。

具体[Cocoa China 的 Custom Container View Controller](http://www.cocoachina.com/industry/20140523/8528.html)

##代码创建

添加一个子控制器

objetive-c:

    - (void)viewDidLoad {
        [super viewDidLoad];
        //在父控制器创建一个容器UIview
        UIView *myView = [[UIView alloc]initWithFrame:CGRectMake(50, 50, 100, 100)];
        //添加容器view到控制器view
        [self.view addSubview:myView];
        //创建自控制器
        ContentViewController *cvc = [[ContentViewController alloc]init];
        //将cvc添加为自控制器
        [self addChildViewController:cvc];
        //设置自控制器view的frame
        cvc.view.frame = myView.frame;
        //将自控制器view添加为容器view的子控件
        //建立父子关系后，便是将cvc的view加入到父VC的view hierarchy上，同时要决定的是 content的view显示的区域范围
        [myView addSubview:cvc.view];
        //调用cvc的didMoveToParentViewController: ，以通知cvc，完成了父子关系的建立
        [cvc didMoveToParentViewController:self];
    }


移除一个子控制器

objetive-c:

    
    - (void)removeChildController {
        //将子控制器父控制器设置为nil
        [self.cvc willMoveToParentViewController:nil];
        //将自控制器的view移除
        [self.cvc.view removeFromSuperview];
        //通过removeFromParentViewController的调用真正的解除关系，
        //removeFromParentViewController会自动调用 [content 
        // didMoveToParentViewController:nil]
        [self.cvc removeFromParentViewController];
    }


##storybrard

     直接拖出Container View 到父控制器即可
