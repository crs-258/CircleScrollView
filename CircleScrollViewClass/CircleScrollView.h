//
//  CysleScrollView.h
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/10.
//  Copyright © 2016年 陈荣山. All rights reserved.
//
/**
 *   参考：https://github.com/ddeville/DDPageControl
 *   参考：https://github.com/gsdios/SDCycleScrollView
 *
 */


#import <UIKit/UIKit.h>
#import "CustomPageControl.h"

@protocol CircleScrollViewDelete <NSObject>

@optional
/**
 *  点击图片时触发的代理协议
 *
 *  @param selectIndex 选中图片在数组中的下标
 */
-(void)didSelectItemAtIndex:(NSInteger)selectIndex;
@end

@interface CircleScrollView : UIView
/**
 *  初始化方法
 *
 *  @param frame               布局frame
 *  @param imageNetworkURLArr  网络图片url数组
 *  @param placeholderImage    默认图
 *
 *  @return 返回值
 */
-(instancetype)initWithFrame:(CGRect)frame imageNetworkURLArr:(NSArray *)imageNetworkURLArr  placeholderImage:(UIImage *)placeholderImage;

@property(nonatomic,weak)id<CircleScrollViewDelete> delegate;

/**
 *  网络图片url数组
 */
@property(nonatomic,strong)NSArray *imageURLArr;
/**
 *  对应的标题数组
 */
@property(nonatomic,strong)NSArray *titleArr;

/**
 *  图片显示方式(完全填充/原图显示...)
 */
@property(nonatomic,assign)UIViewContentMode imageContentMode;

/** 是否自动滚动,默认Yes */
@property (nonatomic,assign) BOOL autoScroll;


@property(nonatomic)NSTextAlignment pageControlTextAlignment;


@property (nonatomic,strong)CustomPageControl *pageControl;


/**
 *  设置标题字体大小
 */
@property(nonatomic,assign)float titleFontSize;
/**
 *  设置标题字体颜色
 */
@property (nonatomic,strong)UIColor *titleTextColor;

/**
 *  隐藏标题
 */
@property (nonatomic)BOOL hiddenTitle;

@end




