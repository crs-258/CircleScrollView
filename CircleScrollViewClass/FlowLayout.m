//
//  FlowLayout.m
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/10.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import "FlowLayout.h"

static const CGFloat ITEMSIZE = 200;

@implementation FlowLayout

-(void)prepareLayout{
    
    [super prepareLayout];
    self.itemSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, ITEMSIZE);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.minimumLineSpacing = 0;
    
}



@end
