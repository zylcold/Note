# CoreLocation

<!-- create time: 2014-11-07 17:24:06  -->

##CoreLocation 
> 所属框架 CoreLocation.framework

###常用功能
  1. 获取用户地理位置
  2. 地理编码与反地理编码 
  
  
  
###获取地理位置CLLocationManager

  1. 开启地理服务
  
     Objective-c:
          
        //为保证LocM在使用过程中不被销毁，最好设置为控制器的属性进行强引用
        if  (CLLocationManager.locationServicesEnabled){  //判断定位服务是否可用
            [self.locM startUpdatingLocation];  //开启定位服务
            self.locM.desiredAccuracy = kCLLocationAccuracyHundredMeters;//定位的精度
            self.locM.distanceFilter = 200; //每隔多少米才将更新发送给委托
            self.locM.delegate = self; // 设置代理
        }
        
        
###CLLocation模型

    
     //通常代理中返回的模型为CLLocation对象数组
        CLLocation中的常用属性
        
        @property(readonly) CLLocationCoordinate2D coordinate;//x.y坐标
        @property(readonly) CLLocationDistance altitude; //海拔
        @property(readonly) CLLocationAccuracy horizontalAccuracy;//水平精度
        @property(readonly) CLLocationAccuracy verticalAccuracy; //垂直精度  
        @property(readonly) CLLocationDirection course 
        //航线0.0 - 359.9 degrees, 0 being true North
        @property(readonly) CLLocationSpeed speed //速度 m／s
        @property(readonly, nonatomic, copy) NSDate *timestamp; //UNIX时间
        @property (readonly) NSString *description; //描述
        
         /*
         *  floor
         *  Discussion:
         *    Contains information about the logical floor that you are on
         *    in the current building if you are inside a supported venue.
         *    This will be nil if the floor is unavailable.
         */
        @property(readonly, nonatomic, copy) CLFloor *floor     
            //__OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_8_0);
    
        常用方法
        
        - (CLLocationDistance)distanceFromLocation:(const CLLocation *)location
        计算两个CLLocation的直线距离
    
    
        CLLocationCoordinate2D 结构体
        typedef struct {
        	CLLocationDegrees latitude;  //纬度
        	CLLocationDegrees longitude; //经度
        } CLLocationCoordinate2D;
        
        
        
###地理编码／反地理编码 CLGeocoder

 1. 地理编码 -通过地标获取位置具体信息
 
    核心方法:
        
        - (void)geocodeAddressString:(NSString *)addressString   //地标名称
               completionHandler:(CLGeocodeCompletionHandler)completionHandler;
                    //回调函数
                    
        
        e.g
        CLGeocoder *geocode = [[CLGeocoder alloc]init];
        [geocode geocodeAddressString:@"东阿" completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error) {
                for (int i = 0; i < placemarks.count; i ++) {
                    CLPlacemark *placeMark = placemarks[i];
                    NSLog(@"%@---%f, %f",placeMark.name,     
                        placeMark.location.coordinate.latitude, 
                        placeMark.location.coordinate.longitude);
                }
                
            }
        }];     
        
        
2. 反地理编码 － 通过经纬度获取位置具体信息

    核心方法:
    
        - (void)reverseGeocodeLocation:(CLLocation *)location    //CLLocation模型
               completionHandler:(CLGeocodeCompletionHandler)completionHandler; 
          //回调函数
     
 
        e.g
        
        CLGeocoder *geocode = [[CLGeocoder alloc]init];
        CLLocation *loc = 
            [[CLLocation alloc]initWithLatitude:36.336004 longitude:116.248855];
        [geocode reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
            if (!error) {
                for (int i = 0; i < placemarks.count; i ++) {
                    CLPlacemark *placeMark = placemarks[i];
                    NSLog(@"%@",placeMark.name);
                }
            }
        }];

    
###CLPlacemarks模型属性:

           
       //初始化方法
       -(instancetype)initWithPlacemark:(CLPlacemark *)placemark;
       
       @property (readonly, copy) CLLocation *location; //CLLocation模型

       @property (nonatomic, readonly, copy) CLRegion *region; //CLRegion结构体

 
      //字典中的Key 来自AddressBook.framework 
      // CFStringRef 转NSString 需要桥接
      NSString *str = 
          placeMark.addressDictionary[(__bridge NSString *)kABPersonAddressCityKey];
          
      CFStringRef  kABPersonAddressStreetKey ;
      CFStringRef  kABPersonAddressCityKey ;
      CFStringRef  kABPersonAddressStateKey ;
      CFStringRef  kABPersonAddressZIPKey ;
      CFStringRef  kABPersonAddressCountryKey ;
      CFStringRef  kABPersonAddressCountryCodeKey;
       
      //或者 以下key （可通过KVC将内部的key打印）
      
      SubLocality  如果可用，指本地邻近地区名称或一个地标
      CountryCode  缩写国家名
      Name   全名
      State   州
      FormattedAddressLines  格式化后的地址
      Country  国家
      City  城市
      
      ->http://blog.csdn.net/lvxiangan/article/details/26015147
      SubThoroughfare //具体地址
      Street // 街道完整名称
      上面的这个字典是可以直接转化为联系人的字典的，
              通过这个ABCreateStringWithAddressDictionary属性。
      
      @property (readonly, copy) NSDictionary *addressDictionary;

        // address dictionary properties
        @property (readonly, copy) NSString *name; 
        // eg. Apple Inc.
        @property (readonly, copy) NSString *thoroughfare; 
        // street address, eg. 1 Infinite Loop
        @property (readonly, copy) NSString *subThoroughfare; 
        // eg. 1
        @property (readonly, copy) NSString *locality; 
        // city, eg. Cupertino
        @property (readonly, copy) NSString *subLocality; 
        // neighborhood, common name, eg. Mission District
        @property (readonly, copy) NSString *administrativeArea; 
        // state, eg. CA
        @property (readonly, copy) NSString *subAdministrativeArea; 
        // county, eg. Santa Clara
        @property (readonly, copy) NSString *postalCode; 
        // zip code, eg. 95014
        @property (readonly, copy) NSString *ISOcountryCode; 
        // eg. US
        @property (readonly, copy) NSString *country; 
        // eg. United States
        @property (readonly, copy) NSString *inlandWater; 
        // eg. Lake Tahoe
        @property (readonly, copy) NSString *ocean; 
        // eg. Pacific Ocean
        @property (readonly, copy) NSArray *areasOfInterest; 
        // eg. Golden Gate Park
    
            
    
    
      