//
//  CycleCollectionViewCell.h
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/10.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CycleCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) NSString *imageStr;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleLab;
//@property (copy, nonatomic) NSString *title;

@end


