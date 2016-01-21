//
//  ViewController.m
//  changeTextColor
//
//  Created by wordoor－z on 15/12/9.
//  Copyright © 2015年 wzx. All rights reserved.
//

#import "ViewController.h"
#import "changeColorView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray * titleArr = @[@"test1",@"test2",@"test3"];
    changeColorView * change = [[changeColorView alloc]initWithFrame:CGRectMake(100, 100, 200, 400) andTitleArr:titleArr];
    change.layer.shadowColor = [UIColor blackColor].CGColor;
    change.layer.shadowOffset = CGSizeMake(0.5, 0.5);
    change.layer.shadowOpacity = 0.8;
    change.layer.shadowRadius = 5;
    [self.view addSubview:change];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
