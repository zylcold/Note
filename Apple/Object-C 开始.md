# Object-C 开始

<!-- create time: 2014-09-25 23:19:38  -->

## 更改状态栏的样式
* 重写此方法

    UIStatusBarStyle 枚举类型

    Object-c:

        -(UIStatusBarStyle)preferredStatusBarStyle
        {
            return UIStatusBarStyleLightContent;
            //返回一个高亮的状态栏
        }
    
        //隐藏状态栏
        -(BOOL)prefersStatusBarHidden
        {
            return YES;
        }
    
##使用系统动画
* 第一种

    Object-c:
    
        [UIView beginAnimations:nil context:nil];//开始动画默认单次，0.2秒
        [UIView setAnimationDuration: 0.2]; // default = 0.2
                  
             //...do something...
  
        [UIView commitAnimations]; //动画终止
    
* 第二种

    Object-c:
    
        [UIView animateWithDuration:0.2 animations:^{
        
            //...do something...
            
        } completion:^(BOOL finished) {
        
            //... do something when end...
            
        }];
        
        
        //动画延时执行 动画2秒，延迟2秒执行，执行速度为匀速
        [UIView animateWithDuration:2 delay:2     
            options:UIViewAnimationOptionCurveLinear animations:^{
            
            //...do something...
        } completion:^(BOOL finished) {
            
            //... do something when end...
        }];
        
        UIViewAnimationOptionCurveLinear //线性匀速
        
        
        
##加载资源清单xxx.plist

   Object-c:
   
          NSBundle *bundle = [NSBundle mainBundle]; //获取bundle
          NSString *path = 
              [bundle pathForResource:@"appList.plist" ofType:nil];
          //获取资源文件全路径 
          //pathForResource:@"appList" ofType:@“plist”   
          NSArray * array = [NSArray arrayWithContentsOfFile:path];
          //将资源清单转化为数组对象   
          
          ==
          
          NSArray * array = [NSArray arrayWithContentsOfFile:
              [[NSBundle mainBundle] pathForResource:@"appList.plist" ofType:nil];
          ]    
          