一、- (BOOL)translatesAutoresizingMaskIntoConstraints NS_AVAILABLE_IOS(6_0); // Default YES 标示是否自动遵循视图布局约束
二、- (void)setTranslatesAutoresizingMaskIntoConstraints:(BOOL)flag NS_AVAILABLE_IOS(6_0);  设置是否自动遵循视图布局约束
三、+ (BOOL)requiresConstraintBasedLayout NS_AVAILABLE_IOS(6_0);  返回是遵循自定义视图布局约束
四、- (CGRect)alignmentRectForFrame:(CGRect)frame NS_AVAILABLE_IOS(6_0);   返回矩形对于指定视图框架。
五、- (CGRect)frameForAlignmentRect:(CGRect)alignmentRect NS_AVAILABLE_IOS(6_0);返回框架对于指定视图矩形
六、- (UIEdgeInsets)alignmentRectInsets NS_AVAILABLE_IOS(6_0); 返回自定义视图框架
七、- (UIView *)viewForBaselineLayout NS_AVAILABLE_IOS(6_0); 如果超出约束范围，自动生成基线限制，以满足视图需求
八、- (CGSize)intrinsicContentSize NS_AVAILABLE_IOS(6_0); //返回自定义视图大小
九、- (void)invalidateIntrinsicContentSize NS_AVAILABLE_IOS(6_0); //  自定义视图内容大小无效
十、- (UILayoutPriority)contentHuggingPriorityForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0); 返回放大的视图布局的轴线
十一、- (void)setContentHuggingPriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0)设置放大的视图布局的轴线
十二、- (UILayoutPriority)contentCompressionResistancePriorityForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0); 返回缩小的视图布局的轴线
十三、- (void)setContentCompressionResistancePriority:(UILayoutPriority)priority forAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0);设置缩小的视图布局的轴线
十四、- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize NS_AVAILABLE_IOS(6_0);满足约束视图布局的大小
十五、- (NSArray *)constraintsAffectingLayoutForAxis:(UILayoutConstraintAxis)axis NS_AVAILABLE_IOS(6_0); 返回影响视图布局限制的轴线
十六、- (BOOL)hasAmbiguousLayout NS_AVAILABLE_IOS(6_0); 返回视图布局约束是否影响指定视图，主要用于调试约束布局，结合exerciseAmbiguityInLayout。
十七、- (void)exerciseAmbiguityInLayout NS_AVAILABLE_IOS(6_0); 随机改变不同效值布局视图，主要用于调试基于约束布局的视图
十八、@property (nonatomic, copy) NSString *restorationIdentifier NS_AVAILABLE_IOS(6_0);  标示是否支持保存，恢复视图状态信息
十九、- (void) encodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0); 保存视图状态相关信息
二十、- (void) decodeRestorableStateWithCoder:(NSCoder *)coder NS_AVAILABLE_IOS(6_0); 恢复和保持视图状态相关信息