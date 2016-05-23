//
//  CycleCollectionViewCell.m
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/10.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import "CycleCollectionViewCell.h"

@implementation CycleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self initWithContentView];
        
    }
    return self;
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,self.frame.size.width, self.frame.size.height)];
        [self addSubview:_imageView];
    }
    return _imageView;
}
-(UILabel *)titleLab{
    if (!_titleLab) {
        _titleLab=[[UILabel alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30, self.frame.size.width, 30)];
        _titleLab.font=[UIFont systemFontOfSize:15];
        _titleLab.textColor=[UIColor whiteColor];
        _titleLab.backgroundColor=[UIColor blackColor];
        _titleLab.alpha=0.5;
        [self addSubview:_titleLab];
    }
    return _titleLab;
}


- (void)setImageStr:(NSString *)imageStr {
    _imageStr = [_imageStr copy];
    self.imageView.image = [UIImage imageNamed:imageStr];
}

/*
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initWithContentView];
        
    }
    return self;
}

-(void)initWithContentView{
    
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    [self.contentView addSubview:imageView];

}

- (void)layoutSubviews{
    
    [super layoutSubviews];
 
     _imageView.frame = self.bounds;
    
}
*/
@end
