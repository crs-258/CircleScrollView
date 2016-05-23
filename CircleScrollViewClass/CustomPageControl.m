//
//  CustomPageControl.m
//  RSCycleScrollViewDemo
//
//  Created by 陈荣山 on 16/5/21.
//  Copyright © 2016年 陈荣山. All rights reserved.
//

#import "CustomPageControl.h"

static const CGFloat KDotWidth = 8;
static const CGFloat KDotHeight = 8;
static const CGFloat KDotmarginSpace = 12.0f;
static const CGFloat KSelfFrameHeight = 30;
static const CGFloat KSelectPageControlRate = -1.5;

@implementation CustomPageControl

//-(id)intiWithAllpage:(NSInteger)allPages{
//  
//   self.allPages=allPages;
//    
//    
//    
//    return self;
//    
//}
- (id)init
{
    self = [self initWithFrame: CGRectZero] ;
    return self ;
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame: frame]))
    {
        self.backgroundColor = [UIColor clearColor] ;
   
    }
//    self.layer.borderWidth=1;
    return self ;
}




- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext() ;
    CGContextSaveGState(context) ;
    CGContextSetAllowsAntialiasing(context, TRUE) ;
    
    CGFloat dotW = (self.dotSize.width > 0) ? self.dotSize.width : KDotWidth ;
    CGFloat dotH = (self.dotSize.height > 0) ? self.dotSize.height : KDotHeight ;
    CGFloat space = (self.dotsSpace > 0) ? self.dotsSpace : KDotmarginSpace ;
    CGFloat rate = self.selectPageControlRate>1 ? - self.selectPageControlRate : KSelectPageControlRate;
    
    CGFloat changeWidth= (-rate-1)*dotW;
    
    if (self.dotSize.width>0&&self.dotSize.width!=self.dotSize.height) {
        //矩形的形状把选中比例设置为无效
        changeWidth=0;
    }
    
    CGFloat x = (changeWidth-dotW)/2;
    x=x<0?0:x;
    CGFloat y = (KSelfFrameHeight-dotH)/2;
    
 
    
    UIColor *currentColor=self.currentColor ? self.currentColor : [UIColor redColor];
    UIColor *normalColor=self.normalColor ? self.normalColor : [UIColor purpleColor];
    
    
    for (int i = 0 ; i < self.allPages ; i++){
        CGRect dotRect = CGRectMake(x, y, dotW, dotH) ;
        
        if (self.selectPage==i) {
            if (self.dotSize.width>0&&self.dotSize.width!=self.dotSize.height) {
                //画矩形--点的形状
                CGContextSetFillColorWithColor(context, currentColor.CGColor);
                CGContextFillRect(context, dotRect);
            }else{
                //画圆形--点的形状
                CGContextSetFillColorWithColor(context, currentColor.CGColor) ;
                CGContextFillEllipseInRect(context, CGRectInset(dotRect, rate, rate)) ;
            }
        }else{
            
            if (self.dotSize.width>0&&self.dotSize.width!=self.dotSize.height) {
            //画矩形--点的形状
//                CGContextSetStrokeColorWithColor(context, normalColor.CGColor) ;
                CGContextSetStrokeColorWithColor(context, normalColor.CGColor) ;
                CGContextStrokeRect(context, dotRect);
                
            }else{
              //画圆形--点的形状
                CGContextSetStrokeColorWithColor(context, normalColor.CGColor) ;
                CGContextStrokeEllipseInRect(context, dotRect) ;
            }
        }
        
        x += dotW + space ;
    
    }
    CGContextRestoreGState(context);
}

-(void)setAllPages:(NSInteger)allPages{
    if (allPages<=1) {
        [self setHidden: YES] ;
    }else{
        self.hidden=NO;
    }
    _allPages=allPages;
    
    [self setNeedsDisplay] ;
    [self setFrame:self.frame];
}
-(void)setSelectPage:(NSInteger)selectPage{
    _selectPage=selectPage;
    [self setNeedsDisplay] ;
}
-(void)setCurrentColor:(UIColor *)currentColor{
    
    _currentColor=currentColor;
    [self setNeedsDisplay] ;

}
-(void)setNormalColor:(UIColor *)normalColor{
    if (normalColor==nil) {
//        return;
    }
    _normalColor=normalColor;
    [self setNeedsDisplay] ;
}

-(void)setDotSize:(CGSize)dotSize{
    
    _dotSize=dotSize;
    [self setNeedsDisplay] ;
    
    [self setFrame:CGRectZero];
    
}
-(void)setDotsSpace:(CGFloat)dotsSpace{
    
    _dotsSpace=dotsSpace;
    [self setNeedsDisplay] ;
}
-(void)setSelectPageControlRate:(CGFloat)selectPageControlRate{
    
    _selectPageControlRate=selectPageControlRate;
    
    [self setNeedsDisplay];
    
    [self setFrame:self.frame];
}
- (void)setFrame:(CGRect)aFrame{
    CGRect preFrame=aFrame;
    aFrame.size = [self sizeForNumberOfPages: self.allPages] ;
    
    float changeWidth=0;
    
    if (preFrame.size.width!=aFrame.size.width) {
        changeWidth=aFrame.size.width-preFrame.size.width;
    }
    
    super.frame = CGRectMake(preFrame.origin.x-changeWidth, preFrame.origin.y, aFrame.size.width, aFrame.size .height) ;

}
- (CGSize)sizeForNumberOfPages:(NSInteger)pageCount
{
    
    CGFloat dotW = (self.dotSize.width > 0) ? self.dotSize.width : KDotWidth ;
//    CGFloat dotH = (self.dotSize.height > 0) ? self.dotSize.height : KDotHeight ;
    CGFloat space = (self.dotsSpace > 0) ? self.dotsSpace : KDotmarginSpace ;
    CGFloat rate = self.selectPageControlRate>1 ? - self.selectPageControlRate : KSelectPageControlRate;
    
    CGFloat changeWidth= ((-rate-1)*dotW)/2;
    if (self.dotSize.width>0&&self.dotSize.width!=self.dotSize.height) {
        //矩形的形状把选中比例设置为无效
        changeWidth=0;
    }
    
    CGFloat dotsWidth = self.allPages * dotW + MAX(0, self.allPages - 1) * space +changeWidth;
    
    
    return CGSizeMake(dotsWidth,30) ;
}

@end




















