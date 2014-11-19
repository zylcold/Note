# UIStoryBoardSegue

<!-- create time: 2014-11-14 19:38:20  -->

类型:

    1. push segue //仅用于来源控制器是导航控制器的情况
    2. modal segue  //phone 仅支持Full Screen一种显示模式，多种过场动画（Partial Curl有问题）
    3. embed segue  //指向嵌入的Controller
    4. unwind segue  //设置返回segue，在要返回控制器的Exit中设置
    5. costom segue  //自定义segue
    6. popover segue //Ipad 模式 弹框控制器
    7. replace segue //Ipad 模式 切换Split Controller 的detail View controller


###自动执行
StoryBoard中，控件->控制器

    自动执行segue操作

###手动执行
StoryBoard中，控制器->控制器, 设置segue的identifier, e.g "target to source"

    控制器对象执行此方法
    [self performSegueWithIdentifier:@"target to source" 
                              sender:btn];
    //swift :
    self.performSegueWithIdentifier("target to source", sender: btn)

###segue执行前都会先调用

    执行前会在来源控制器调用以下方法进行准备操作
    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender；
    //swift:func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?);
    
    
    
###unwind segue

详细
[月未央 的 iOS Storyboard unwind segues使用小结](http://blog.csdn.net/kid_devil/article/details/23218195)

    1. 在来源控制器设置unwind segue
        
         声明一个IBAction接口:
         - (IBAction)back:(UIStoryboardSegue *)segue { }
         //swift: @IBAction func back(segue:UIStoryboardSegue) { }
         //这个方法的返回值必须是ibaction，参数必须是uistoryboardsegue。
    2. 在storyboard关联来源控制器
        在来源控制器的Exit中右键即可找到之前设置的方法，将方法与目标控制器的控件／控制器相连即可
    3. 当目标控制器返回时，会调用来源控制器中的上面设置的方法
    
> unwind segue可设置与来源控制器不相邻的控制器，执行unwind segue可直接弹回来源控制器
> 
> 但可执行unwind的目标控制器一定是来自来源控制器

    
