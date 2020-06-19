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

@interface ViewController () <WMAdPageViewDelegate, UIScrollViewDelegate>
{
    CGFloat _HeadHeight;
}

@property (weak, nonatomic) IBOutlet WMAdPageView *adPageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHLayout;   // 控制下拉时轮播放大
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headTopLayout; // 控制上滚时轮播跟随上滚
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ViewController

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _adPageView.dotPosition = WMAdPageDotRight;
    [_adPageView setAdsWithImages:@[@"m1", @"m2", @"m3", @"m4", @"m5"]
                            block:^(NSInteger clickIndex) {
                                NSLog(@"%ld", (long)clickIndex);
                            }];
    
//    _adPageView.delegate = self;
//    [_adPageView setAdsWithImages:@[@"xxxurl", @"xxxurl", @"xxxurl", @"xxxurl"]
//                            block:^(NSInteger clickIndex){
//                                NSLog(@"%ld", (long)clickIndex);
//                            }];
    [_adPageView setBAutoRoll:YES];//小美这种方式开启自动轮播效果不好
    
    _HeadHeight = 112/*原始高度*/ * kScreen_Width / 320/*原始宽度*/;
    _headHLayout.constant = _HeadHeight;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _scrollView.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.y);
    if (scrollView.contentOffset.y < 0) {
        _headHLayout.constant = _HeadHeight - scrollView.contentOffset.y;
        if (_headTopLayout.constant != 0) {
            _headTopLayout.constant = 0;
        }
    } else {
        _headTopLayout.constant = -scrollView.contentOffset.y;
    }
}

#pragma mark - WMAdPageViewDelegate
- (void)setWebImage:(UIImageView *)imgView imgUrl:(NSString *)imgUrl
{
    // 例如
    //[imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default"]];
}

@end
