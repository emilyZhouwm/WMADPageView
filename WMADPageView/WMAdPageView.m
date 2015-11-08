//
//  WMAdPageView.m
//
//  Created by zwm on 15/5/25.
//  Copyright (c) 2015年 zwm. All rights reserved.
//

#import "WMAdPageView.h"
#import "TAPageControl/TAPageControl.h"
#import "WMDotView.h"

static Class _cellClass = nil;

@interface WMAdPageView() <UIScrollViewDelegate>
@property (nonatomic, copy) NSArray *arrImage;
@property (nonatomic, assign) NSInteger indexShow;
@property (nonatomic, assign) NSInteger nextShow;
@property (nonatomic, strong) UIScrollView *scView;
@property (nonatomic, strong) UIImageView *imgPrev;
@property (nonatomic, strong) UIImageView *imgCurrent;
@property (nonatomic, strong) UIImageView *imgNext;
@property (nonatomic, strong) UIView *viewPrev;
@property (nonatomic, strong) UIView *viewCurrent;
@property (nonatomic, strong) UIView *viewNext;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, assign) WMAdPageCallback myBlock;
@property (nonatomic, strong) TAPageControl *pageControl;
@property (nonatomic, strong) NSTimer *autoRollTimer;
@end

@implementation WMAdPageView

+ (void)setCellClass:(Class)cellClass
{
    _cellClass = cellClass;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_scView) {
        _scView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0);
        [_scView setFrame:self.bounds];
        
        CGFloat w = self.frame.size.width;
        CGFloat h = self.frame.size.height;

        [_viewPrev setFrame:CGRectMake(0, 0, w, h)];
        [_viewCurrent setFrame:CGRectMake(w, 0, w, h)];
        [_viewNext setFrame:CGRectMake(2 * w, 0, w, h)];
 
        [_imgPrev setFrame:_viewPrev.bounds];
        [_imgCurrent setFrame:_viewCurrent.bounds];
        [_imgNext setFrame:_viewNext.bounds];
        
        if (_arrImage.count <= 1) {
            _scView.contentSize = CGSizeMake(w, h);
            [_scView scrollRectToVisible:CGRectMake(0, 0, w, h) animated:NO];
        } else {
            _scView.contentSize = CGSizeMake(w * 3, h);
            [_scView scrollRectToVisible:CGRectMake(w, 0, w, h) animated:NO];
        }
        
        CGRect frame;
        CGSize size = [_cellClass dotSize];
        switch (_dotPosition) {
            case WMAdPageDotLeft: {
                CGFloat width = _dotSpacing + (size.width + _dotSpacing) * _arrImage.count;
                frame = CGRectMake(0, h - kPageControlH, width, kPageControlH);
                break;
            }
            case WMAdPageDotRight: {
                CGFloat width = _dotSpacing + (size.width + _dotSpacing) * _arrImage.count;
                frame = CGRectMake(w - width, h - kPageControlH, width, kPageControlH);
                break;
            }
            default: {
                frame = CGRectMake(0, h - kPageControlH, w, kPageControlH);
                break;
            }
        }
        [_pageControl setFrame:frame];
        [_pageControl resetDotViews];
    }
}

- (void)initUI
{
    _scView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scView.delegate = self;
    _scView.pagingEnabled = YES;
    _scView.bounces = NO;
    _scView.showsHorizontalScrollIndicator = NO;
    _scView.showsVerticalScrollIndicator = NO;
    [self addSubview:_scView];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAds)];
    [_scView addGestureRecognizer:tap];
 
    CGFloat w = self.frame.size.width;
    CGFloat h = self.frame.size.height;
    _viewPrev = [[UIView alloc] initWithFrame:CGRectMake(0, 0, w, h)];
    _viewPrev.clipsToBounds = TRUE;
    _viewCurrent = [[UIView alloc] initWithFrame:CGRectMake(w, 0, w, h)];
    _viewCurrent.clipsToBounds = TRUE;
    _viewNext = [[UIView alloc] initWithFrame:CGRectMake(2 * w, 0, w, h)];
    _viewNext.clipsToBounds = TRUE;
   
    _imgPrev = [[UIImageView alloc] initWithFrame:_viewPrev.bounds];
    _imgCurrent = [[UIImageView alloc] initWithFrame:_viewCurrent.bounds];
    _imgNext = [[UIImageView alloc] initWithFrame:_viewNext.bounds];
    
    [_viewPrev addSubview:_imgPrev];
    [_viewCurrent addSubview:_imgCurrent];
    [_viewNext addSubview:_imgNext];
    [_scView addSubview:_viewPrev];
    [_scView addSubview:_viewCurrent];
    [_scView addSubview:_viewNext];
    
    _lineView = [[UIView alloc] initWithFrame:CGRectZero];
    _lineView.backgroundColor = [UIColor blackColor];
    [_scView addSubview:_lineView];
    
    if (!_cellClass) {
        _cellClass = [WMDotView class];
    }
    CGRect frame;
    CGSize size = [_cellClass dotSize];
    _pageControl = [[TAPageControl alloc] initWithFrame:frame];
    _dotSpacing = _dotSpacing > 0 ? _dotSpacing : _pageControl.spacingBetweenDots;
    _pageControl.spacingBetweenDots = _dotSpacing;
    
    switch (_dotPosition) {
        case WMAdPageDotLeft: {
            CGFloat width = _dotSpacing + (size.width + _dotSpacing) * _arrImage.count;
            frame = CGRectMake(0, h - kPageControlH, width, kPageControlH);
            break;
        }
        case WMAdPageDotRight: {
            CGFloat width = _dotSpacing + (size.width + _dotSpacing) * _arrImage.count;
            frame = CGRectMake(w - width, h - kPageControlH, width, kPageControlH);
            break;
        }
        default: {
            frame = CGRectMake(0, h - kPageControlH, w, kPageControlH);
            break;
        }
    }
    [_pageControl setFrame:frame];
    _pageControl.dotViewClass = _cellClass;
    _pageControl.dotSize = size;
    [self addSubview:_pageControl];
}

- (void)dealloc
{
    if ([_autoRollTimer isValid]) {
        [_autoRollTimer invalidate];
        _autoRollTimer = nil;
    }
}

- (void)setBAutoRoll:(BOOL)bAutoRoll
{
    _bAutoRoll = bAutoRoll;
    if ([_autoRollTimer isValid]) {
        [_autoRollTimer invalidate];
        _autoRollTimer = nil;
    }
    if (_bAutoRoll) {
        _autoRollTimer = [NSTimer scheduledTimerWithTimeInterval:kAutoRollTime target:self selector:@selector(scrollTimer) userInfo:nil repeats:YES];
    } 
}

- (void)setAdsWithImages:(NSArray *)imageArray block:(WMAdPageCallback)block
{
    if (!imageArray || imageArray.count<=0) {
        return;
    }
    _arrImage = imageArray;
    _myBlock = block;
    
    if (!_scView) {
        [self initUI];
    }
    
    if (_arrImage.count <= 1) {
        _scView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    } else {
        _scView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
    }
    _pageControl.numberOfPages = _arrImage.count;
    
    [self reloadImages];
}

- (void)tapAds
{
    if (_myBlock != NULL) {
        _myBlock(_indexShow);
    }
}

- (void)reloadImages
{
    if (_indexShow >= (int)_arrImage.count) {
        _indexShow = 0;
    }
    if (_indexShow < 0) {
        _indexShow = (int)_arrImage.count - 1;
    }
    NSInteger prev = _indexShow - 1;
    if (prev < 0) {
        prev = (int)_arrImage.count - 1;
    }
    NSInteger next = _indexShow + 1;
    if (next > _arrImage.count - 1) {
        next = 0;
    }
    
    _pageControl.currentPage = _indexShow;
    NSString *prevImage = [_arrImage objectAtIndex:prev];
    NSString *curImage = [_arrImage objectAtIndex:_indexShow];
    NSString *nextImage = [_arrImage objectAtIndex:next];
    if (_bWebImage) {
        if (_delegate && [_delegate respondsToSelector:@selector(setWebImage:imgUrl:)]) {
            [_delegate setWebImage:_imgPrev imgUrl:prevImage];
            [_delegate setWebImage:_imgCurrent imgUrl:curImage];
            [_delegate setWebImage:_imgNext imgUrl:nextImage];
        } else {
            _imgPrev.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:prevImage]]];
            _imgCurrent.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:curImage]]];
            _imgNext.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:nextImage]]];
        }
    } else {
        _imgPrev.image = [UIImage imageNamed:prevImage];
        _imgCurrent.image = [UIImage imageNamed:curImage];
        _imgNext.image = [UIImage imageNamed:nextImage];
    }
    [_scView scrollRectToVisible:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height) animated:NO];
}

// 定时换图
- (void)scrollTimer
{
    if (_arrImage.count > 1) {
        _indexShow++;
        [self reloadImages];
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x > self.frame.size.width) {
        CGFloat offset = scrollView.contentOffset.x - self.frame.size.width;
        CGRect frame = _viewCurrent.bounds;
        frame.origin.x += offset * 0.5;
        [_imgCurrent setFrame:frame];
        
        frame = _viewNext.bounds;
        frame.origin.x -= frame.size.width * 0.5;
        frame.origin.x += offset * 0.5;
        [_imgNext setFrame:frame];
        
        _lineView.hidden = FALSE;
        frame = _viewNext.frame;
        frame.size.width = 5;
        frame.origin.x -= frame.size.width * offset / self.frame.size.width;
        [_lineView setFrame:frame];
    } else if (scrollView.contentOffset.x < self.frame.size.width) {
        CGFloat offset = self.frame.size.width - scrollView.contentOffset.x;
        CGRect frame = _viewCurrent.bounds;
        frame.origin.x -= offset * 0.5;
        [_imgCurrent setFrame:frame];
        
        frame = _viewPrev.bounds;
        frame.origin.x += frame.size.width * 0.5;
        frame.origin.x -= offset * 0.5;
        [_imgPrev setFrame:frame];
        
        _lineView.hidden = FALSE;
        frame = _viewCurrent.frame;
        frame.size.width = 5;
        frame.origin.x -= frame.size.width;
        frame.origin.x += frame.size.width * offset / self.frame.size.width;
        [_lineView setFrame:frame];
    } else {
        _lineView.hidden = TRUE;
        [_imgPrev setFrame:_viewPrev.bounds];
        [_imgCurrent setFrame:_viewCurrent.bounds];
        [_imgNext setFrame:_viewNext.bounds];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.frame.size.width * 2) {
        _indexShow++;
    } else if (scrollView.contentOffset.x < self.frame.size.width) {
        _indexShow--;
    }
    [self reloadImages];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.x >= self.frame.size.width * 2) {
        _indexShow++;
    } else if (scrollView.contentOffset.x < self.frame.size.width) {
        _indexShow--;
    }
    [self reloadImages];
}

@end
