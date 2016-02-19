##JavaScript 与Native交互

交互方式：iOS7新框架JavaScriptCore， 拦截协议， 第三方框架WebViewJavaScriptBridge, iOS8新WKWebView

1. Objective-C 执行JavaScript代码

	// UIWebView的方法
	- (nullable NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
	 
	// JavaScriptCore中JSContext的方法
	- (JSValue *)evaluateScript:(NSString *)script;
	- (JSValue *)evaluateScript:(NSString *)script withSourceURL:(NSURL *)sourceURL

Demo：
	
	//UIWebView
	[self.webView stringByEvaluatingJavaScriptFromString:@"console.log('hello world')"];

	//JavaScriptCore
	JSValue *value = [self.context evaluateScript:@"1+1"];
	NSLog(@"2 + 2 = %d", [result toInt32]);

	Web端
		var factorial = function(n) {
			if (n < 0)
				return;
			if (n === 0)
				return 1;
			return n * factorial(n - 1)
		};

	Native端：

		NSString *factorialScript = loadFactorialScript();
		[_context evaluateScript:factorialScript];
		JSValue *function = _context[@"factorial"];
		JSValue *result = [function callWithArguments:@[@5]];
		NSLog(@"factorial(5) = %d", [result toInt32]);

2. JavaScript 调用 Native 方法

	1. 拦截协议

		Web端
			function js_call_oc() {  
				var iFrame;  
				iFrame = document.createElement("iframe");  
				iFrame.setAttribute("src", "ios://jwzhangjie");  
				iFrame.setAttribute("style", "display:none;");  
				iFrame.setAttribute("height", "0px");  
				iFrame.setAttribute("width", "0px");  
				iFrame.setAttribute("frameborder", "0");  
				document.body.appendChild(iFrame);
				// 发起请求后这个iFrame就没用了，所以把它从dom上移除掉
				iFrame.parentNode.removeChild(iFrame);
				iFrame = null;  																			
			}

	 Navtive端：

		在webView:shouldStartLoadWithRequese:navigationType:方法中拦截请求并执行
			if([request.URL.absoluteString rangeOfString:@"ios://jwzhangjie"].length != 0) {
				//Todo SomeThing...
				[self.webView stringByEvaluatingJavaScriptFromString:@"console.log('hello world')"];
			｝


	2. 第三方框架WebViewJavaScriptBridge
		//对拦截协议的封装

	3. JavaScriptCore 
		//两种方式调用：Block， JSExport protocol

		1. Block

			//Native端

			context[@"sayHello"] = ^{
				NSLog("Hello World";
			}

			//Web端

			sayHello();


		2.JSExport protocol
		
			1. 继承JSExport协议，暴露属性
			2. 实现JSExport协议
			3. 将实现协议的对象传人Context
			4. Web端通过传入对象掉用暴露的方法和属性
		
		Demo：

		Native端：

		@protocol MyPointExports <JSExport>
		@property double x;
		- (NSString *)description;
		+ (double)makePointWithX:(double)x;
		@end
		
		@interface MyPoint: NSObject <MyPointExport>
		@end
		@implementation MyPoint
		//...
		@end

		//传入对象
		MyPoint *point = [[MyPoint allc] init];
		self.jsContext[@"nativeObject"] = point;

		Web端

		nativeObject.x = 100
		nativeObject.description()


	注意：
		
		在block中获取当前JS环境通过[JSContext currentContext]获取


	内存管理：
		Native使用ARC管理
		JavaScriptCore 使用内存垃圾回收管理

		JavaScript中所有的引用都是强引用

		API的内存管理大多数是自动管理

		以下两种情况值得注意：
		1. Native对象中包含JavaScript对象
		2. 添加JavaScript对象到Native对象中


		web端
		function ClickHandler(button, callback) {
			this.button = button;
			this.button.onClickHandler = this;
			this.handleEvent = callback;
		};

		Native端

		@implementation MyButton
		- (void)setOnClickHandler:(JSValue *)handler
		{
			 _onClickHandler = handler; // Retain cycle
		}
		@end

		错误：button通过_onClickHandler对this强引用
			  this通过button对button强引用

		@implementation MyButton
		- (void)setOnClickHandler:(JSValue *)handler
		{
			_onClickHandler = [JSManagedValue managedValueWithValue:handler];
			[_context.virtualMachine addManagedReference:_onClickHandler withOwner:self]
		} 
		@end
		对于JavaScript对象JSManagedValue是一个弱引用
		addManagedReference返回一个JavaScript内存管理的引用



参考：
http://devstreaming.apple.com/videos/wwdc/2013/615xax5xpcdns8jyhaiszkz2p/615/615.pdf

http://blog.iderzheng.com/ios7-objects-management-in-javascriptcore-framework/
		




