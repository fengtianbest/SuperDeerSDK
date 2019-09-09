//
//  UIButton+SDExtension.m
//  SDUIKit
//
//  Created by liulei on 2019/4/9.
//  Copyright © 2019年 SuperDeer. All rights reserved.
//

#import "UIButton+SDExtension.h"
#import <objc/runtime.h>

static char const * const ObjectTagKey = "ObjectTag";
static char topNameKey;
static char rightNameKey;
static char bottomNameKey;
static char leftNameKey;

@implementation UIButton (SDExtension)

- (BOOL)isTouchInside
{
    self.adjustsImageWhenHighlighted = NO;
    
    // 默认间隔时间
    if (!self.canContinuousTouch) {
        
        self.userInteractionEnabled = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(defaultInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.userInteractionEnabled = YES;
        });
    }
    
    return YES;
}

+(void)load{
    
    [super load];
    Method aMethod = class_getInstanceMethod(self, @selector(pointInside:withEvent:));
    Method bMethod = class_getInstanceMethod(self, @selector(clPointInside:withEvent:));
    method_exchangeImplementations(aMethod, bMethod);
}

- (BOOL)clPointInside:(CGPoint)point withEvent:(UIEvent *)event{

    CGRect rect = [self enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds)){
        return [self clPointInside:point withEvent:event];
    }else{
        return CGRectContainsPoint(rect, point);
    }
}

- (void)setEnlargeEdgeWithTop:(CGFloat)top right:(CGFloat)right bottom:(CGFloat)bottom left:(CGFloat)left
{
    objc_setAssociatedObject(self, &topNameKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &rightNameKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &bottomNameKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &leftNameKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (CGRect)enlargedRect{
    NSNumber* topEdge    = objc_getAssociatedObject(self, &topNameKey);
    NSNumber* rightEdge  = objc_getAssociatedObject(self, &rightNameKey);
    NSNumber* bottomEdge = objc_getAssociatedObject(self, &bottomNameKey);
    NSNumber* leftEdge   = objc_getAssociatedObject(self, &leftNameKey);
    
    if (topEdge && rightEdge && bottomEdge && leftEdge){
        return CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                          self.bounds.origin.y - topEdge.floatValue,
                          self.bounds.size.width  + leftEdge.floatValue + rightEdge.floatValue,
                          self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
    } else{
        return self.bounds;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    CGRect rect = [self enlargedRect];
    
    if (CGRectEqualToRect(rect, self.bounds)){
        return [super pointInside:point withEvent:event];
    }else{
        return CGRectContainsPoint(rect, point);
    }
}

- (void)setCanContinuousTouch:(BOOL)canContinuousTouch
{
    NSNumber *number = [NSNumber numberWithBool: canContinuousTouch];
    objc_setAssociatedObject(self, ObjectTagKey, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)canContinuousTouch {
    
    NSNumber *number = objc_getAssociatedObject(self, ObjectTagKey);
    return [number boolValue];
}

@end
