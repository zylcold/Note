##Handoff
	Handoff是iOS 8和OS X Yosemite中的一个新特性。它让我们在不同的设备间切换时，可以不间断地继续一个Activity，而不需要重新配置任何设备。
	Handoff不仅可以将当前的activity从一个iOS设备传递到OS X设备，还可以将activity在不同的iOS设备传递。目前在模拟器上还不能使用Handoff功能，所以需要在iOS设备上运行我们的实例。

####条件

	Handoff功能依赖于以下几点：

	一个iCloud账户：我们必须在希望使用Handoff功能的多台设备上登录同一个iCloud账户。
	低功耗蓝牙(Bluetooth LE 4.0)：Handoff是通过低功耗蓝牙来广播activities的，所以广播设备和接收设备都必须支持Bluetooth LE 4.0。
	iCloud配对：设备必须已经通过iCloud配对。当在支持Handoff的设备上登录iCloud账户后，每台设备都会与其它支持Handoff的设备进行配对。
	
####User Activities

	Handoff是基于User Activity的。User Activity是一个独立的信息集合单位，可以不依赖于任何其它信息而进行传输(be handed off)。
	NSUserActivity对象表示一个User Activity实例。它封装了程序的一些状态，这些状态可以在其它设备相关的程序中继续使用。
	
	有三种方法和一个NSUserActivity对象交互：

	1) 创建一个user activity：原始应用程序创建一个NSUserActivity实例并调用becomeCurrent()以开启一个广播进程。下面是一个实例：

	let activity = NSUserActivity(activityType: "com.razeware.shopsnap.view")
	activity.title = "Viewing"
	activity.userInfo = ["shopsnap.item.key": ["Apple", "Orange", "Banana"]]
	self.userActivity = activity;
	self.userActivity?.becomeCurrent()
	我们可以使用NSUserActivity的userInfo字典来传递本地数据类型对象或可编码的自定义对象以将其传输到接收设备。本地数据类型包括NSArray, NSData, NSDate, NSDictionary, NSNull, NSNumber, NSSet, NSString, NSUUID和NSURL。通过NSURL可能会有点棘手。在使用NSURL前可以先参考一下下面的“最佳实践”一节。

	2) 更新user activity：一旦一个NSUserActivity成为当前的activity，则iOS会在最上层的视图控制器中调用updateUserActivityState(activity:)方法，以让我们有机会来更新user activity。下面是一个实例：

	override func updateUserActivityState(activity: NSUserActivity) {
	  let activityListItems = // ... get updated list of items
	  activity.addUserInfoEntriesFromDictionary(["shopsnap.item.key": activityListItems])
	  super.updateUserActivityState(activity)
	}
	注意我们不要将userInfo设置为一个新的字典或直接更新它，而是应该使用便捷方法addUserInfoEntriesFromDictionary()。

	在下文中，我们将学习如何按需求强制刷新user activity，或者是在程序的app delegate级别来获取一个相似功能的回调。

	3) 接收user activity：当我们的接收程序以Handoff的方式启动时，程序代理会调用application(:willContinueUserActivityWithType:)方法。注意这个方法的参数不是NSUserActivity对象，因为接收程序在下载并传递NSUserActivity数据需要花费一定的时间。在user activity已经被下载完成后，会调用以下的回调函数：

	func application(application: UIApplication!, 
	                 continueUserActivity userActivity: NSUserActivity!,
	                 restorationHandler: (([AnyObject]!) -> Void)!) 
	                 -> Bool {
 
	  // Do some checks to make sure you can proceed
	  if let window = self.window {
	    window.rootViewController?.restoreUserActivityState(userActivity)
	  }
	  return true
	}
	然后我们可以使用存储在NSUserActivity对象中的数据来重新创建用户的activity。在这里，我们更新我们的应用以继续相关的activity。
	
####Activity类型

	当创建一个user activity后，我们必须为其指定一个activity类型。一个activity类型是一个简单的唯一字符串，通常使用反转DNS语义，如com.razeware.shopsnap.view。

	每一个可以接收user activity的程序都必须声明其可接收的activity类型。这类似于在程序中声明支持的URL方案(URL scheme)。对于非基于文本的程序，activity类型需要在Info.plist文件中定义，其键值为NSUserActivityTypes
	
	对于支持一个给定activity的程序来说，需要满足三个要求：

	相同的组：两个程序都必须源于使用同一开发者组ID(developer Team ID)的开发者。
	相同的activity类型：发送程序创建某一activity类型的user activity，接收程序必须有相应类型的NSUserActivityTypes入口。
	签约：两个程序必须通过App store来发布或使用同一开发者账号来签约。
	
	
[iOS 8 Handoff 指南](http://ios.jobbole.com/81951/)