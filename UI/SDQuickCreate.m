//
//  SDQuickCreate.m
//  SuperDeer
//
//  Created by liulei on 2018/9/26.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDQuickCreate.h"
#import "UIView+SDExtension.h"
#import <Masonry/Masonry.h>
#import "NSString+SDExtension.h"

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
    
    UIView *noDataView = [self initNoDataViewFromView:view withText:text frame:view.bounds imageName:@""];
    
    return noDataView;
}

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text
                             frame:(CGRect)frame
                         imageName:(NSString *)imageName {
    
    UIView *noDataView = [[UIView alloc] initWithFrame:frame];
    noDataView.backgroundColor = [UIColor whiteColor];
    [view addSubview:noDataView];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((noDataView.width - 120)/2, noDataView.height/2 - 120, 120, 120)];
    if ([NSString isEmpty:imageName]) {
        imageView.image = [UIImage imageNamed:@"sd_noData.png"];
    }
    else {
        imageView.image = [UIImage imageNamed:imageName];
    }
    [noDataView addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageView.bottom + 10, noDataView.width, 14)];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor colorWithRed:0.80 green:0.80 blue:0.80 alpha:1.00];
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

+ (UIImage *)getLauchImage {
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOrientation = @"Portrait";
    NSString *lauchImage = nil;
    NSArray *imagesDic = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dic in imagesDic) {
        
        CGSize imageSize = CGSizeFromString((dic[@"UILaunchImageSize"]));
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dic[@"UILaunchImageOrientation"]]) {
            lauchImage = dic[@"UILaunchImageName"];
        }
    }
    
    return [UIImage imageNamed:lauchImage];
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
    
    [header setImages:@[image3, image3, image3, image1, image2, image3] forState:MJRefreshStateIdle];
    [header setImages:@[image5, image3, image4, image3] duration:0.8 forState:MJRefreshStateRefreshing];
    [header setImages:@[image3] forState:MJRefreshStateNoMoreData];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(header);
        make.width.height.mas_equalTo(header.mj_h/2);
    }];
    [header.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(header.gifView.mas_bottom).offset(5);
        make.width.mas_equalTo(header);
    }];
    
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
    
    [header setImages:@[image3, image3, image3, image1, image2, image3] forState:MJRefreshStateIdle];
    [header setImages:@[image5, image3, image4, image3] duration:0.8 forState:MJRefreshStateRefreshing];
    [header setImages:@[image3] forState:MJRefreshStateNoMoreData];
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header.gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(header);
        make.width.height.mas_equalTo(header.mj_h/2);
    }];
    [header.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(header.gifView.mas_bottom).offset(5);
        make.width.mas_equalTo(header);
    }];
    
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

+(NSMutableAttributedString *)setLineSpacingAndParagraphSpacingWithContent:(NSString *)content LineSpacing:(CGFloat )LineSpacing ParagraphSpacing:(CGFloat)ParagraphSpacing{
    
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:LineSpacing];     //行间距
    [paragraphStyle setParagraphSpacing:ParagraphSpacing];//段间距
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [content length])];
    return attributedString;
}

+ (NSMutableAttributedString *)initMutableAttributedWithString:(NSString *)string attributes:(NSArray<NSDictionary *> *)attributeArray attributeTexts:(NSArray<NSString *> *)attributeTextArray {
    
    if ([NSString isEmpty:string]) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    for (NSInteger index = 0; index < attributeTextArray.count && index < attributeArray.count; index++) {
        
        NSString *attributeText = [attributeTextArray objectAtIndex:index];
        NSRange range = [string rangeOfString:attributeText];
        NSDictionary *attribute = [attributeArray objectAtIndex:index];
        [attributedString addAttributes:attribute range:range];
    }
    
    return attributedString;
}

+ (NSMutableAttributedString *)initMutableAttributedWithString:(NSString *)string attributes:(NSArray<NSDictionary *> *)attributeArray attributeRanges:(NSArray<NSString *> *)attributeRangeArray {
    
    if ([NSString isEmpty:string]) {
        return [[NSMutableAttributedString alloc] initWithString:@""];
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    for (NSInteger index = 0; index < attributeRangeArray.count && index < attributeArray.count; index++) {
        
        NSString *attributeRangeString = [attributeRangeArray objectAtIndex:index];
        NSRange range = NSRangeFromString(attributeRangeString);
        NSDictionary *attribute = [attributeArray objectAtIndex:index];
        [attributedString addAttributes:attribute range:range];
    }
    
    return attributedString;
}

@end
