//
//  UIButton+SDExtension.h
//  SDUIKit
//
//  Created by liulei on 2019/4/9.
//  Copyright © 2019年 SuperDeer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (SDExtension)

/**
 YES:可连续点击 NO:每0.5秒可以点击一次
 */
@property (nonatomic, assign) BOOL canContinuousTouch;

/**
 扩大buuton点击范围

 @param top 上边距
 @param right 右边距
 @param bottom 下边距
 @param left 左边距
 */
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;

@end

NS_ASSUME_NONNULL_END
