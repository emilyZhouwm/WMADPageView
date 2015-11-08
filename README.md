#看腻了的轮播？试试带点推拉效果的轮播吧
###可无限循环
###可拉伸放大
###可外部加载网络图片
###可设置页面指示位置
###自定义页面指示样式动效
###简单使用：
	
	#import "WMAdPageView.h"

    _adPageView.dotPosition = WMAdPageDotRight;
    [_adPageView setAdsWithImages:@[@"m1", @"m2", @"m3", @"m4", @"m5"]
                            block:^(NSInteger clickIndex){
                                NSLog(@"%ld", (long)clickIndex);
                            }];
                            
   
#可以直接拖入使用或者：                         
##pod 'WMADPageView', :git => 'https://github.com/emilyZhouwm/WMADPageView.git'
##或者将来可以
##pod 'WMADPageView', '~> 0.1.0'
# 
                      
###网络图片方式：                        
	_adPageView.delegate = self;
    [_adPageView setAdsWithImages:@[@"xxxurl", @"xxxurl", @"xxxurl", @"xxxurl"]
                            block:^(NSInteger clickIndex){
                                NSLog(@"%ld", (long)clickIndex);
                            }];
    [_adPageView setBAutoRoll:YES];
    
    #pragma mark - WMAdPageViewDelegate
	- (void)setWebImage:(UIImageView *)imgView imgUrl:(NSString *)imgUrl
	{
	    // 例如
	    [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"default"]];
	}

##自定义页面指示样式
####继承TAAbstractDotView实现方法


#####欢迎star交流
图片版权：考满分网
 
![](./xmADPage.gif)
![](./xiaomeiADPage.gif)
