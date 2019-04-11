//
//  SDCycleButtonView.h
//  SuperDeer
//
//  Created by liulei on 2018/6/5.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SDCycleButtonViewDelegate <NSObject>


/**
 button点击事件

 @param index 当前数组序列
 */
-(void)cycleButtonActionWithIndex:(NSInteger)index;

@end

/**
 *  循环创建button
 */
@interface SDCycleButtonView : UIScrollView

@property (nonatomic, weak) id<SDCycleButtonViewDelegate> cDelegate;

/** 1.button高度 ,default is 30 */
@property (nonatomic, assign) CGFloat btnHeight;

/** 2.button横向间距，default is 8 */
@property (nonatomic, assign) CGFloat btnDistanceLandscape;

/** 3.button竖向间距，default is 9 */
@property (nonatomic, assign) CGFloat btnDistancePortait;

/** 4.button文字到边界的空白长度，default is 10 */
@property (nonatomic, assign) CGFloat btnDistanceWidth;

/** 5.button圆角，default is 0 */
@property (nonatomic, assign) CGFloat btnCornerRadius;

/** 6.边线宽度，default is 0 */
@property (nonatomic, assign) CGFloat btnBorderWidth;

/** 7.title字体大小, default is [UIFont systemFontOfSize:14] */
@property (nonatomic, strong) UIFont *btnTitleFont;

/** 8.title字体颜色, default is [UIColor blackColor] */
@property (nonatomic, strong) UIColor *btnTitleColor;

/** 9.button边框颜色, default is nil */
@property (nonatomic, strong) UIColor *btnBorderColor;

/** 10.default is [UIColor whiteColor] */
@property (nonatomic, strong) UIColor *btnBackgroundColor;


/**
 1.更新button所有title

 @param array title数组
 */
- (void)recreateWithTitles:(NSArray *)array;


/**
 2.设置为可以滚动

 @param height frame高度, 需大于contentSize高度
 */
- (void)scrollEnabledWithHeight:(CGFloat)height;

@end
