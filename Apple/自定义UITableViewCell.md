# 自定义UITableViewCell

<!-- create time: 2014-10-01 20:44:48  -->
#通过Xib文件创建自定义的TableviewCell


##通过xib描述一个tableviewcell
    
     在xib中Table View Cell属性里设置identifier 
     e.g “tableviewcell”，方便在缓存池寻找
     
##继承UITableViewCell类来编写自定义的cell类 ->zhuTableViewCell

    将xib文件中的custom class 指定为自定类。
    
> ```在自定义类中完成创建cell和设置cell的数据。```
    
 objective-c:
 
     +(instancetype)zhuTableViewCellWithTableView:(UITableView *)tableview
    {   
        ZTableViewCell *cell = [tableview 
            dequeueReusableCellWithIdentifier:@"tableviewcell"];
        if (cell == nil) {
            //通过UINib 找到资源文件夹中的自定义xib bundle参数nil代表mainbundle
            UINib *nib = [UINib nibWithNibName:@"ZTableViewCell" bundle:nil];
            cell = [[nib instantiateWithOwner:nil options:nil]lastObject];
        }
        return cell;
    }

设置控件的数据，通过创建的外部方法获取控制器传入的模型数据，将模型数据设置在各个控件上。
##在控制器中通过ZhuCell创建cell


objective-c:

    -(UITableViewCell *)tableView:(UITableView *)tableView 
            cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        ZTableViewCell *cell = [ZTableViewCell     
            zTableViewCellWithTableView:self.tableview];
        [cell setDataModel:self.datas[indexPath.row]];
        return cell;
    }

#通过代码创建TableViewCell

1. 分析代码创建TableViewCell的必要性。

    * 目标Cell的空间超出系统自带的View的范围
    * 每个Cell高度不一致，无法通过xib创建的的xib描述。
    * 自定义Cell中的空间数目不一致，且每个Cell内的控件位置需要根据情况变更。
    
2. 创建自定义Cell的难点。

    * Cell的每个控件的位置需要根据传入的模型数据来进行设置。
    * Cell的高度需要在Cell创建之前通知给TableView的代理方法，来设置Cell的高度（代理方法要求所有的Cell的高度，而不是屏幕内可见的高度）。
    
3. 解决方案。

    * 第一个可以在创建Cell的同时，在初始化方法中添加控件（并不设置数据和frame），再将模型数据传递给自定义Cell类的对象，在模型的set方法中设置每个Cell的数据和frame。
    * 第一个方案不能解决Cell的高度问题。新建一个Frame模型，专门存储Cell的每个控件的frame，和数据的模型。并在frame模型中算出cell的高度。再代理方法中，将frame模型的高度传递给代理方法。再自定义Cell类中传递frame模型（包含frame和数据模型），再进行设置Cell的数据和frame。
    
    
    
##步骤:

   1. 如果一个Controller中仅有一个TableView，可讲Controller继承自UITableViewController
 这样控制器将自动连接TableView的数据源方法和代理方法，并且self.view指的是UITableView。
   2. 设置数据模型。
   3. 设置frame模型。
       * 将每个控件的frame数据属性设置为nonatomic, assign, ```readonly```
       * 并在头文件中设置cell的高度和数据模型属性。
       * 在set数据模型中的方法中计算每个cell空间内的frame。
   4. 创建自定义类继承自UITableViewCell类。
       
       * 重写initWithStyle方法。
       
       Objective-C:
       
           - (instancetype)initWithStyle:(UITableViewCellStyle)style 
                   reuseIdentifier:(NSString *)reuseIdentifier
        {
            self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
            if (self) {
                [self addView]; //仅添加空间和设置一次性的属性设置。
            }
            return self;
        }
       * 声明一个类方法，方便控制器创建cell对象（隐藏cell创建的细节和cell设置的标记）
       
         Objective-C:
             
             +(instancetype)tableViewCellData:(UITableView *)tableview
             {
                static NSString *ID = @"state";
                 ZhuTableViewCell *cell = [tableview 
                                     dequeueReusableCellWithIdentifier:ID];
                if (cell == nil) {
                     cell = [[ZhuTableViewCell 
                             alloc]initWithStyle:UITableViewCellStyleDefault     
                                         reuseIdentifier:ID];
                }
                return cell;
            }

       * 重写set frame模型的方法。//细节 Cell类中已有frame变量，千万不要设置frame为属性名，不然每次运行完初始化方法，就自动调用setFrame方法（即控制器未运行到cell.frame = frame）。
       
       Objective-C:
 
           -(void)setFrames:(ZhuFrame *)frames
            {
                _frames = frames;  //不要把set方法的方法名写为setFrame方法。
                [self setData];     //将frame模型中的数据模型拿出，传递给每个控件
                [self setFrames];  //将frame模型中的各空间的frame，设置给cell控件。

            }    

    5. 控制器方面
    
        * 数组中存放frame数据模型，而不是之前的单纯的数据模型
        * 在tableview的数据源方法中通过自定义的类方法创建cell（向cell.contentview添加控件），并将控制器的frame模型数据，赋值给自定义cell对象的frames（不能写frame）属性（以调用cell类里面的setFrames方法，为cell设置数据和frame）。
        * 在tableview的代理方法中将frame存储的cell高度返回设置高度。
 
 
### 其中补充的知识。

    获取一段文字的的宽高。
    需要的几个属性，字体的font，字体显示的最大范围。返回一个CGRect对象，其中可以获得这段文字的宽高。
    
  Objective-C:
  
      NSString *demo = @"HelloHello";
      
      //获取font的一个字典数据 假设 self.labelView.font = [UIFont systemFontOfSize:13];
      //设置宏 #define stateFont [UIFont systemFontOfSize:13]
      NSDictionary *stateFonts = @{NSFontAttributeName : stateFont};
      
      //设置文字的最大显示范围
      CGSize sizes ＝ CGSizeMake(MAXFLOAT, MAXFLOAT) //将返回文字的真实尺寸
      CGSize sizes ＝ CGSizeMake(320, MAXFLOAT)  //最宽为屏幕的宽度，长度不限
      CGSize sizes ＝ CGSizeMake(320, 50)    // 如果文字超过这个数值，将返回这个数值。
      
      
      //调用下面的方法
      [self fontSize:sizes WithFont:(NSDictionary *) stateFonts 
          withNString:demo];
      
      //封装好的一个方法。
      -(CGRect)fontSize:(CGSize)size WithFont:(NSDictionary *) fontDisc 
          withNString:(NSString *)text
    {
    
        CGRect fontSize = [text boundingRectWithSize:size 
            options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDisc 
                context:nil]; 
                //NSStringDrawingUsesLineFragmentOrigin 枚举类型，这个返回较精确。
        return fontSize;
    }

   