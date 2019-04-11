//
//  NSString+SDExtension.h
//  SuperDeer
//
//  Created by liulei on 2018/5/28.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SDExtension)
/**
 1.判断字符串是否为空或者为空字符串,
 */
- (BOOL)isEmpty;

/**
 2.获取文本的显示高度,

 @param size 区域最大限制
 @param font 字体
 @return 文本区域
 */
- (CGSize)rectForSize:(CGSize)size font:(UIFont *)font;

/**
 3.获取文本的显示高度,限制最大行数

 @param size 区域最大限制
 @param font 字体
 @param lines 最大行数
 @return 文本区域
 */
- (CGSize)rectForSize:(CGSize)size font:(UIFont *)font maxLines:(NSInteger)lines;

/**
 4.判断是否电话号码

 @return YES:合法
 */
- (BOOL)valiMobile;

/**
 5.过滤Emoji表情

 @return 删除Emoji后的字符串
 */
- (NSString *)removeEmoji;

/**
 6.验证图片路径是否阿里云路径，若为阿里云路径，需要加上头部

 @return 修改后的路径
 */
- (NSString *)validImageUrlString;

/**
 7.double转string，避免从服务器取到的number转string造成精度丢失

 @param doubleValue double
 @return string
 */
+ (NSString *)doubleToString:(double)doubleValue;

@end
