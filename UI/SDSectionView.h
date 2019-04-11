//
//  SDSectionView.h
//  SuperDeer
//
//  Created by liulei on 2018/10/27.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SDSectionViewDelegate <NSObject>

/**
 点击标签

 @param index 点击的索引
 */
- (void)sectionSelectWithIndex:(NSInteger)index;

@end

@interface SDSectionView : UIScrollView

@property (nonatomic, weak) id<SDSectionViewDelegate> sddelegate;

///////////////////// 配置属性 /////////////////////
/** 1.未选中标题颜色 */
@property (nonatomic, strong) UIColor *unSelectTitleColor;
/** 2.未选中标题字体 */
@property (nonatomic, strong) UIFont *unSelectTitleFont;
/** 3.选中标题颜色 */
@property (nonatomic, strong) UIColor *selectTitleColor;
/** 4.选中标题字体 */
@property (nonatomic, strong) UIFont *selectTitleFont;

/** 5.选中横线颜色 */
@property (nonatomic, strong) UIColor *selectLineColor;
/** 6.选中横线宽度相比于一个标签的比例 */
@property (nonatomic, assign) double selectLineWidthScale;
/** 7.选中横线宽度相比于一个标签的宽度(指定宽度时，忽略比例) */
@property (nonatomic, assign) double selectLineWidth;
/** 8.选中横线高度 */
@property (nonatomic, assign) double selectLineHeight;

/** 9.单个section宽度(可选，不设置默认均等分) */
@property (nonatomic, assign) double sectionWidth;
/** 10.底部是否有分割线 */
@property (nonatomic, assign) BOOL showBottomLine;

///////////////////// 读取属性 /////////////////////
/** 1.当前选中的索引 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 1.刷新数据

 @param array 标签标题数组
 */
- (void)reloadWithTitles:(NSArray <NSString *>*)array;

/**
 2.更新标签

 @param index 需要的标签索引
 */
- (void)selectWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
