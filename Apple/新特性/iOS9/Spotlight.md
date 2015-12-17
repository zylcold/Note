##iOS 9：支持spotlight搜索
	
	#import <CoreSpotlight/CoreSpotlight.h>
	
    CSSearchableItemAttributeSet *itemSet = [[CSSearchableItemAttributeSet alloc] initWithItemContentType:@"hello"];
       itemSet.title = @"北京";
       itemSet.contentDescription = @"iWork Numbers Document";
       CSSearchableItem *item = [[CSSearchableItem alloc] initWithUniqueIdentifier:@"101" domainIdentifier:@"XJLWJYB" attributeSet:itemSet];
       [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * _Nullable error) {
           if(error) {
               NSLog(@"%@", error);
           }else {
               NSLog(@"chenggong");
           }
       }];
	
	
###1. 创建支持搜索的内容

	支持搜索的内容的类是CSSearchableItem。

	可以展示的属性有标题，一段描述文字，还有缩略图。这里建议给每个item设置一个过期时间（expirationDate）
	
	attributeSet.title = "July Report.Numbers"  //标题
	attributeSet.contentDescription = "iWork Numbers Document" //子标题
	attributeSet.thumbnailData = DocumentImage.jpg  //缩略图，默认应用图标
	
	attributeSet.phoneNumbers;  //电话号码
	//经纬度
	attributeSet.latitude;  
	attributeSet.longitude;
	
	
###2. 创建CSSearchableItem

	uniqueIdentifier相当于这条数据的id。domainIdentifier则表示相关的域。苹果还提供了一组api对这些索引进行修改删除操作，domainIdentifier可以当做参数，比如可以讲一个域下的所有索引删除。
	
###3. 将CSSearchableItem添加至系统

    [[CSSearchableIndex defaultSearchableIndex] indexSearchableItems:@[item] completionHandler:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"%@", error);
        }else {
            NSLog(@"chenggong");
        }
    }];