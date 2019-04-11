//
//  SDUIHelpers.m
//  SuperDeer
//
//  Created by liulei on 2018/6/6.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDUIHelpers.h"
#import "UIView+SDExtension.h"
#import "SDQuickCreate.h"

static SDProgressHUD *HUD = nil;
static SDProgressHUD *HUDText = nil;
static NSString *sucMessage = @"加载成功";
static NSString *failedMessage = @"加载失败";

@implementation SDUIHelpers

+ (UIWindow *)window {
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (window.windowLevel != UIWindowLevelNormal) {
        for (window in [UIApplication sharedApplication].windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    
    return window;
}

#pragma mark - progress

+ (void)showProgress {
    
    [SDUIHelpers showProgressWithText:nil];
}

+ (void)showProgressWithText:(NSString *)text {
    
    [SDUIHelpers showProgressWithText:text detailText:nil];
}

+ (void)showProgressWithText:(NSString *)text detailText:(NSString *)detail {
    
    // version = 1 by liulei 多次调用progress，先释放上一个，防止无法removeProgress
    [SDUIHelpers removeProgress];
    
    if (!HUD) {
        HUD = [[SDProgressHUD alloc] initWithView:[SDUIHelpers window]];
        HUD.removeFromSuperViewOnHide = YES;
    }
    
    HUD.labelText = text;
    HUD.detailsLabelText = detail;
    [[SDUIHelpers window] addSubview:HUD];
    [HUD show:YES];
}

+ (void)showProgressWhileExecutingBlock:(dispatch_block_t)block {
    
    [SDUIHelpers showProgressWithText:nil whileExecutingBlock:block];
}

+ (void)showProgressWithText:(NSString *)text whileExecutingBlock:(dispatch_block_t)block {
    
    SDProgressHUD *hud = [[SDProgressHUD alloc] initWithView:[SDUIHelpers window]];
    [[SDUIHelpers window] addSubview:hud];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.labelText = text;
    
    [hud showAnimated:YES whileExecutingBlock:^{
        if (block) {
            block();
        };
    } completionBlock:^{
        [hud removeFromSuperview];
    }];
}

+ (void)showProgressWhileExecuting:(SEL)method
                          onTarget:(id<SDProgressHUDDelegate>)target withObject:(id)object {
    
    [SDUIHelpers showProgressWithText:nil
                       whileExecuting:method
                             onTarget:target
                           withObject:object];
}

+ (void)showProgressWithText:(NSString *)text
              whileExecuting:(SEL)method
                    onTarget:(id<SDProgressHUDDelegate>)target withObject:(id)object {
    
    if (!HUD) {
        HUD = [[SDProgressHUD alloc] initWithView:[SDUIHelpers window]];
    }
    [[SDUIHelpers window] addSubview:HUD];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.labelText = text;
    
    HUD.delegate = target;
    
    [HUD showWhileExecuting:method onTarget:target withObject:nil animated:YES];
}

+ (void)removeProgress {
    
    if (HUD) {
        [HUD hide:YES];
    }
}


#pragma mark - status

+ (void)showStatusWithText:(NSString *)text {
    
    // 无文字不显示
    
    if (text == nil
        || ![text isKindOfClass:[NSString class]]
        || text == NULL
        || [text isEqual:[NSNull null]]
        ||[text isEqualToString:@""]) {
        return;
    }
    [SDUIHelpers showStatusWithCustomView:nil withText:text delay:1.0];
}

+ (void)showStatusWithText:(NSString *)text delay:(NSTimeInterval)delay {
    
    // 无文字不显示
    
    if (text == nil
        || ![text isKindOfClass:[NSString class]]
        || text == NULL
        || [text isEqual:[NSNull null]]
        ||[text isEqualToString:@""]) {
        return;
    }
    [SDUIHelpers showStatusWithCustomView:nil withText:text delay:delay];
}

+ (void)showStatusWithCustomView:(UIView *)customView withText:(NSString *)text {
    
    [SDUIHelpers showStatusWithCustomView:customView withText:text delay:1.0];
}

+ (void)showStatusWithCustomView:(UIView *)customView withText:(NSString *)text delay:(NSTimeInterval)delay {
    
    if (!HUDText) {
        HUDText = [[SDProgressHUD alloc] initWithView:[SDUIHelpers window]];
    }
    [[SDUIHelpers window] addSubview:HUDText];
    HUDText.removeFromSuperViewOnHide = YES;
    
    if (nil == customView) {
        HUDText.mode = SDProgressHUDModeText;
    }else {
        HUDText.mode = SDProgressHUDModeCustomView;
        customView.width = 45;
        customView.height = 45;
    }
    HUDText.customView = customView;
    HUDText.labelText = text;
    [HUDText show:YES];
    [HUDText hide:YES afterDelay:delay];
}

+ (void)showStatusWithCompleted {
    
    UIImage *image = [UIImage imageNamed:@"img_competed.png"];
    if (image) {
        [self showStatusWithCustomView:[[UIImageView alloc] initWithImage:image] withText:sucMessage];
    }else {
        [self showStatusWithCompletedText:sucMessage];
    }
}

+ (void)showStatusWithCompletedText:(NSString *)text {
    
    UIImage *image = [UIImage imageNamed:@"img_competed.png"];
    if (image) {
        [self showStatusWithCustomView:[[UIImageView alloc] initWithImage:image] withText:text];
    }else {
        [self showStatusWithCustomView:nil withText:text];
    }
}

+ (void)showStatusWithCompletedText:(NSString *)text delay:(NSTimeInterval)delay {
    
    UIImage *image = [UIImage imageNamed:@"img_competed.png"];
    if (image) {
        [self showStatusWithCustomView:[[UIImageView alloc] initWithImage:image] withText:text delay:delay];
    }else {
        [self showStatusWithCustomView:nil withText:text delay:delay];
    }
}

+ (void)showStatusWithFailed {
    
    UIImage *image = [UIImage imageNamed:@"img_failed.png"];
    if (image) {
        [self showStatusWithCustomView:[[UIImageView alloc] initWithImage:image] withText:failedMessage];
    }else {
        [self showStatusWithCompletedText:failedMessage];
    }
}

+ (void)showStatusWithFailedText:(NSString *)text {
    
    UIImage *image = [UIImage imageNamed:@"img_failed.png"];
    if (image) {
        [self showStatusWithCustomView:[[UIImageView alloc] initWithImage:image] withText:text];
    }else {
        [self showStatusWithCustomView:nil withText:text];
    }
}
+ (void)showStatusWithFailedText:(NSString *)text delay:(NSTimeInterval)delay {
    
    UIImage *image = [UIImage imageNamed:@"img_failed.png"];
    if (image) {
        [self showStatusWithCustomView:[[UIImageView alloc] initWithImage:image] withText:text delay:delay];
    }else {
        [self showStatusWithCustomView:nil withText:text];
    }
}

#pragma mark - label

+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                         addToView:(UIView *)view {
    
    return [SDQuickCreate initLabelWithFontSize:fontSize textColor:textColor addToView:view];
}

+ (UILabel *)initLabelWithFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                     textAlignment:(NSTextAlignment)textAlignment
                         addToView:(UIView *)view {
        
    return [SDQuickCreate initLabelWithFontSize:fontSize textColor:textColor textAlignment:textAlignment addToView:view];
}

+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                         textColor:(UIColor *)textColor
                         addToView:(UIView *)view {
    
    return [SDQuickCreate initLabelWithBoldFontSize:fontSize textColor:textColor addToView:view];
}

+ (UILabel *)initLabelWithBoldFontSize:(CGFloat)fontSize
                             textColor:(UIColor *)textColor
                         textAlignment:(NSTextAlignment)textAlignment
                             addToView:(UIView *)view {
    
    return [SDQuickCreate initLabelWithBoldFontSize:fontSize
                                          textColor:textColor
                                      textAlignment:textAlignment
                                          addToView:view];
}

#pragma mark - noDataView

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text{
    
    return [SDQuickCreate initNoDataViewFromView:view withText:text];
}

+ (UIView *)initNoDataViewFromView:(UIView *)view
                          withText:(NSString *)text
                             frame:(CGRect)frame {
    
    return [SDQuickCreate initNoDataViewFromView:view withText:text frame:frame];
}

#pragma mark - other

+ (UIImageView *)initGraySepLineWithFrame:(CGRect)frame
                                addToView:(UIView *)view {
    
    return [SDQuickCreate initGraySepLineWithFrame:frame addToView:view];
}

+ (UIImage *)createImageWithColor:(UIColor *)color {
    
    return [SDQuickCreate createImageWithColor:color];
}

#pragma mark - MJRefreshGifHeader

+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock {
    
    return [SDQuickCreate initMJRefreshGifHeaderWithWithRefreshingBlock:refreshingBlock];
}

+ (MJRefreshGifHeader *)initMJRefreshGifHeaderWithWithRefreshingBlock:(MJRefreshComponentRefreshingBlock)refreshingBlock refreshingStartStr:(NSString *)refreshingStartStr refreshingStr:(NSString *)refreshingStr refreshingEndStr:(NSString *)refreshingEndStr{
    
    return [SDQuickCreate initMJRefreshGifHeaderWithWithRefreshingBlock:refreshingBlock
                                                     refreshingStartStr:refreshingStartStr
                                                          refreshingStr:refreshingStr
                                                       refreshingEndStr:refreshingEndStr];
}

@end
