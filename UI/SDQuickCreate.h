//
//  SDQuickCreate.h
//  SuperDeer
//
//  Created by liulei on 2018/9/26.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJRefresh.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDQuickCreate : NSObject

/**
 1.创建Label
 
 @param fontSize 字体大小
 @param textColor 字体颜色
 @param view 创建后的Label加到这个view上
 @return UILabel
 */
+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                         addToView:(UIView *)view;

+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                     textAlignment:(NSTextAlignment)textAlignment
                         addToView:(UIView *)view;
+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                             addToView:(UIView *)view;
+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                         textAlignment:(NSTextAlignment)textAlignment
                             addToView:(UIView *)view;

/**
 2.创建无数据视图
 
 @param view 创建后加到这个view上
 @param text 无数据文案
 @return UIView
 */
+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text;

/**
 3.创建无数据视图
 
 @param view 创建后加到这个view上
 @param text 无数据文案
 @param frame 在父视图中的位置大小
 @return UIView
 */
+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text
                             frame:(CGRect)frame;

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text
                             frame:(CGRect)frame
                         imageName:(NSString *)imageName;
/**
 4.创建单色图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)createImageWithColor:(UIColor *)color;


/**
 5.获取启动图
 
 @return 启动图片
 */
+ (UIImage *)getLauchImage;

/**
 6.创建下拉刷新
 
 @param refreshingBlock 下拉事件
 @return header
 */
+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;

/**
 7.创建下拉刷新
 
 @param refreshingBlock 下拉事件
 @return header
 */
+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
                                                   refreshingStartStr:(NSString *)refreshingStartStr
                                                        refreshingStr:(NSString *)refreshingStr
                                                     refreshingEndStr:(NSString *)refreshingEndStr;

/**
 8.创建分割线，默认背景色为0xEEEEEE
 
 @param frame frame
 @param view 父视图
 @return UIImageView
 */
+ (UIImageView *)initGraySepLineWithFrame:(CGRect)frame addToView:(UIView *)view;

/**
 9.创建分割线，默认背景色为0xEEEEEE
 
 @param content 文本内容
 @param LineSpacing 行间距
 @param ParagraphSpacing 段间距
 @return UIImageView
 */
+(NSMutableAttributedString *)setLineSpacingAndParagraphSpacingWithContent:(NSString *)content LineSpacing:(CGFloat )LineSpacing ParagraphSpacing:(CGFloat)ParagraphSpacing;

/// 根据string生成富文本
/// @param string 源String
/// /// @param attributeArray 需要改变的效果部分，和attributeTextArray一一对应
/// @param attributeTextArray 需要改变文字效果的string部分
+ (NSMutableAttributedString *)initMutableAttributedWithString:(NSString *)string
                                                    attributes:(NSArray<NSDictionary *> *)attributeArray
                                                attributeTexts:(NSArray<NSString *> *)attributeTextArray;

/// 根据string生成富文本
/// @param string 源String
/// /// @param attributeArray 需要改变的效果部分，和attributeTextArray一一对应
/// @param attributeRangeArray 需要改变文字效果的range部分 range转Sring方法: NSString * rangeStr = NSStringFromRange(range);
+ (NSMutableAttributedString *)initMutableAttributedWithString:(NSString *)string
                                                    attributes:(NSArray<NSDictionary *> *)attributeArray
                                               attributeRanges:(NSArray<NSString *> *)attributeRangeArray;
@end

NS_ASSUME_NONNULL_END
