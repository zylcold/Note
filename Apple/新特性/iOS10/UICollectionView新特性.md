#UICollectionView新特性

[转自【WWDC2016 Session笔记】 iOS 10 UICollectionView新特性](http://www.cocoachina.com/ios/20160706/16952.html)

##CollectionViewCell 生命周期的改进

###iOS 10之前CollectionViewCell的生命周期

1. prepareForReuse 
	
	**cell上边缘马上进入屏幕的时候时**，从缓存池取出Cell  用来重置cell，重置状态，刷新cell，加载新的数据
	
2. cellForItemAtIndexPath
	
	填充data model，然后赋值给cell，再把cell返回给iOS系统
	
3. willDisplayCell
	
	为cell进入屏幕做最后的准备工作。执行完willDisplayCell之后，cell就进入屏幕
	
4. didEndDisplayingCell

	整个cell要从UICollectionView的可见区域消失的时候, cell会进入重用队列中
	
###iOS 10 CollectionViewCell的生命周期(生命周期显示过程提前)

1. prepareForReuse

	**当cell还没有进入屏幕的时候**, 从缓存池取出Cell  用来重置cell，重置状态，刷新cell，加载新的数据
	
2. cellForItemAtIndexPath

	填充data model，然后赋值给cell，再把cell返回给iOS系统**提前**
	
3. willDisplayCell
	
	为cell进入屏幕做最后的准备工作。执行完willDisplayCell之后，cell就进入屏幕**未提前**
	
4. didEndDisplayingCell

	整个cell要从UICollectionView的可见区域消失的时候. cell会进入重用队列中
	
5. 重复显示Cell

	如果用户想要显示某个cell，在iOS 9 当中，cell只能从重用队列里面取出，再次走一遍生命周期。并调用cellForItemAtIndexPath去创建或者生成一个cell。
	在iOS 10 当中，系统会把cell保持一段时间。在iOS中，如果用户把cell滑出屏幕后，如果突然又想回来，这个时候cell并不需要再走一段的生命周期了。只需要直接调用willDisplayCell就可以了。cell就又会重新出现在屏幕中。
	这就是iOS 10 的整个UICollectionView的生命周期。
	
###iOS 10 多列的情况的改进

我们每次只加载一个cell，而不是每次加载一行的cell。当第一个cell准备好之后再叫下一个cell准备。当全部cell都准备好了之后，接着我们再调用willDisplayCell给每个cell，发送完这个消息之后，cell就会出现在屏幕上了。

##UICollectionViewCell的Pre-Fetching预加载

###用前须知
	iOS 10 Pre-Fetching默认是enable
	
	如果有一些原因导致你必须用到iOS 10之前老的生命周期，你只需要给collectionView加入新的isPrefetchingEnabled属性即可。如果你不想用到Pre-Fetching，那么把这个属性变成false即可。
	collectionView.isPrefetchingEnabled = false

###新的代理协议 prefetchDataSource

	func collectionView(_ collectionView: UICollectionView,
	                        prefetchItemsAt indexPaths: [NSIndexPath])

    //用来给你异步的预加载数据的。indexPaths数组是有序的，就是接下来item接收数据的顺序，让我们model异步处理数据更加方便

	optional func collectionView(_ collectionView: UICollectionView,
	                                 cancelPrefetchingForItemsAt indexPaths: [NSIndexPath])
									 
    //处理在滑动中取消或者降低提前加载数据的优先级
	
###用时须知

1. 在我们使用Pre-Fetching API的时候，我们一定要保证整个预加载的过程都放在后台线程中进行。合理使用GCD 和 NSOperationQueue处理好多线程。
2. 请切记，Pre-Fetching API是一种自适应的技术。何为自适应技术呢？当我们滑动速度很慢的时候，在这种“安静”的时期，Pre-Fetching API会默默的在后台帮我们预加载数据，但是一旦当我们快速滑动，我们需要频繁的刷新，我们不会去执行Pre-Fetching API。

3. 最后，用cancelPrefetchingAPI去迎合用户的滑动动作的变换，比如说用户在快速滑动时,停下来滑动了，甚至快速反向滑动，或者点击了事件，进入下一页面，这时我们应该开启cancelPrefetchingAPI。

###UITableViewCell的Pre-Fetching预加载

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [NSIndexPath])
    optional func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths:
                               [NSIndexPath])
							   
##针对self-sizing的改进

1. 3种方法来动态的布局

	1). 使用autolayout(Cell)
	2). 重写sizeThatFits()方法。(Cell)
	3). 重写preferredLayoutAttributesFittingAttributes()方法(CollectionLayout)
	
2. 新API
	
	layout.estimatedItemSize = UICollectionViewFlowLayoutAutomaticSize
	
	系统会自动计算好所有的布局，包括已经定下来的size的cell，并且还会**动态的给出接下来cell的大小的预测**。
	
	
	iOS 9 的布局是针对单个cell计算的，当改变了单个的cell，其他的cell依旧没有变化，还是需要重新计算。
	iOS 10 当改变了第一个cell的size以后，系统会自动计算出所有的cell的size，并且每一行，每一个section的size都会被动态的计算出来，并且刷新界面
	
##Interactive Reordering(重排列技术)

1. iOS 9 API

		class UICollectionView : UIScrollView {
		    func beginInteractiveMovementForItem(at indexPath: NSIndexPath) -> Bool
		    func updateInteractiveMovementTargetPosition(_ targetPosition: CGPoint)
		    func endInteractiveMovement()
		    func cancelInteractiveMovement()
		}
		
	要想开启interactive movement，我们就需要调用beginInteractiveMovementForItem()方法，其中indexPath代表了我们将要移动走的cell。接着每次手势的刷新，我们都需要刷新cell的位置，去响应我们手指的移动操作。这时我们就需要调用updateInteractiveMovementTargetPosition()方法。我们通过手势来传递坐标的变化。当我们移动结束之后，就会调用endInteractiveMovement()方法。 UICollectionView 就会放下cell，处理完整个layout，此时你也可以重新刷新model或者处理数据model。如果中间突然手势取消了，那么这个时候就应该调用cancelInteractiveMovement()方法。如果我们重新把cell移动一圈之后又放回原位，其实就是取消了移动，那这个时候就应该在cancelInteractiveMovement()方法里面不用去刷新data source。
	
2. iOS 10

	在iOS 10中，如果你使用UICollectionViewController，那么这个重排对于你来说会更加的简单。
	
		class UICollectionViewController : UIViewController {
		    var installsStandardGestureForInteractiveMovement: Bool
		}
	你只需要把installsStandardGestureForInteractiveMovement这个属性设置为True即可。CollectionViewController会自动为你加入手势，并且自动为你调用上面的方法。

3. 重排分页

	collectionView.isPagingEnabled = true
	
##UIRefreshControl

	UIRefreshControl脱离UITableViewController，成为ScrollView的一个属性。

	