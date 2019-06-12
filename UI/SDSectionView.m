//
//  SDSectionView.m
//  SuperDeer
//
//  Created by liulei on 2018/10/27.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDSectionView.h"
#import "UIView+SDExtension.h"
#import "UIButton+SDExtension.h"
#import "NSString+SDExtension.h"

@interface SDSectionView ()

// 标签数组
@property (nonatomic, strong) NSMutableArray *buttonArray;
// 当前选中的标签
@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) UIImageView *selectLine;

@end

@implementation SDSectionView

#pragma mark - lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _buttonArray = [[NSMutableArray alloc] init];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

/**
 创建标签按钮
 
 @param array 标签title数组
 */
- (void)recreateButotnWithArray:(NSArray *)array {
    
    // 先清空之前的数据
    [self removeAllSubviews];
    [_buttonArray removeAllObjects];
    
    CGFloat width;
    if (_sectionWidth == 0) {
        width = self.width/array.count;
    }
    else {
        width = _sectionWidth;
    }
    
    CGRect frame = CGRectMake(0, 0, width, self.height);
    for (NSInteger index = 0; index < array.count; index++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.canContinuousTouch = YES;
        button.frame = frame;
        button.adjustsImageWhenHighlighted = NO;
        button.tag = index;
        [button addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:array[index] forState:UIControlStateNormal];
        [self addSubview:button];
        
        if (index == 0) {
            // 默认选中第一个
            button.titleLabel.font = self.selectTitleFont;
            [button setTitleColor:self.selectTitleColor forState:UIControlStateNormal];
            _selectButton = button;
            _selectIndex = 0;
        }
        else {
            
            button.titleLabel.font = self.unSelectTitleFont;
            [button setTitleColor:self.unSelectTitleColor forState:UIControlStateNormal];
        }
        
        [self addSubview:button];
        [_buttonArray addObject:button];
        
        frame.origin.x = width*(index + 1);
    }
    
    self.contentSize = CGSizeMake(frame.origin.x, self.height);
    
    if (self.selectLineColor) {
        // 存在底部横线
        CGFloat lineWidth;
        if (_selectLineWidth != 0) {
            lineWidth = _selectLineWidth;
        }
        else {
            lineWidth = width*self.selectLineWidthScale;
        }
        
        _selectLine = [[UIImageView alloc] init];
        _selectLine.height = self.selectLineHeight;
        _selectLine.bottom = self.height;
        _selectLine.width = lineWidth;
        _selectLine.layer.masksToBounds = YES;
        _selectLine.layer.cornerRadius = self.selectLineHeight/2;
        _selectLine.centerX = width/2;
        // 小屏幕可能线太长
        if (_selectLine.left < 0) {
            _selectLine.width = width;
            _selectLine.centerX = width/2;
        }
        
        _selectLine.backgroundColor = self.selectLineColor;
        [self addSubview:_selectLine];
    }
    
    if (_showBottomLine) {
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        line.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1.0];
        [self addSubview:line];
        _selectLine.bottom = self.height - 0.5;
    }
}

- (void)refreshButotnWithArray:(NSArray *)array {
    
    for (NSInteger index = 0; index < array.count && index < _buttonArray.count; index++) {
        
        UIButton *button = _buttonArray[index];
        [button setTitle:array[index] forState:UIControlStateNormal];
    }
}

- (void)selectAction:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    if ([NSString isEmpty:button.titleLabel.text]) {
        return;
    }
    [self selectWithIndex:button.tag];
    _selectIndex = button.tag;
    
    if (self.sddelegate && [self.sddelegate respondsToSelector:@selector(sectionSelectWithIndex:)]) {
        [self.sddelegate sectionSelectWithIndex:button.tag];
    }
}

#pragma mark - Public

- (void)selectWithIndex:(NSInteger)index {
    
    if (_selectIndex != index) {
        // 选项变动
        UIButton *button = _buttonArray[index];
        
        _selectButton.titleLabel.font = self.unSelectTitleFont;
        [_selectButton setTitleColor:self.unSelectTitleColor forState:UIControlStateNormal];
        button.titleLabel.font = self.selectTitleFont;
        [button setTitleColor:self.selectTitleColor forState:UIControlStateNormal];
        
        _selectButton = button;
        [UIView animateWithDuration:0.2 animations:^{
            self.selectLine.centerX = button.centerX;
        }];
        
        _selectIndex = index;
    }
}

- (void)reloadWithTitles:(NSArray <NSString *>*)array {
    
    [self recreateButotnWithArray:array];
}

- (void)refreshWithTitles:(NSArray <NSString *>*)array {
    
    [self refreshButotnWithArray:array];
}

@end
