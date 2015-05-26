###Masonry

Masonry[GitHub](https://github.com/SnapKit/Masonry)

CocoaPod:
	
	pod 'Masonry', '~> 0.6.1'
	
Objective-C下的方便快速实现Autolayout的第三方框架。

Swift下建议使用同作者下的[SnapKit](https://github.com/SnapKit/SnapKit)


###简介

	Masonry是利用的链式的DSL实现对Autolayout的上层封装
	
	目录结构
	
	|--Masonry.h  								//总头文件
	|--MASUtilities.h							//工具函数，常用宏
	|--View+MASAdditions.h						//UIView(NSView)的扩展分类，定义约束属性，添加、删除、更新约束的方法
	|--View+MASShorthandAdditions.h	
	|--NSArray+MASAdditions.h					//NSArray的扩展分类, 添加、删除、更新约束的方法
	|--NSArray+MASShorthandAdditions.h
	|--MASConstraint.h							//定义约束
	|--MASConstraint+Private.h					//定义约束（私有类）
	|--MASCompositeConstraint.h					//创建一组约束属性
	|--MASViewAttribute.h
	|--MASViewConstraint.h
	|--MASConstraintMaker.h						//利用工厂方法创建MASConstraints
	|--MASLayoutConstraint.h					//添加一个约束标记
	|--NSLayoutConstraint+MASDebugAdditions.h
	
	
###与AutoLayout比较

需求:

	定义一个view1的四边与父控件的间距是10的自动约束。
	

AutoLayout：

	实现方式一(单个创建):
	
		UIView *superview = self;
		UIView *view1 = [[UIView alloc] init];
		view1.translatesAutoresizingMaskIntoConstraints = NO;
		view1.backgroundColor = [UIColor greenColor];
		[superview addSubview:view1];

		UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);

		[superview addConstraints:@[

		    //view1 constraints
		    [NSLayoutConstraint constraintWithItem:view1
		                                 attribute:NSLayoutAttributeTop
		                                 relatedBy:NSLayoutRelationEqual
		                                    toItem:superview
		                                 attribute:NSLayoutAttributeTop
		                                multiplier:1.0
		                                  constant:padding.top],

		    [NSLayoutConstraint constraintWithItem:view1
		                                 attribute:NSLayoutAttributeLeft
		                                 relatedBy:NSLayoutRelationEqual
		                                    toItem:superview
		                                 attribute:NSLayoutAttributeLeft
		                                multiplier:1.0
		                                  constant:padding.left],

		    [NSLayoutConstraint constraintWithItem:view1
		                                 attribute:NSLayoutAttributeBottom
		                                 relatedBy:NSLayoutRelationEqual
		                                    toItem:superview
		                                 attribute:NSLayoutAttributeBottom
		                                multiplier:1.0
		                                  constant:-padding.bottom],

		    [NSLayoutConstraint constraintWithItem:view1
		                                 attribute:NSLayoutAttributeRight
		                                 relatedBy:NSLayoutRelationEqual
		                                    toItem:superview
		                                 attribute:NSLayoutAttributeRight
		                                multiplier:1
		                                  constant:-padding.right],

		 ]];
		 
		 
	实现方式二（VFL）:
	
		UIView *superview = self.view;
	    UIView *view1 = [[UIView alloc] init];
	    view1.translatesAutoresizingMaskIntoConstraints = NO;
	    view1.backgroundColor = [UIColor greenColor];
	    [superview addSubview:view1];

	    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);

	    NSArray *constraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-top-[view1]-bottom-|"
	                                                                    options:NSLayoutFormatDirectionLeadingToTrailing
	                                                                    metrics:@{
	                                                                              @"top" : @(padding.top),
	                                                                              @"bottom" : @(padding.bottom)
	                                                                              }
	                                                                      views:NSDictionaryOfVariableBindings(view1)];

	    NSArray *constraintsV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-left-[view1]-right-|"
	                                                                    options:NSLayoutFormatDirectionLeadingToTrailing
	                                                                    metrics:@{
	                                                                              @"left" : @(padding.left),
	                                                                              @"right" : @(padding.right)
	                                                                              }
	                                                                      views:NSDictionaryOfVariableBindings(view1)];

	    [superview addConstraints:constraintsH];
	    [superview addConstraints:constraintsV];
	
	

Masonry:

		UIView *superview = self.view;
	    UIView *view1 = [[UIView alloc] init];
	    view1.translatesAutoresizingMaskIntoConstraints = NO;
	    view1.backgroundColor = [UIColor greenColor];
	    [superview addSubview:view1];

	    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);

		[view1 mas_makeConstraints:^(MASConstraintMaker *make) {
		    make.top.equalTo(superview.mas_top).with.offset(padding.top); //with is an optional semantic filler
		    make.left.equalTo(superview.mas_left).with.offset(padding.left);
		    make.bottom.equalTo(superview.mas_bottom).with.offset(-padding.bottom);
		    make.right.equalTo(superview.mas_right).with.offset(-padding.right);
		}];
		
		
		或者:
		
		UIView *superview = self.view;
	    UIView *view1 = [[UIView alloc] init];
	    view1.translatesAutoresizingMaskIntoConstraints = NO;
	    view1.backgroundColor = [UIColor greenColor];
	    [superview addSubview:view1];

	    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
		
		[view1 mas_makeConstraints:^(MASConstraintMaker *make) {
		    make.edges.equalTo(superview).with.insets(padding);
		}];
		
		
###Masonry支持的约束属性


	MASViewAttribute           |  NSLayoutAttribute
	-------------------------  |  --------------------------
	view.mas_left              |  NSLayoutAttributeLeft
	view.mas_right             |  NSLayoutAttributeRight
	view.mas_top               |  NSLayoutAttributeTop
	view.mas_bottom            |  NSLayoutAttributeBottom
	view.mas_leading           |  NSLayoutAttributeLeading
	view.mas_trailing          |  NSLayoutAttributeTrailing
	view.mas_width             |  NSLayoutAttributeWidth
	view.mas_height            |  NSLayoutAttributeHeight
	view.mas_centerX           |  NSLayoutAttributeCenterX
	view.mas_centerY           |  NSLayoutAttributeCenterY
	view.mas_baseline          |  NSLayoutAttributeBaseline


	- (MASConstraint *)left
	- (MASConstraint *)top;
	- (MASConstraint *)right;
	- (MASConstraint *)bottom;
	- (MASConstraint *)leading;
	- (MASConstraint *)trailing;
	- (MASConstraint *)width;
	- (MASConstraint *)height;
	- (MASConstraint *)centerX;
	- (MASConstraint *)centerY;
	- (MASConstraint *)baseline;
	
	#if TARGET_OS_IPHONE（iOS8新增属性）
	- (MASConstraint *)leftMargin;  
	- (MASConstraint *)rightMargin;
	- (MASConstraint *)topMargin;
	- (MASConstraint *)bottomMargin;
	- (MASConstraint *)leadingMargin;
	- (MASConstraint *)trailingMargin;
	- (MASConstraint *)centerXWithinMargins;
	- (MASConstraint *)centerYWithinMargins;
	#endif
	
	@property (nonatomic, strong, readonly) MASConstraint *edges;
	@property (nonatomic, strong, readonly) MASConstraint *size;
	@property (nonatomic, strong, readonly) MASConstraint *center;
	
###Masonry支持的约束条件


	- (MASConstraint * (^)(MASEdgeInsets insets))insets; 			//内边距
	- (MASConstraint * (^)(CGSize offset))sizeOffset;   			//Size
	- (MASConstraint * (^)(CGPoint offset))centerOffset; 			//Center 
	- (MASConstraint * (^)(CGFloat offset))offset;					//偏移
	- (MASConstraint * (^)(NSValue *value))valueOffset;
	
	
	- (MASConstraint * (^)(CGFloat multiplier))multipliedBy;     	//乘数
	- (MASConstraint * (^)(CGFloat divider))dividedBy;				//乘数 ＝ 1.0/dividedBy
	
	
	- (MASConstraint * (^)(MASLayoutPriority priority))priority;  	//优先级
	- (MASConstraint * (^)())priorityLow;
	- (MASConstraint * (^)())priorityMedium;
	- (MASConstraint * (^)())priorityHigh;
	
	
	- (MASConstraint * (^)(id attr))equalTo;						//等于
	- (MASConstraint * (^)(id attr))greaterThanOrEqualTo;			//大于等于
	- (MASConstraint * (^)(id attr))lessThanOrEqualTo;				//小于等于
	
	- (MASConstraint *)with;										//无意义
	- (MASConstraint *)and;
	
	

###实践

[例子](http://adad184.com/2014/09/28/use-masonry-to-quick-solve-autolayout/)
	

###拾遗

1.  equalTo 和 mas_equalTo的区别在哪？

		其实 mas_equalTo是一个MACRO，mas_equalTo只是对其参数进行了一个BOX操作(装箱) MASBoxValue的定义具体可以看看源代码
		所支持的类型 除了NSNumber支持的那些数值类型之外 就只支持CGPoint CGSize UIEdgeInsets
		
2. and和with 的作用
		
		- (MASConstraint *)with {
		    return self;
		}
		- (MASConstraint *)and {
		    return self;
		}
		
		没有作用，只是为了增加代码的可读性
		
3. leading与left trailing与right 的区别

		一般情况下没有区别，但是当一些布局是从右至左时(比如阿拉伯文) 则会对调 
		
4. 关于Block的引用循环

		masonry并没有对block进行copy和retain 所以不会有retain cycle
		
		
###特性

1. 不再局限于Autolayout的子集，Autolayout能做的，Masnory也都能完成
2. 更好的调试支持，让你的视图和约束有更好理解的命名
3. 添加约束的语句看起来更像句子
4. 没有疯狂的使用宏，防止污染全局命名空间
5. 没有字符串和字典的使用，更好的在编译时期检查出错误