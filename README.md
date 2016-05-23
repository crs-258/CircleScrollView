# RSCycleScrollViewDemo

参考：
###https://github.com/ddeville/DDPageControl
###https://github.com/gsdios/SDCycleScrollView

###最近项目中有用到类似无限循环广告页的效果，包括滚动的样式，虽然github上有现成的，也基于自己没有动手写过类似的Demo，就顺便参考了网上的例子，自己实现下；我已经将相关的类都封装了下，主要相关的类都在CircleScrollViewClass文件夹下。改demo使用起来也比较简单；
#实现功能：
- 可以将pageControl样式设置成经典圆点类型或者矩形类型，
- 设置高亮和非高亮颜色
- 设置圆点形成大小和自定义矩形形状

 e.g
 ####在使用到的文件中导入#import "CircleScrollView.h"即可
 NSArray *imagesURLStrings = @[
                                  @"http://upload-images.jianshu.io/upload_images/640854-f47bc1d1fa3fa681.jpg",
                                  @"http://upload-images.jianshu.io/upload_images/110800-5138b97720c25340.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    NSArray *titleArr=@[@"第一个title",@"第二个title",@"第三个title"];
    
    cycleView=[[CircleScrollView alloc] initWithFrame:CGRectMake(0, 100, 320, 200) imageNetworkURLArr:imagesURLStrings placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    cycleView.pageControl.dotSize=CGSizeMake(30, 10);//设置矩形---注释掉可以默认显示经典样式
    cycleView.pageControl.currentColor=[UIColor greenColor];
    cycleView.pageControlTextAlignment=NSTextAlignmentRight;
    self.view.backgroundColor=[UIColor lightGrayColor];
    cycleView.titleArr=titleArr;
    cycleView.pageControl.selectPageControlRate=3;//设置选中的点比例大小
    [self.view addSubview:cycleView];