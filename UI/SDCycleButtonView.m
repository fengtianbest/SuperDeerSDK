//
//  SDCycleButtonView.m
//  SuperDeer
//
//  Created by liulei on 2018/6/5.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDCycleButtonView.h"

static NSInteger kTagCycleButton = 100100;

@interface SDCycleButtonView ()

@property (nonatomic, assign) CGFloat             currentX;              // button当前X轴坐标
@property (nonatomic, assign) CGFloat             currentY;              // button当前Y轴坐标
@property (nonatomic, assign) NSInteger           btnCount;              // button当前行个数
@property (nonatomic, assign) NSInteger           btnTotalCount;         // button所有已创建个数
@property (nonatomic, strong) NSMutableArray      *buttonArray;          // 保存已经创建的button

@end

@implementation SDCycleButtonView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollEnabled = NO;
        _buttonArray = [NSMutableArray array];
    }
    return self;
}

#pragma mark - ButtonAction

- (void)buttonAction:(id)sender {
    
    UIButton *button =(UIButton *)sender;
    if (self.cDelegate && [self.cDelegate respondsToSelector:@selector(cycleButtonActionWithIndex:)]) {
        [ self.cDelegate cycleButtonActionWithIndex:button.tag - kTagCycleButton];
    }
}

#pragma mark - private

- (void)resetCounts {
    
    _btnTotalCount = 0;
    _currentX = 0;
    _currentY = 0;
    _btnCount = 0;
}

- (void)removeAllButtons {
    
    for (UIButton *button in self.buttonArray) {
        button.hidden = YES;
    }
}

// 隐藏多余的button
- (void)removeSurplusButtonsWithNeedCount:(NSInteger)count {
    
    if (count < self.buttonArray.count) {
        for (NSInteger index = count; index < self.buttonArray.count; index++) {
            UIButton *button = [self.buttonArray objectAtIndex:index];
            button.hidden = YES;
        }
    }
}

- (UIButton *)resetButtonWithTitle:(NSString *)title index:(NSInteger)index {
    
    UIButton *button;
    if (_btnTotalCount > 0 && _buttonArray.count > _btnTotalCount) {
        button = [_buttonArray objectAtIndex:_btnTotalCount - 1];
    }
    else {
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonArray addObject:button];
        [self addSubview:button];
    }

    button.hidden = NO;
    button.frame = CGRectMake(self.currentX, self.currentY, 0, self.btnHeight);
    button.tag = kTagCycleButton + index;
    [button addTarget:self
               action:@selector(buttonAction:)
     forControlEvents:UIControlEventTouchUpInside];
    
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:self.btnTitleFont}];
    CGRect btnFrame = button.frame;
    btnFrame.size.width = size.width + self.btnDistanceWidth*2;
    button.frame = btnFrame;
    button.titleLabel.font = self.btnTitleFont;
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    [button setTitleColor:self.btnTitleColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = self.btnBackgroundColor;
    
    button.layer.masksToBounds = YES;
    if (_btnCornerRadius != 0) {
        button.layer.cornerRadius = _btnCornerRadius;
    }
    
    if (_btnBorderWidth != 0) {
        [button.layer setBorderWidth:_btnBorderWidth];
    }
    
    if (_btnBorderColor) {
        [button.layer setBorderColor:_btnBorderColor.CGColor];
    }
    
    return button;
}

#pragma mark - Get

- (CGFloat)btnHeight {
    
    if (_btnHeight == 0) {
        _btnHeight = 30;
    }
    return _btnHeight;
}

- (CGFloat)btnDistanceLandscape {
    
    if (_btnDistanceLandscape == 0) {
        _btnDistanceLandscape = 8;
    }
    return _btnDistanceLandscape;
}

- (CGFloat)btnDistancePortait {
    
    if (_btnDistancePortait == 0) {
        _btnDistancePortait = 9;
    }
    return _btnDistancePortait;
}

- (CGFloat)btnDistanceWidth {
    
    if (_btnDistanceWidth == 0) {
        _btnDistanceWidth = 10;
    }
    return _btnDistanceWidth;
}

- (UIFont *)btnTitleFont {
    
    if (!_btnTitleFont) {
        _btnTitleFont = [UIFont systemFontOfSize:14];
    }
    return _btnTitleFont;
}

- (UIColor *)btnTitleColor {
    
    if (!_btnTitleColor) {
        _btnTitleColor = [UIColor blackColor];
    }
    return _btnTitleColor;
}

- (UIColor *)btnBackgroundColor {
    
    if (!_btnBackgroundColor) {
        _btnBackgroundColor = [UIColor whiteColor];
    }
    return _btnBackgroundColor;
}

- (UIColor *)btnBorderColor {
    
    return _btnBorderColor;
}

- (CGFloat)btnCornerRadius {
    
    return _btnCornerRadius;
}

#pragma mark - Public

- (void)recreateWithTitles:(NSArray *)array{
    
    if (!array
        || ![array isKindOfClass:[NSArray class]]
        || array.count == 0)
    {
        [self removeAllButtons];
        return;
    }
    
    [self resetCounts];
    [self removeSurplusButtonsWithNeedCount:array.count];
    
    for (NSInteger index = 0; index < array.count; index++) {
        
        NSString *title = [array objectAtIndex:index];
        UIButton *button = [self resetButtonWithTitle:title index:index];
        _btnCount++;

        if (CGRectGetMaxX(button.frame) > CGRectGetWidth(self.frame)) {
            //按钮换行
            CGRect frame = button.frame;
            frame.origin.x = 0;
            frame.origin.y = _currentY + CGRectGetHeight(button.frame) + self.btnDistancePortait;
            button.frame = frame;
            _btnCount = 1;
        }
        
        _currentX = CGRectGetMaxX(button.frame) + self.btnDistanceLandscape;
        _currentY = button.frame.origin.y;
        
        if (CGRectGetMaxY(button.frame) > self.contentSize.height) {
            CGRect frame = self.frame;
            frame.size.height = CGRectGetMaxY(button.frame);
            self.contentSize = frame.size;
            self.frame = frame;
        }
        
        _btnTotalCount++;
    }
}

- (void)scrollEnabledWithHeight:(CGFloat)height {

    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    self.scrollEnabled = YES;
}

@end
