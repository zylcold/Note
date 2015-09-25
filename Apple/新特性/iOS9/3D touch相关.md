#3D Touch相关

##Home Screen Quick Actions
###1. 配置plist文件

	添加UIApplicationShortcutItems 字段  ->数组
	
	格式如下: 
	
		<key>UIApplicationShortcutItems</key>
		    <array>
		        <dict>
		            <key>UIApplicationShortcutItemIconFile</key>
		            <string>open-favorites</string>
		            <key>UIApplicationShortcutItemTitle</key>
		            <string>Favorites</string>
		            <key>UIApplicationShortcutItemType</key>
		            <string>com.mycompany.myapp.openfavorites</string>
		            <key>UIApplicationShortcutItemUserInfo</key>
		            <dict>
		                <key>key1</key>
		                <string>value1</string>
		            </dict>
		        </dict>
		        <dict>
		            <key>UIApplicationShortcutItemIconType</key>
		            <string>UIApplicationShortcutIconTypeCompose</string>
		            <key>UIApplicationShortcutItemTitle</key>
		            <string>New Message</string>
		            <key>UIApplicationShortcutItemType</key>
		            <string>com.mycompany.myapp.newmessage</string>
		            <key>UIApplicationShortcutItemUserInfo</key>
		            <dict>
		                <key>key2</key>
		                <string>value2</string>
		            </dict>
		        </dict>
		    </array>
	
	
	UIApplicationShortcutItemType (required) :Item的类型
	
	UIApplicationShortcutItemTitle (required) : 显示的标题
	
	UIApplicationShortcutItemSubtitle : 副标题
	
	UIApplicationShortcutItemIconType : 图标的类型
	
	UIApplicationShortcutItemIconFile : 图片路径 the app’s bundle, or the name of an image in an asset catalog, cons should be square, single color, and 35x35 points
	
	UIApplicationShortcutItemUserInfo : 额外信息
	
	
###2. 设置处理事件


####1. 获取点击内容

	//当用户触发3Dtouch时调用，除了 
        application(_:,willFinishLaunchingWithOptions:) or application(_:didFinishLaunchingWithOptions) 返回 `false` 时
	- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler；
	
	//程序启动时launchOptions[UIApplicationLaunchOptionsShortcutItemKey] 获取
	- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
	
####2. 处理点击内容时机
		
		-->应用未打开
		
		-->3D touch
		
		-->执行performActionForShortcutItem
			
			处理事件
			
		-->执行didFinishLaunchingWithOptions
		
			获取UIApplicationShortcutItem对象，并保存在总代理中，程序生命周期中一直存在
			
			返回false  //程序启动时3D touch不再执行performActionForShortcutItem
			
		-->程序进入后台
		
		-->3D touch 进入前台
		
		-->执行applicationDidBecomeActive
		
			从总代理中拿到UIApplicationShortcutItem对象，并执行操作
			

####3. 动态添加UIApplicationShortcutItem

	
        // Install initial versions of our two extra dynamic shortcuts.
		//判断是否存在
        if let shortcutItems = application.shortcutItems where shortcutItems.isEmpty {
            // Construct the items.
            let shortcut3 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Third.type, localizedTitle: "Play", localizedSubtitle: "Will Play an item", icon: UIApplicationShortcutIcon(type: .Play), userInfo: [
                    AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.Play.rawValue
                ]
            )

            let shortcut4 = UIMutableApplicationShortcutItem(type: ShortcutIdentifier.Fourth.type, localizedTitle: "Pause", localizedSubtitle: "Will Pause an item", icon: UIApplicationShortcutIcon(type: .Pause), userInfo: [
                    AppDelegate.applicationShortcutUserInfoIconKey: UIApplicationShortcutIconType.Pause.rawValue
                ]
            )

            // Update the application providing the initial 'dynamic' shortcut items.
            application.shortcutItems = [shortcut3, shortcut4]
        }
	

	