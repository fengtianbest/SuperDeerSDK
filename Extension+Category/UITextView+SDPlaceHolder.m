//
//  UITextView+SDPlaceHolder.m
//  SDUIKit
//
//  Created by liulei on 2019/4/9.
//  Copyright © 2019年 SuperDeer. All rights reserved.
//

#import "UITextView+SDPlaceHolder.h"
#import <objc/runtime.h>
static const void *sd_placeHolderKey;

@interface UITextView ()

@property (nonatomic, readonly) UILabel *sd_placeHolderLabel;

@end

@implementation UITextView (SDPlaceHolder)

+(void)load{
    
    [super load];
    
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(sdPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(sdPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(sdPlaceHolder_swizzled_setText:)));
}

#pragma mark - swizzled

- (void)sdPlaceHolder_swizzled_dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self sdPlaceHolder_swizzled_dealloc];
}
- (void)sdPlaceHolder_swizzling_layoutSubviews {
    
    if (self.sd_placeHolder) {
        
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.sd_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.sd_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    
    [self sdPlaceHolder_swizzling_layoutSubviews];
}

- (void)sdPlaceHolder_swizzled_setText:(NSString *)text {
    
    [self sdPlaceHolder_swizzled_setText:text];
    if (self.sd_placeHolder) {
        [self updatePlaceHolder];
    }
}

#pragma mark - associated

-(NSString *)sd_placeHolder {
    return objc_getAssociatedObject(self, &sd_placeHolderKey);
}

-(void)setSd_placeHolder:(NSString *)sd_placeHolder {
    
    objc_setAssociatedObject(self, &sd_placeHolderKey, sd_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}

-(UIColor *)sd_placeHolderColor {
    return self.sd_placeHolderLabel.textColor;
}

-(void)setSd_placeHolderColor:(UIColor *)sd_placeHolderColor{
    self.sd_placeHolderLabel.textColor = sd_placeHolderColor;
}

-(NSString *)placeholder {
    return self.sd_placeHolder;
}

-(void)setPlaceholder:(NSString *)placeholder{
    self.sd_placeHolder = placeholder;
}

#pragma mark - update

- (void)updatePlaceHolder {
    
    if (self.text.length) {
        
        [self.sd_placeHolderLabel removeFromSuperview];
        return;
    }
    
    self.sd_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.sd_placeHolderLabel.textAlignment = self.textAlignment;
    self.sd_placeHolderLabel.text = self.sd_placeHolder;
    [self insertSubview:self.sd_placeHolderLabel atIndex:0];
}

#pragma mark - lazzing

-(UILabel *)sd_placeHolderLabel {
    
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(sd_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(sd_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    
    return placeHolderLab;
}

- (UIFont *)cacutDefaultFont {
    
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    
    return font;
}

@end
