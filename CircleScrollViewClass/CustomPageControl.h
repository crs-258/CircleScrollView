//
//  CustomPageControl.h
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/21.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomPageControl : UIPageControl

//-(id)intiWithAllpage:(NSInteger)allPages;

@property(nonatomic) NSInteger allPages ;//总共几页
@property(nonatomic) NSInteger selectPage ;//当前页的下标


@property (nonatomic,strong) UIColor *currentColor ;//当前选中填充满的颜色
@property (nonatomic,strong) UIColor *normalColor ;//正常的边框颜色


//@property (nonatomic) CGFloat dotWidth ;//点的width
//@property (nonatomic) CGFloat dotHeight ;//点的width

@property (nonatomic) CGSize dotSize ;//点的width

@property (nonatomic) CGFloat dotsSpace ;//点见的间距--默认点间的间距12

@property (nonatomic) CGFloat selectPageControlRate ;//选中后放大的倍数，值必须 >1 --只针对圆形,当设置了宽高不相等时改属性作用无效



@end
