//
//  ViewController.m
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/10.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import "ViewController.h"
#import "CircleScrollView.h"



@interface ViewController ()
{
    CircleScrollView *cycleView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
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
    
    
    //设定响应相应的样式动作
    
    NSArray *btnTitleArr=@[@"刷新数据",@"隐藏标题",@"居中显示",@"居右显示"];
    
    float btnWidth=80;
    float btnHeight=40;
    for(int i=0;i<btnTitleArr.count;i++)
    {
        //一排两个，共三排
        
        int row=i/2;
        int column=i%2==0?0:1;
        float orginX=(self.view.frame.size.width/2-btnWidth)/2+self.view.frame.size.width/2*column;
        
        
        float orginY= cycleView.frame.origin.y+cycleView.frame.size.height+50+row*(btnHeight+30);
        
        
        
        UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(orginX, orginY, btnWidth, btnHeight)];
        [btn setTitle:[btnTitleArr objectAtIndex:i] forState:UIControlStateNormal];
        btn.tag=i;
        btn.layer.borderWidth=1;
        [btn addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        
    }
}

-(void)clickButtonAction:(UIButton *)sender{
    
    
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    
    NSArray *titleArr=@[@"第一个title",@"第二个title",@"第三个title",@"第四个title",@"第五个title"];
    
    if (sender.tag==0) {
        //产生0-5的随机数,不包含6
        int index=arc4random() % 5;//
        
        NSMutableArray *imgArr=[[NSMutableArray alloc] init];
        NSMutableArray *titArr=[[NSMutableArray alloc] init];
        for (int i=0; i<=index; i++) {
            [imgArr addObject:[imagesURLStrings objectAtIndex:i]];
            [titArr addObject:[titleArr objectAtIndex:i]];
        }
        cycleView.imageURLArr=imgArr;
        cycleView.titleArr=titArr;
        
    }else if (sender.tag==1){
        //隐藏标题
        cycleView.hiddenTitle=YES;
        
    }else if (sender.tag==2){
        //居中显示
        cycleView.pageControlTextAlignment=NSTextAlignmentCenter;
    }else if (sender.tag==3){
        //居右显示
        cycleView.pageControlTextAlignment=NSTextAlignmentRight;
    }
    
    
    
    
    
    
    
    //    cycleView.con
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
