# Ipad开发

<!-- create time: 2014-11-03 20:33:26  -->

##UIPopoverController(仅Ipad使用)
    
    直接继承自NSObject，并非继承自UIViewController
    它只占用部分屏幕空间来呈现信息，而且显示在屏幕的最前面



1. 设置内容控制器
		
    	由于UIPopoverController直接继承自NSObject，不具备可视化的能力
    	因此UIPopoverController上面的内容必须由另外一个继承自UIViewController的控制器来提供，
    	这个控制器称为“内容控制器”
    	
    	UIViewController *vc = [[UIViewController alloc]init];
    	_upc = [[UIPopoverController alloc]initWithContentViewController:vc];
    	//不要直接使用init方法创建对象，不然直接报错。
2. 设置内容的尺寸
        
        设置内容的尺寸(内容控制器)
        // By default, 
        //the width is set to 320 points and the height is set to 1100 points.
        //vc.contentSizeForViewInPopover =  CGSizeMake(100, 100); //ios 6之前
        vc.preferredContentSize = CGSizeMake(100, 100);
        
        
        设置内容的尺寸有2种方法(UIPopoverController)
        @property (nonatomic) CGSize popoverContentSize;
        
        - (void)setPopoverContentSize:(CGSize)size animated:(BOOL)animated;

        
3. 设置显示的位置

        [self.titleUpc presentPopoverFromRect:sender.bounds inView:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        [self.upc presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        
        - (void)presentPopoverFromRect:(CGRect)rect  //指向的区域
            inView:(UIView *)view     // 指向的view
            permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections  
                    //剪头的朝向   
            animated:(BOOL)animated;        //显示动画
        
        - (void)presentPopoverFromBarButtonItem:(UIBarButtonItem *)item     
            permittedArrowDirections:(UIPopoverArrowDirection)
            arrowDirections 
            animated:(BOOL)animated;
            
            
###防止点击UIPopoverController区域外消失

        
        默认情况下
        只要UIPopoverController显示在屏幕上，
        UIPopoverController背后的所有控件默认是不能跟用户进行正常交互的
        点击UIPopoverController区域外的控件，UIPopoverController默认会消失
        
        要想点击UIPopoverController区域外的控件时不让UIPopoverController消失，
        解决办法是设置passthroughViews属性
        @property (nonatomic, copy) NSArray *passthroughViews;
        这个属性是设置当UIPopoverController显示出来时，哪些控件可以继续跟用户进行正常交互。
        这样的话，点击区域外的控件就不会让UIPopoverController消失了(暂时无效)
        
  
##Ipad中的Modal

        Modal常见有4种呈现样式
        //跳转控制器
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        
        UIModalPresentationFullScreen ：全屏显示（默认）
        UIModalPresentationPageSheet
        宽度：竖屏时的宽度（768）
        高度：当前屏幕的高度（填充整个高度）
        UIModalPresentationFormSheet ：占据屏幕中间的一小块
        UIModalPresentationCurrentContext ：跟随父控制器的呈现样式
        
        
        什么叫过渡样式
        Modal出来的控制器，是以怎样的动画呈现出来
        vc.modalTransitionStyle = UIModalTransitionStylePartialCurl;
        Modal一共4种过渡样式
        UIModalTransitionStyleCoverVertical ：从底部往上钻（默认）
        UIModalTransitionStyleFlipHorizontal ：三维翻转
        UIModalTransitionStyleCrossDissolve ：淡入淡出
        UIModalTransitionStylePartialCurl ：翻页（只显示部分，使用前提：呈现样式必须是    
        UIModalPresentationFullScreen）