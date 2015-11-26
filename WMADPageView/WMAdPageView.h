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
/* 假如在外部加载图片 */
- (void)setWebImage:(UIImageView *)imgView imgUrl:(NSString *)imgUrl;
@end

@interface WMAdPageView : UIView

/* 热点样式自定义，继承TAAbstractDotView并实现其方法，比如WMDotView */
+ (void)setCellClass:(Class )cellClass;

/* 设置是否自动滚动，在页面切换的过程中，可以开启与暂停计时器 */
@property (nonatomic, assign) BOOL bAutoRoll;


@property (nonatomic, assign) WMAdPageDotPosition dotPosition;  // 热点位置，默认居中
@property (nonatomic, assign) NSInteger dotSpacing;             // 热点间距，默认8

/* 设置是否为网络图片 */
@property (nonatomic, assign) BOOL bWebImage;
/* 如果为网络图片，可在外部用SDWebImage加载图片，内部只有dataWithContentsOfURL */
@property (nonatomic, assign) id<WMAdPageViewDelegate> delegate;

/* 设置轮播图片组，可以是本地图片或者url */
- (void)setAdsWithImages:(NSArray *)imageArray block:(WMAdPageCallback)block;

@end
