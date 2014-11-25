# NSAttributedString

<!-- create time: 2014-11-25 01:10:42  -->

    NSAttributedString管理一个字符串，以及与该字符串中的单个字符或某些范围的字符串相关的属性。
    比如这个字符串“我爱北京天安门”，“我”跟其他字符的颜色不一样，而“北京”与其他的字体和大小不一样，等等。
    NSAttributedString就是用来存储这些信息的，具体实现时，NSAttributedString维护了一个NSString，用来保存最原始的字符串，另有一个NSDictionary用来保存各个子串/字符的属性。
