//
//  SDTableView.h
//  SuperDeer
//
//  Created by liulei on 2019/1/9.
//  Copyright © 2019年 NHN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/objc.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^CellConfigure)(id cell, id model, NSIndexPath * indexPath);
typedef void (^CellDidSelect)(id cell, id model, NSIndexPath * indexPath);

typedef NS_ENUM(NSInteger, SDTableViewNoDataType) {
    
    SDTableViewNoDataTypeDefault = 0,   // 默认带图片
    SDTableViewNoDataTypeOnlyWord = 1,  // 仅文字
};

@protocol SDTableViewDelegate;

@interface SDTableView : UITableView

@property (nonatomic, assign) id<SDTableViewDelegate> sdDelegate;

///-----------------------------------------
/// @name 必选参数(其中cell高度任选其一)
///-----------------------------------------

/** 1.cell数据交互block */
@property (nonatomic, copy) CellConfigure cellConfigure;
/** 2.cell点击事件block */
@property (nonatomic, copy) CellDidSelect cellDidSelect;
/** 3.cell高度 */
@property (nonatomic, assign) CGFloat cellHeight;

///-----------------------------------------
/// @name 可选参数
///-----------------------------------------

/** 4.是否有下拉刷新 */
@property (nonatomic, assign) BOOL hasRefreshGifHeader;
/** 5.是否有分页加载 */
@property (nonatomic, assign) BOOL hasRefreshFooter;
/** 6.有分页时，一页的数量, 默认10 */
@property (nonatomic, assign) NSInteger row;
/** 7.数据为空时的提示文字，默认为"暂无数据" */
@property (nonatomic, copy) NSString *noDataTipsText;
/** 8.数据源 */
@property (nonatomic, strong) NSMutableArray *models;
/** 9.空消息视图 */
@property (nonatomic, strong) UIView *noDataView;
/** 10.空消息视图类型 */
@property (nonatomic, assign) SDTableViewNoDataType noDataType;

/**
 1.定义方法
 
 @param cellClass cell类型 例:[XXCell class]
 @return view
 */
- (instancetype)initWithCellClass:(nullable Class)cellClass;

/**
 2.定义方法，从xib创建
 
 @param nib nib
 @param identifier identifier
 @return view
 */
- (instancetype)initWithNib:(nullable UINib *)nib forCellReuseIdentifier:(NSString *)identifier;

/**
 3.加载数据源, 刷新数据
 
 @param models 数据数组
 */
- (void)addModels:(NSArray *)models;

/**
 4.可变高度数组
 
 @param heightArray [NSNumber class]
 */
- (void)addCellHeights:(NSArray *)heightArray;

/**
 5.清空数据源，未刷新数据
 */
- (void)removeAllModels;

@end

@protocol SDTableViewDelegate <NSObject>

@optional

/**
 1.分页请求数据
 
 @param page 页码
 */
- (void)sdTableView:(SDTableView *)tableView requestDataWithPage:(NSInteger)page;

/**
 2.下拉刷新
 */
- (void)sdTableViewStartRefresh:(SDTableView *)tableView;

@end

NS_ASSUME_NONNULL_END
