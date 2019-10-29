//
//  SDUIHelpers.h
//  SuperDeer
//
//  Created by liulei on 2018/6/6.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDProgressHUD.h"
#import "MJRefresh.h"

@interface SDUIHelpers : NSObject

+ (UIWindow *)window;

///-----------------------------------------
/// @name progress
///-----------------------------------------

+ (void)showProgress;
+ (void)showProgressWithText:(NSString *)text;
+ (void)showProgressWithText:(NSString *)text detailText:(NSString *)detail;
+ (void)showProgressWhileExecutingBlock:(dispatch_block_t)block;
+ (void)showProgressWithText:(NSString *)text whileExecutingBlock:(dispatch_block_t)block;
+ (void)showProgressWhileExecuting:(SEL)method onTarget:(id<SDProgressHUDDelegate>)target withObject:(id)object;
+ (void)showProgressWithText:(NSString *)text whileExecuting:(SEL)method onTarget:(id<SDProgressHUDDelegate>)target withObject:(id)object;

+ (void)removeProgress;

///-----------------------------------------
/// @name status
///-----------------------------------------

+ (void)showStatusWithText:(NSString *)text;
+ (void)showStatusWithText:(NSString *)text delay:(NSTimeInterval)delay;
+ (void)showStatusWithCustomView:(UIView *)customView withText:(NSString *)text;
+ (void)showStatusWithCustomView:(UIView *)customView withText:(NSString *)text delay:(NSTimeInterval)delay;

+ (void)showStatusWithCompleted;
+ (void)showStatusWithCompletedText:(NSString *)text;
+ (void)showStatusWithCompletedText:(NSString *)text delay:(NSTimeInterval)delay;

+ (void)showStatusWithFailed;
+ (void)showStatusWithFailedText:(NSString *)text;
+ (void)showStatusWithFailedText:(NSString *)text delay:(NSTimeInterval)delay;

///-----------------------------------------
/// @name noDataView 图片名称为sd_noData.png
///-----------------------------------------

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text;

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text
                             frame:(CGRect)frame;

///-----------------------------------------
/// @name label
///-----------------------------------------

+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                         addToView:(UIView *)view;

+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                             addToView:(UIView *)view;

+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                     textAlignment:(NSTextAlignment)textAlignment
                         addToView:(UIView *)view;

+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                         textAlignment:(NSTextAlignment)textAlignment
                             addToView:(UIView *)view;

///-----------------------------------------
/// @name other
///-----------------------------------------

+ (UIImageView *)initGraySepLineWithFrame:(CGRect)frame addToView:(UIView *)view;
+ (UIImage *)createImageWithColor:(UIColor *)color;
+ (UIImage *)getLauchImage;

///-----------------------------------------
/// @name MJRefreshGifHeader
///-----------------------------------------

+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock;
+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock
                                                   refreshingStartStr:(NSString *)refreshingStartStr
                                                        refreshingStr:(NSString *)refreshingStr
                                                     refreshingEndStr:(NSString *)refreshingEndStr;

+(NSMutableAttributedString *)setLineSpacingAndParagraphSpacingWithContent:(NSString *)content LineSpacing:(CGFloat )LineSpacing ParagraphSpacing:(CGFloat)ParagraphSpacing;
+ (NSMutableAttributedString *)initMutableAttributedWithString:(NSString *)string
                                                    attributes:(NSArray<NSDictionary *> *)attributeArray
                                                attributeTexts:(NSArray<NSString *> *)attributeTextArray;
+ (NSMutableAttributedString *)initMutableAttributedWithString:(NSString *)string
                                                    attributes:(NSArray<NSDictionary *> *)attributeArray
                                               attributeRanges:(NSArray<NSString *> *)attributeRangeArray;

@end
