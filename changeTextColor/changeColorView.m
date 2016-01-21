//
//  changeColorView.m
//  changeTextColor
//
//  Created by wordoor－z on 15/12/9.
//  Copyright © 2015年 wzx. All rights reserved.
//

#import "changeColorView.h"

@implementation changeColorView
{
    UIView * midView;
    CGFloat height;
    UIView * labelView;
}
-(instancetype)initWithFrame:(CGRect)frame andTitleArr:(NSArray *)titleArr
{
    if (self == [super initWithFrame:frame])
    {
        height = self.frame.size.height / titleArr.count;
        self.backgroundColor = [UIColor grayColor];
        for (int i = 0;i < titleArr.count ; i++)
        {
        [self addSubview:[self returnLabel:titleArr[i] andFrame:CGRectMake(0, i*height, self.frame.size.width, height) andColor:[UIColor blackColor]]];
        }
        midView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, height)];
        midView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.8];
        midView.clipsToBounds = YES;
        midView.userInteractionEnabled = YES;
        [self addSubview:midView];
        
        labelView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, midView.frame.size.width, midView.frame.size.height)];
        [midView addSubview:labelView];
        
        for (int i = 0;i < titleArr.count ; i++)
        {
            [labelView addSubview:[self returnLabel:titleArr[i] andFrame:CGRectMake(0, i*height, self.frame.size.width, height) andColor:[UIColor whiteColor]]];
        }
        
        UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
        [midView addGestureRecognizer:pan];
    }
    return self;
}
-(void)pan:(UIPanGestureRecognizer *)sender
{
    switch (sender.state)
    {
        case UIGestureRecognizerStateBegan:
            NSLog(@"began");
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint pt = [sender translationInView:midView];
            CGRect rect = midView.frame;
            CGRect rect2 = labelView.frame;
            
            if (pt.y < 0 ) {
                pt.y = 0;
            }
            if (pt.y > self.frame.size.height - height)
            {
                pt.y = self.frame.size.height - height;
            }
            rect.origin.y = pt.y;
            rect2.origin.y = -pt.y;
            midView.frame = rect;
            labelView.frame = rect2;
            NSLog(@"change %@",NSStringFromCGPoint(rect2.origin));
            
        }
            break;
            case UIGestureRecognizerStateEnded:
        {

        }
            break;
        default:
            break;
    }
}
-(UILabel *)returnLabel:(NSString *)title andFrame:(CGRect)rect andColor:(UIColor *)color
{
    UILabel * label = [[UILabel alloc]initWithFrame:rect];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = color;
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}
@end
