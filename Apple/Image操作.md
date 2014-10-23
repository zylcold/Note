# Image操作

<!-- create time: 2014-10-16 23:55:52  -->

##裁减图片为圆角矩形的方法

 1. 通过Quartz2D实现裁减
 2. 通过layer图层提供的方法进行裁剪
     
     objective-c:
     
         self.iconImage.layer.cornerRadius = 8; //拿到image的图层，并将图层的周围半径
         self.iconImage.clipsToBounds = YES;    //是否裁减超出图层的图像。默认NO
         
         
         
         
##将图片保存到系统相册

   objective-c:
   
    UIImageWriteToSavedPhotosAlbum(
            UIImage *image,         //要保存的图像
            id completionTarget,     //执行后，继续操作调用者
            SEL completionSelector,  //执行的方法
            void *contextInfo          //传入参数
    );
    
    
    官方执行后默认会给执行方法传入三个参数，因此官方建议，执行方法写
    - (void)image:(UIImage *)image didFinishSavingWithError:
               (NSError *)error contextInfo:(void *)contextInfo;
    
    其中image为保存对象
    NSError 为错误信息（成功为nil）
    contextInfo 保存时传入的参数
    
    
 
##设置图片的拉伸区域
    
    - (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets NS_AVAILABLE_IOS(5_0)  //默认以填充
    - (UIImage *)resizableImageWithCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode NS_AVAILABLE_IOS(6_0); 
    
    设置图片的拉伸区域。默认设置拉伸区域为中央的1个像素
    e.g
    
    UIImage *image = [UIImage imageName:@"demo"];
    UIImage *newImage = 
    [image resizableImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5)]
    

    UIImageResizingMode{
        UIImageResizingModeTile, 填充
        UIImageResizingModeStretch, 拉伸
    }

##设置图片是否按照系统样式

    - (UIImage *)imageWithRenderingMode:(UIImageRenderingMode)renderingMode NS_AVAILABLE_IOS(7_0); IOS7以上使用
    
     UIImageRenderingModeAutomatic,
     // Use the default rendering mode for the context where the image is used
     //使用原始样式，当有图片被使用时
    UIImageRenderingModeAlwaysOriginal,     
    // Always draw the original image, without treating it as a template
    //总是使用原始样式
    UIImageRenderingModeAlwaysTemplate,  
    // Always draw the image as a template image, ignoring its color information
    //修改为系统的默认样式


