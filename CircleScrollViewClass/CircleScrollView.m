//
//  CysleScrollView.m
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/10.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import "CircleScrollView.h"
#import "CycleCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
#import "FlowLayout.h"

NSString * const ID = @"cycleCell";

@interface CircleScrollView()<UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectContentView; // 显示图片的collectionView
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, assign)NSInteger totalCount;

@property (nonatomic, weak) NSTimer *timer;
@end

@implementation CircleScrollView

-(instancetype)initWithFrame:(CGRect)frame imageNetworkURLArr:(NSArray *)imageNetworkURLArr placeholderImage:(UIImage *)placeholderImage{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundImageView=[[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundImageView.image=placeholderImage;
        self.imageURLArr=[[NSMutableArray alloc] initWithArray:imageNetworkURLArr];
        
        [self initWithContentView:placeholderImage];
    }
    return self;
}
-(void)initWithContentView:(UIImage *)placeholderImage{
    
    UICollectionView *collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:[FlowLayout new]];
    collectView.pagingEnabled = YES;
    collectView.backgroundColor=[UIColor clearColor];
    self.imageContentMode=UIViewContentModeScaleAspectFill;
    [collectView registerClass:[CycleCollectionViewCell class] forCellWithReuseIdentifier:ID];
    collectView.showsHorizontalScrollIndicator = NO;
    collectView.showsVerticalScrollIndicator = NO;
    _totalCount = self.imageURLArr.count *100;
    
    collectView.dataSource = self;
    collectView.delegate = self;
    [self addSubview:collectView];
    _collectContentView = collectView;
    
    
    [self setupPageControl];
    
    
    //设置默认循环
    _autoScroll = NO;
    [self initTimer];//开启定时器轮播图片
    
    
}

//-(void)pageControlChange:(UIPageControl *)pc{
//
//    NSLog(@"当前选中index-----%d",pc.currentPage);
//
//}

#pragma mark - UICollectionViewDataSource & UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.imageURLArr.count<=1) {
        return 1;
    }else{
        return _totalCount;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CycleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (self.imageURLArr.count<=0) {
        cell.imageView.image=self.backgroundImageView.image;
        
    }else{
        long itemIndex = indexPath.item % self.imageURLArr.count;
        NSString *imagePath = self.imageURLArr[itemIndex];
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:self.backgroundImageView.image];
        
        if (self.titleArr.count>0) {
            cell.titleLab.text=[[NSString alloc] initWithFormat:@"   %@",[self.titleArr objectAtIndex:itemIndex]];
            if (self.titleTextColor) {
                cell.titleLab.textColor=self.titleTextColor;
            }
            if (self.titleFontSize>0) {
                cell.titleLab.font=[UIFont systemFontOfSize:self.titleFontSize];
            }
            cell.titleLab.hidden=self.hiddenTitle;
        }
        
        
        
        
    }
    cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.contentView.layer.borderColor=[UIColor purpleColor].CGColor;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.imageURLArr.count<=0) {
        return;
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(didSelectItemAtIndex:)]) {
        
        NSInteger itemIndex = indexPath.item % self.imageURLArr.count;
        
        [self.delegate didSelectItemAtIndex:itemIndex];
    }
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!self.imageURLArr.count) {
        return;
    }
    
    int indexOfItem = [self currentIndexPageControl];
    int indexOnPageControl = indexOfItem % self.imageURLArr.count;
    _pageControl.selectPage = indexOnPageControl;
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.autoScroll) {
        [self invalidateTimer];
    }
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.autoScroll) {
        [self initTimer];
    }
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
}

-(void)setupPageControl{
    
    self.pageControl = [[CustomPageControl alloc] init];
    self.pageControl.allPages=self.imageURLArr.count;
    self.pageControl.selectPage=0;
    
    //默认居右显示
    self.pageControl.frame=CGRectMake(self.frame.size.width-self.pageControl.frame.size.width-20,self.frame.size.height-self.pageControl.frame.size.height,self.pageControl.frame.size.width,self.pageControl.frame.size.height);
    
    self.pageControl.userInteractionEnabled = NO;
    
    [self addSubview:self.pageControl];
    
}

- (void)invalidateTimer
{
    [_timer invalidate];
    _timer = nil;
}
-(void)automaticScroll{
    if (0 == _imageURLArr.count||_imageURLArr.count==1) return;
    int currentIndex = [self currentIndexPageControl];
    int targetIndex = currentIndex + 1;
    if (targetIndex >= _totalCount) {
        targetIndex = _totalCount * 0.5;
        [_collectContentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }else{
        [_collectContentView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

-(int)currentIndexPageControl{
    
    int index = 0;
    index = (_collectContentView.contentOffset.x+ self.frame.size.width * 0.5) /self.frame.size.width;
    
    return index;
}

-(void)setImageURLArr:(NSArray *)imageURLArr{
    if (imageURLArr==nil) {
        imageURLArr=@[];
    }
    _imageURLArr=imageURLArr;
    self.pageControl.allPages=_imageURLArr.count;
    [_collectContentView reloadData];
}
-(void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll=autoScroll;
    
    [self invalidateTimer];
    
    if (_autoScroll) {
        [self initTimer];
    }
}



-(void)setPageControlTextAlignment:(NSTextAlignment)pageControlTextAlignment{
    
    if (pageControlTextAlignment==NSTextAlignmentCenter) {
        self.pageControl.frame=CGRectMake((self.frame.size.width-self.pageControl.frame.size.width)/2, self.frame.size.height-self.pageControl.frame.size.height, self.pageControl.frame.size.width, self.pageControl.frame.size.height);
        
        
    }else{
        //默认居右NSTextAlignmentRight
        self.pageControl.frame=CGRectMake(self.frame.size.width-self.pageControl.frame.size.width-20, self.frame.size.height-self.pageControl.frame.size.height, self.pageControl.frame.size.width, self.pageControl.frame.size.height);
        
    }
}

-(void)initTimer{
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    _timer = timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)setTitleArr:(NSArray *)titleArr{
    _titleArr=titleArr;
}

-(void)setTitleFontSize:(float)titleFontSize{

    _titleFontSize=titleFontSize;
    [_collectContentView reloadData];
}

-(void)setTitleTextColor:(UIColor *)titleTextColor{
    
    _titleTextColor=titleTextColor;
    [_collectContentView reloadData];
}
-(void)setHiddenTitle:(BOOL)hiddenTitle{
    _hiddenTitle=hiddenTitle;
    [_collectContentView reloadData];
}


@end





