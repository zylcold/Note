# MapKit

<!-- create time: 2014-11-07 21:10:19  -->

##定位

    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    MKUserTrackingModeNone = 0, 
    // the user's location is not followed 不跟踪
	MKUserTrackingModeFollow, 
	// the map follows the user's location 跟踪
	MKUserTrackingModeFollowWithHeading 
	// the map follows the user's location and heading 跟踪并显示朝向

###⚠注意
    
    mapView添加跟踪标记时，会调用代理的mapView:viewForAnnotation方法
    
    - (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
    {
        //如果返回为nil，系统将执行默认操作
        //这里判断添加的大头针是系统自带还是用户自定义
        if (![annotation isKindOfClass:[MyAnnotation class]]) return nil;
        //设置缓存池标记
        static NSString *ID = @"MyAnnotation";
        //先从缓存池中取出
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
        if (!pinView) {
            //创建
            pinView = [[MKPinAnnotationView alloc]init];
            //设置动画
            pinView.animatesDrop = YES;
    
        }
        //设置模型
        pinView.annotation = annotation;
        return pinView;
    }	
    
##添加大头针

         1. 遵守MKAnnotation协议的NSObject模型
         2. [self.mapView addAnnotation:annotation]; 添加一个
            [self.mapView addAnnotations:annotations]; 添加一组
         3. 自定义大头针样式，继承MKAnnotationView
         4. 自定义大头针展示，继承MKAnnotationView，在原有基础大头针上再添加展示大头针
         
         
         
##绘制路线
    
    //创建地理编码转换对象
     CLGeocoder *geoCode = [[CLGeocoder alloc]init];
     
     //通过地名获取地标
     //一个geocode不能同时获取两个地标，应该在geocode执行完毕后，再次执行
    [geoCode geocodeAddressString:@"北京" completionHandler:^(NSArray *placemarks, NSError *error) {
       CLPlacemark *startP = placemarks[0];
       //获取第二个地标
       [geoCode geocodeAddressString:@"南京" completionHandler:^(NSArray *placemarks, NSError *error) {
            CLPlacemark *endP = placemarks[0];
            
            //创建请求
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc]init];
            //通过CLPlacemark创建MKPlacemark
            MKPlacemark *startPm = [[MKPlacemark alloc]initWithPlacemark:startP];
            //设置请求的起点
            request.source = [[MKMapItem alloc]initWithPlacemark:startPm];
            MKPlacemark *endPm = [[MKPlacemark alloc]initWithPlacemark:endP];
            //设置请求的终点
            request.destination = [[MKMapItem alloc]initWithPlacemark:endPm];
            
            //通过请求创建MKDirections
            MKDirections *direct = [[MKDirections alloc]initWithRequest:request];
            //计算路径
            [direct calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (!error) {
                    //遍历路线，并添加到mapview上
                    for (MKRoute *route in response.routes) {
                        [self.mapView addOverlay:route.polyline];
                    }
                }
            }];
        }];
    }];
    
    
    
    //实现mapview的代理方法
    - (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
    {
        //使用MKOverlayRenderer的子类创建路线
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc]initWithOverlay:overlay];
        //设置路线的颜色
        renderer.strokeColor = [UIColor blueColor];
        return renderer;
    }
    
    