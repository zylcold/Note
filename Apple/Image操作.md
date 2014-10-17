# Image操作

<!-- create time: 2014-10-16 23:55:52  -->

##裁减图片为圆角矩形的方法

 1. 通过Quartz2D实现裁减
 2. 通过layer图层提供的方法进行裁剪
     
     objective-c:
     
         self.iconImage.layer.cornerRadius = 8; //拿到image的图层，并将图层的周围半径
         self.iconImage.clipsToBounds = YES;    //是否裁减超出图层的图像。默认NO