//
//  WMAdPageView.h
//
//  Created by zwm on 15/5/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kPageControlH 20
#define kAutoRollTime 5

typedef NS_ENUM (NSInteger, WMAdPageDotPosition)
{
    WMAdPageDotCenter,
    WMAdPageDotLeft,
    WMAdPageDotRight,
};

@class WMAdPageView;
typedef void (^WMAdPageCallback)(NSInteger clickIndex);

@protocol WMAdPageViewDelegate <NSObject>
- (void)setWebImage:(UIImageView *)imgView imgUrl:(NSString *)imgUrl;
@end

@interface WMAdPageView : UIView

+ (void)setCellClass:(Class )cellClass; // 热点样式自定义

@property (nonatomic, assign) BOOL bAutoRoll; // 设置是否自动滚动
@property (nonatomic, assign) WMAdPageDotPosition dotPosition; // 热点位置，默认居中
@property (nonatomic, assign) NSInteger dotSpacing; // 热点间距，默认8

@property (nonatomic, assign) BOOL bWebImage; // 设置是否为网络图片
@property (nonatomic, assign) id<WMAdPageViewDelegate> delegate;// 如果为网络图片，可在外部用SDWebImage加载图片，内部只有dataWithContentsOfURL

- (void)setAdsWithImages:(NSArray *)imageArray block:(WMAdPageCallback)block;

@end
