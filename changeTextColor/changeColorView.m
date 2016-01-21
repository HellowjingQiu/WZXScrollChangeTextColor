//
//  changeColorView.m
//  changeTextColor
//
//  Created by wordoor－z on 15/12/9.
//  Copyright © 2015年 wzx. All rights reserved.
//

#import "changeColorView.h"

@interface changeColorView ()

/**
 *  最外层的View
 */
@property(nonatomic,strong) UIView * labelView;

/**
 *  中间的View
 */
@property(nonatomic,strong) UIView * midView;

/**
 *  单个格子的高度
 */
@property(nonatomic,assign) CGFloat  height;

@end
@implementation changeColorView

- (instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr
{
    if (self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];

        _height = self.frame.size.height / titleArr.count;
        
        //添加最里层Label
        for (int i = 0;i < titleArr.count ; i++)
        {
          [self addSubview:[self returnLabel:titleArr[i] andFrame:CGRectMake(0, i*_height, self.frame.size.width, _height) andColor:[UIColor blackColor]]];
        }
        
        _midView = ({
          UIView * midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, _height)];
            midView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
            //设置不显示超出的部分
            midView.clipsToBounds = YES;
            midView.userInteractionEnabled = YES;
            midView;
        });
        [self addSubview:_midView];
        
        _labelView = ({
            UIView * labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _midView.frame.size.width, _midView.frame.size.height)];
            for (int i = 0;i < titleArr.count ; i++)
            {
                [labelView addSubview:[self returnLabel:titleArr[i] andFrame:CGRectMake(0, i*_height, self.frame.size.width, _height) andColor:[UIColor whiteColor]]];
            }
            labelView;
        });
        [_midView addSubview:_labelView];
        
        //添加拖动手势
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [_midView addGestureRecognizer:pan];
    }
    return self;
}
-(void)pan:(UIPanGestureRecognizer *)sender
{
    CGPoint pt = [sender translationInView:self];
    
    CGPoint midCenter = _midView.center;
    CGPoint labelCenter = _labelView.center;
    
    midCenter.y += pt.y;
    labelCenter.y -= pt.y;
    
    //边界
    if (midCenter.y > self.frame.size.height - _height/2.0)
    {
        midCenter.y = self.frame.size.height - _height/2.0 ;
        labelCenter.y = -self.frame.size.height + _height*1.5;
    }
    if (midCenter.y < _height/2.0)
    {
        midCenter.y = _height/2.0 ;
        labelCenter.y = _height/2.0;
    }
    
    _midView.center = midCenter;
    _labelView.center = labelCenter;
    
    [sender setTranslation:CGPointZero inView:self];
}

//自定义一个快速创建Label的方法 避免重复代码
- (UILabel *)returnLabel:(NSString *)title andFrame:(CGRect)rect andColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
@end
