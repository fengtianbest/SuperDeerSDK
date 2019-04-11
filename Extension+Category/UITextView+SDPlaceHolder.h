//
//  UITextView+SDPlaceHolder.h
//  SDUIKit
//
//  Created by liulei on 2019/4/9.
//  Copyright © 2019年 SuperDeer. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (SDPlaceHolder)

/** 1.UITextView+placeholder */
@property (nonatomic, copy) NSString *sd_placeHolder;

/** 1.IQKeyboardManager等第三方框架会读取placeholder属性并创建UIToolbar展示 */
@property (nonatomic, copy) NSString *placeholder;

/** 3.placeHolder颜色 */
@property (nonatomic, strong) UIColor *sd_placeHolderColor;

@end

NS_ASSUME_NONNULL_END
