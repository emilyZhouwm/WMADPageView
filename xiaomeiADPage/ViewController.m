//
//  ViewController.m
//  xiaomeiADPage
//
//  Created by zwm on 15/9/9.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "ViewController.h"
#import "WMAdPageView.h"

#define kScreen_Width [UIScreen mainScreen].bounds.size.width

@interface ViewController ()
{
    CGFloat _HeadHeight;
}

@property (weak, nonatomic) IBOutlet WMAdPageView *adPageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _adPageView.dotPosition = WMAdPageDotRight;
    [_adPageView setAdsWithImages:@[@"m1", @"m2", @"m3", @"m4", @"m5"]
                            block:^(NSInteger clickIndex){
                                NSLog(@"%ld", (long)clickIndex);
                            }];
    //[_adPageView setBAutoRoll:YES];
    
    _HeadHeight = 112 * kScreen_Width / 320;
    _headHLayout.constant = _HeadHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        _headHLayout.constant = _HeadHeight - scrollView.contentOffset.y;
    }
}

@end
