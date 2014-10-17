# UIWebView

<!-- create time: 2014-10-17 15:59:03  -->

##加载本地网页

   objective-c:
   
    //通过mainBundle找到本地网页的全路径－>url对象
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.htmlModel.html withExtension:nil];
    //创建网络请求
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    //webView 加载网络请求。
    [webView loadRequest:request];

##执行JavaScript
    在应该在网页加载完毕时执行代码，通过webview的代理方法在web加载完毕时执行。
    
   objective-c:
   
       //web加载完毕时执行
       - (void)webViewDidFinishLoad:(UIWebView *)webView
       {
           //拼接js代码，跳转到指定id标签
            NSString *js = [NSString stringWithFormat:
                @"window.location.href = '#%@';",self.htmlModel.ID];
                
            //执行js代码
            [webView stringByEvaluatingJavaScriptFromString:js];
       }