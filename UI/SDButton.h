//
//  SDButton.h
//  SuperDeer
//
//  Created by liulei on 2018/5/24.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDButton : UIButton{
    
    UILabel *update_;
    
    CGRect titleRect_;
    CGRect backgroundRect_;
    CGRect signRect_;
    CGRect imageRect_;
    
    UIImageView *imvSign_;
}

/**
 *  titleLabel的位置，使用title必须设置
 */
@property (nonatomic, assign) CGRect titleRect;

/**
 *  backgroundImage的位置，使用backgroundImage必须设置
 */
@property (nonatomic, assign) CGRect backgroundRect;

/**
 *  imageView的位置，使用imageView必须设置
 */
@property (nonatomic, assign) CGRect imageRect;

@property (nonatomic, strong) UIImageView *imvSign;
@property (nonatomic, assign) CGRect signRect;

@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, assign) CGRect subTitleRect;

@end
