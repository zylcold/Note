# UIDynamic(物理仿真器)

<!-- create time: 2014-11-05 21:49:19  -->

    UIDynamic是从iOS 7开始引入的一种新技术，隶属于UIKit框架
    可以认为是一种物理引擎，能模拟和仿真现实生活中的物理现象
    重力、弹性碰撞等现象
    
    UIGravityBehavior：重力行为
    UICollisionBehavior：碰撞行为
    UISnapBehavior：捕捉行为
    UIPushBehavior：推动行为
    UIAttachmentBehavior：附着行为
    UIDynamicItemBehavior：动力元素行为
    
    哪些对象才能做物理仿真元素
    任何遵守了UIDynamicItem协议的对象
    UIView默认已经遵守了UIDynamicItem协议，因此任何UI控件都能做物理仿真
    UICollectionViewLayoutAttributes类默认也遵守UIDynamicItem协议
    
    
##使用

   1. 创建一个物理仿真器
   2. 创建相应的物理仿真行为
   3. 将物理仿真行为添加到物理仿真器中 -> 开始仿真 
   
   
   
   
###物理仿真器

    UIDynamicAnimator *animator = [[UIDynamicAnimator allon]init];
    
     或在初始化中指定物理仿真的范围
    //UIDynamicAnimator *animator = 
        [[UIDynamicAnimator allon]initWithReferenceView:self.view];
        
    常用方法： 
    - (void)addBehavior:(UIDynamicBehavior *)behavior;
    添加1个物理仿真行为
    
    - (void)removeBehavior:(UIDynamicBehavior *)behavior;
    移除1个物理仿真行为
    
    - (void)removeAllBehaviors;
    移除之前添加过的所有物理仿真行为
        
###物理仿真行为

   UIGravityAnimator(重力行为)
   
        @property (readwrite, nonatomic) CGVector gravityDirection;
        重力方向（是一个二维向量）

        @property (readwrite, nonatomic) CGFloat angle;
        重力方向（是一个角度，以x轴正方向为0°，顺时针正数，逆时针负数）
        
        @property (readwrite, nonatomic) CGFloat magnitude;
        量级（用来控制加速度，1.0代表加速度是1000 points /second²）
   
   UICollisionBehavior(碰撞行为)
       
       添加边界（boundary）
       //通过一个Bezier曲线来设置边界
       - (void)addBoundaryWithIdentifier:(id <NSCopying>)identifier 
               forPath:(UIBezierPath*)bezierPath;
       //设置一个直线的边界
       - (void)addBoundaryWithIdentifier:(id <NSCopying>)identifier 
               fromPoint:(CGPoint)p1 
               toPoint:(CGPoint)p2;
       //返回指定名称的边界
       - (UIBezierPath*)boundaryWithIdentifier:(id <NSCopying>)identifier;
       
       //移除指定名称的边界
       - (void)removeBoundaryWithIdentifier:(id <NSCopying>)identifier;
       
       @property (nonatomic, readonly, copy) NSArray* boundaryIdentifiers;
       - (void)removeAllBoundaries;
       
       //是否以参照视图的bounds为边界
       @property (nonatomic, readwrite) BOOL translatesReferenceBoundsIntoBoundary;
    
       //设置参照视图的bounds为边界，并且设置内边距
       - (void)setTranslatesReferenceBoundsIntoBoundaryWithInsets:    
               (UIEdgeInsets)insets;

      //碰撞模式（分为3种，元素碰撞、边界碰撞、全体碰撞）
      @property (nonatomic, readwrite) UICollisionBehaviorMode collisionMode;


   
   UISnapBehavior(捕捉行为)
   
       可以让物体迅速冲到某个位置（捕捉位置），捕捉到位置之后会带有一定的震动

        UISnapBehavior的初始化
        - (instancetype)initWithItem:(id <UIDynamicItem>)item snapToPoint:(CGPoint)point;
        
        UISnapBehavior常见属性
        @property (nonatomic, assign) CGFloat damping;
        用于减幅、减震（取值范围是0.0 ~ 1.0，值越大，震动幅度越小）
        
        UISnapBehavior使用注意
        如果要进行连续的捕捉行为，需要先把前面的捕捉行为从物理仿真器中移除
        
