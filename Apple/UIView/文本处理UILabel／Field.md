# 文本处理UILabel／Field

<!-- create time: 2014-10-25 17:26:21  -->

##UITextField常用属性

    field.leftView = imageView;   //设着左右显示view，必须设着显示模式。
    field.leftViewMode = UITextFieldViewModeAlways;
    field.placeholder = @"demo";  //设置提示文字
    //field.attributedPlaceholder = disc; //或通过属性字典详细设置文字
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    //设置输入框的清空按钮
    
    //具体 UITextInputTraits.h
    self.returnKeyType = UIReturnKeySearch;//设置键盘返回键的样式
    self.enablesReturnKeyAutomatically = YES; //当输入框中有文字时，才能点击
    
    
    borderStyle：文本框的边框风格
    autocorrectionType：可以设置是否启动自动提醒更正功能。
    placeholder：设置默认的文本显示
    returnKeyType:设置键盘完成的按钮
    
##设置当前光标位置

    self.textEditView.text = @"##"; //设置文字
    self.textEditView.selectedRange = NSMakeRange(1, 0); 
    //位置从0开始，范围（大于0表示选中某段文字）
    
##截取一个指定范围的文字

    //"<a href="http://weibo.com" rel="nofollow">新浪微博</a>"
    
    int startLoc = (int)[source rangeOfString:@">"].location + 1;
    int lenght = (int)[source rangeOfString:@"</"].location - startLoc;
    
    source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:NSMakeRange(startLoc, lenght)]];
    
    
