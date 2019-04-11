//
//  SDButton.m
//  SuperDeer
//
//  Created by liulei on 2018/5/24.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "SDButton.h"

@interface SDButton()

- (void)addImageViewSign;

@end

@implementation SDButton

@synthesize titleRect = titleRect_;
@synthesize backgroundRect = backgroundRect_;
@synthesize imvSign = imvSign_;
@synthesize signRect = signRect_;
@synthesize imageRect = imageRect_;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - imvsign

- (void)addImageViewSign{
    
    imvSign_ = [[UIImageView alloc] initWithFrame:signRect_];
    [self addSubview:imvSign_];
}

- (void)updateImageSignWithImage:(UIImage *)image{
    
    imvSign_.image = image;
}

- (void)setSignRect:(CGRect)signRect {
    
    signRect_ = signRect;
    if (!imvSign_) {
        [self addImageViewSign];
    }
}

#pragma mark - subTitle

- (void)addSubTitleLabel{
    
    _subTitleLabel = [[UILabel alloc] initWithFrame:_subTitleRect];
    [self addSubview:_subTitleLabel];
}

- (void)setSubTitleRect:(CGRect)subTitleRect {
    
    _subTitleRect = subTitleRect;
    if (!_subTitleLabel) {
        [self addSubTitleLabel];
    }
}

#pragma mark - rect for rewrite

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    if (&titleRect_ != NULL) {
        
        return titleRect_;
    }
    return [super titleRectForContentRect:contentRect];
}

- (CGRect)backgroundRectForBounds:(CGRect)bounds{
    
    if (&backgroundRect_ != NULL) {
        
        return backgroundRect_;
    }
    return [super backgroundRectForBounds:bounds];
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    if (&imageRect_ != NULL) {
        
        return imageRect_;
    }
    return [super imageRectForContentRect:contentRect];
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIResponder

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [[self nextResponder] touchesBegan:touches withEvent:event];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    [[self nextResponder] touchesMoved:touches withEvent:event];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)touchesEnded:(NSSet*)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

@end
