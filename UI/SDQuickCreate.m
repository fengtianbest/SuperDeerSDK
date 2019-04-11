//
//  SDQuickCreate.m
//  SuperDeer
//
//  Created by liulei on 2018/9/26.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDQuickCreate.h"
#import "UIView+SDExtension.h"

@implementation SDQuickCreate

+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                         addToView:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = textColor;
    [view addSubview:label];
    
    return label;
}

+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                     textAlignment:(NSTextAlignment)textAlignment
                         addToView:(UIView *)view {
    
    UILabel *label = [self initLabelWithFontSize:fontSize textColor:textColor addToView:view];
    label.textAlignment = textAlignment;
    
    return label;
}

+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                         textAlignment:(NSTextAlignment)textAlignment
                             addToView:(UIView *)view {
    
    UILabel *label = [self initLabelWithBoldFontSize:fontSize textColor:textColor addToView:view];
    label.textAlignment = textAlignment;

    return label;
}

+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                         addToView:(UIView *)view {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.font = [UIFont boldSystemFontOfSize:fontSize];
    label.textColor = textColor;
    [view addSubview:label];
    
    return label;
}

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text{

    UIView *noDataView = [self initNoDataViewFromView:view withText:text frame:view.bounds];
    
    return noDataView;
}

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text
                             frame:(CGRect)frame {
    
    UIView *noDataView = [[UIView alloc] initWithFrame:frame];
    noDataView.backgroundColor = [UIColor whiteColor];
    [view addSubview:noDataView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((noDataView.width - 120)/2, noDataView.height/2 - 120, 120, 120)];
    imageView.image = [UIImage imageNamed:@"sd_noData.png"];
    [noDataView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 10, noDataView.width, 14)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.00];
    label.text = text;
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    
    NSArray *array = [text componentsSeparatedByString:@"\n"];
    if (array.count > 1) {
        label.height = array.count*18;
    }
    
    [noDataView addSubview:label];
    
    return noDataView;
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (refreshingBlock) {
            refreshingBlock();
        }
    }];
    UIImage *image1 = [UIImage imageNamed:@"header_gif_1.png"];
    UIImage *image2 = [UIImage imageNamed:@"header_gif_2.png"];
    UIImage *image3 = [UIImage imageNamed:@"header_gif_3.png"];
    UIImage *image4 = [UIImage imageNamed:@"header_gif_4.png"];
    UIImage *image5 = [UIImage imageNamed:@"header_gif_5.png"];
    
    header.gifView.center = header.center;
    header.gifView.size = CGSizeMake(header.mj_h/2, header.mj_h/2);
    header.stateLabel.frame = CGRectMake(0, header.gifView.bottom + 3, header.width, 14);

    [header setImages:@[image3, image3, image3, image1, image2, image3] forState:MJRefreshStateIdle];
    [header setImages:@[image5, image3, image4, image3] duration:0.8 forState:MJRefreshStateRefreshing];
    [header setImages:@[image3] forState:MJRefreshStateNoMoreData];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.stateLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.0];
    [header setTitle:@"继续往下拉" forState:MJRefreshStateIdle];
    [header setTitle:@"拼命加载中..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"该放手了，我要刷新啦..." forState:MJRefreshStatePulling];
    
    return header;
}

+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock refreshingStartStr:(NSString *)refreshingStartStr refreshingStr:(NSString *)refreshingStr refreshingEndStr:(NSString *)refreshingEndStr{
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        if (refreshingBlock) {
            refreshingBlock();
        }
    }];
    UIImage *image1 = [UIImage imageNamed:@"header_gif_1.png"];
    UIImage *image2 = [UIImage imageNamed:@"header_gif_2.png"];
    UIImage *image3 = [UIImage imageNamed:@"header_gif_3.png"];
    UIImage *image4 = [UIImage imageNamed:@"header_gif_4.png"];
    UIImage *image5 = [UIImage imageNamed:@"header_gif_5.png"];
    
    header.gifView.center = header.center;
    header.gifView.size = CGSizeMake(header.mj_h/2, header.mj_h/2);
    header.stateLabel.frame = CGRectMake(0, header.gifView.bottom + 3, header.width, 14);

    [header setImages:@[image3, image3, image3, image1, image2, image3] forState:MJRefreshStateIdle];
    [header setImages:@[image5, image3, image4, image3] duration:0.8 forState:MJRefreshStateRefreshing];
    [header setImages:@[image3] forState:MJRefreshStateNoMoreData];
    header.lastUpdatedTimeLabel.hidden = YES;

    header.stateLabel.font = [UIFont systemFontOfSize:12];
    header.stateLabel.textColor = [UIColor colorWithRed:0.60 green:0.60 blue:0.60 alpha:1.0];
    [header setTitle:refreshingStartStr forState:MJRefreshStateIdle];
    [header setTitle:refreshingStr forState:MJRefreshStateRefreshing];
    [header setTitle:refreshingEndStr forState:MJRefreshStatePulling];
    
    return header;
}

+ (UIImageView *)initGraySepLineWithFrame:(CGRect)frame addToView:(UIView *)view {
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:frame];
    line.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
    [view addSubview:line];
    
    return line;
}

@end
