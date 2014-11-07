# AutoLayout|SizeClass

<!-- create time: 2014-11-06 14:58:05  -->

##AutoLayout

> ⚠注意 使用前一定确保autoresize属性已经关闭。

> 在代码中可以调用要设置view的translatesAutoresizingMaskIntoConstraints属性设置为NO关闭


##简介

    Autolayout是一种“自动布局”技术，专门用来布局UI界面的
    Autolayout自iOS 6开始引入
    自iOS 7（Xcode 5）开始，Autolayout的开发效率得到很大的提升
    Autolayout能很轻松地解决屏幕适配的问题
    
    Autolayout的2个核心概念
    参照
    约束    
    
    核心计算公式
    目标的某个属性值 ＝ 参照物的属性值 * 乘积系数 ＋ 额外的值
    obj1.property1 =（obj2.property2 * multiplier）+ constant value
    
    
##使用
    
  1. 创建一个约束
  
        +(id)constraintWithItem:(id)view1    //要设置的view
            attribute:(NSLayoutAttribute)attr1   //约束的类型
            relatedBy:(NSLayoutRelation)relation  //与后面属性的关系（大于/等于/小于）
            toItem:(id)view2         //参照的view
            attribute:(NSLayoutAttribute)attr2  //约束的类型
            multiplier:(CGFloat)multiplier    // 乘积系数
            constant:(CGFloat)c;        //额外的值
            
              
 2. 添加约束
 
        原则：
        约束只涉及自身,无其他参照物参与，将约束添加到自身
        
        对于两个同层级view之间的约束关系，添加到它们的父view上
        对于两个不同层级view之间的约束关系，添加到他们最近的共同父view上
        对于有层次关系的两个view之间的约束关系，添加到层次较高的父view上
        
        
###一些约束类型

        NSLayoutAttributeLeft = 1,      //左边
        NSLayoutAttributeRight,        //右边
        NSLayoutAttributeTop,          //顶部
        NSLayoutAttributeBottom,       //底部
        NSLayoutAttributeLeading,      //首部
        NSLayoutAttributeTrailing,     //尾部
        NSLayoutAttributeWidth,        //宽度
        NSLayoutAttributeHeight,        //高度
        NSLayoutAttributeCenterX,       //中心X轴
        NSLayoutAttributeCenterY,       //中心Y轴
        NSLayoutAttributeBaseline,      //文本底标线
        NSLayoutAttributeLastBaseline = NSLayoutAttributeBaseline,
        NSLayoutAttributeFirstBaseline NS_ENUM_AVAILABLE_IOS(8_0),
        
        
        NSLayoutAttributeLeftMargin NS_ENUM_AVAILABLE_IOS(8_0),
        NSLayoutAttributeRightMargin NS_ENUM_AVAILABLE_IOS(8_0),
        NSLayoutAttributeTopMargin NS_ENUM_AVAILABLE_IOS(8_0),
        NSLayoutAttributeBottomMargin NS_ENUM_AVAILABLE_IOS(8_0),
        NSLayoutAttributeLeadingMargin NS_ENUM_AVAILABLE_IOS(8_0),
        NSLayoutAttributeTrailingMargin NS_ENUM_AVAILABLE_IOS(8_0),
        NSLayoutAttributeCenterXWithinMargins NS_ENUM_AVAILABLE_IOS(8_0),
        NSLayoutAttributeCenterYWithinMargins NS_ENUM_AVAILABLE_IOS(8_0),
        
        NSLayoutAttributeNotAnAttribute = 0   //没有属性
        
        在iOS 8中，可以使用layoutMargins去定义view之间的间距,
        该属性只对AutoLayout布局生效。
        通过测试打印，发现UIView默认的layoutMargins的值为 {8, 8, 8, 8}，
        我们可以通过修改这个值来改变View之间的距离。
        
        在我们改变View的layoutMargins这个属性时，
        会触发- (void)layoutMarginsDidChange这个方法。
        我们在自己的View里面可以重写这个方法来捕获layoutMargins的变化
        
        
        
##VFL(Visual format language)

 1. 创建约束
 
         + (NSArray *)constraintsWithVisualFormat:(NSString *)format   //VFL语句
             options:(NSLayoutFormatOptions)opts   //约束类型
             metrics:(NSDictionary *)metrics   //VFL语句中用到的具体数值
             views:(NSDictionary *)views;   //VFL语句中用到的控件
        
        创建一个字典（内部包含VFL语句中用到的控件）的快捷宏定义
        NSDictionaryOfVariableBindings(...)
        
        
        
2. 添加约束



###VFL语句

参考[MoZiXiong的博客](http://www.cocoachina.com/industry/20131108/7322.html)
    
    //定义VFL中使用的控件
    NSDictionary *dict1 =     
        NSDictionaryOfVariableBindings(_boxV,_headerL,_imageV,_backBtn,_doneBtn); 
        
    //定义VFL中使用的参数  
    NSDictionary *metrics = @{@"hPadding":@5,@"vPadding":@5,@"imageEdge":@150.0}; 
    
    //定义VFL语句 
    NSString *vfl = @"|-hPadding-[_boxV]-hPadding-|"; 
    NSString *vfl0 = @"V:|-25-[_boxV]";   
    NSString *vfl3 = @"V:|-vPadding-[_headerL]-vPadding-[_imageV(imageEdge)]-vPadding-[_backBtn]-vPadding-|";  
    
    
    1)"|"表示superview. 
    
    |-间距-[view1对象名]-(>=20)-[view2对象名]
 
    不写H/V就表示横向，间距可以写固定值也可写>/<。
 
    想要确定从上到下的关系，就加V:|。那么这个vfl字串就可以描述从上到下的view们的关系。
 
    2)看到vfl3里面，方括号表示view，圆括号表示尺寸数值。支持大小等于。或者另一个view　
            |-[view1(view2)]，v１的宽度等于v２。
     
    3)优先级用＠表示。如V:|-50@750-[view(55)]，或者写到metrics里面更好。
    
        具体定义查看UILayoutPriority。有几个固定的数值。1000表示必须支持。
     
    4)options，这个要看具体需要。如果是竖排V布局，可以添加NSLayoutFormatAlignAllLeft，让他们对齐。
        根据需要也可以添加按位或NSLayoutFormatAlignAllLeft | NSLayoutFormatAlignAllRight。
        
        
##总结

    1.addConstraint(s)前，view应该去部被addSubView上去了。
    2.不必给views写frame
    3.给必要的view关掉AutoresizeingMask。[_aView setTranslatesAutoresizingMaskIntoConstraints:NO];
    4.UILabel换行要写linebreakMode,要写numberOfLines(iOS7.0默认是1)
    5.UILabel要想换行，一定要添加preferredMaxLayoutWidth。否则没法初始化宽度。
    
    
    
    
##sizeclass(未整理)

参考[OneV's Den](http://onevcat.com/2014/07/ios-ui-unique/)

参考[Joywii`s Blog](http://joywii.github.io/blog/2014/09/24/ios8-size-classesde-li-jie-yu-shi-yong/)
 