//
//  NSString+SDExtension.m
//  SuperDeer
//
//  Created by liulei on 2018/5/28.
//  Copyright © 2018年 NHN. All rights reserved.
//

#import "NSString+SDExtension.h"

@implementation NSString (SDExtension)

+ (BOOL)isEmpty:(NSString *)string
{
    return string == nil || string.length == 0;
}

- (CGSize)sizeForMaxLimit:(CGSize)size font:(UIFont *)font
{
    return [self sizeForMaxLimit:size font:font maxLines:0];
}

- (CGSize)sizeForMaxLimit:(CGSize)size font:(UIFont *)font maxLines:(NSInteger)lines
{
    if ([NSString isEmpty:self])
    {
        return CGSizeMake(0, 0);
    }
    static UILabel *lbtext;
    if (lbtext == nil)
    {
        lbtext = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    }
    else
    {
        lbtext.frame = CGRectMake(0, 0, size.width, size.height);
    }
    lbtext.font = font;
    lbtext.text = self;
    lbtext.numberOfLines = lines;
    CGRect rect = [lbtext textRectForBounds:lbtext.frame limitedToNumberOfLines:lines];
    if(rect.size.height < 0)
    {
        rect.size.height = 0;
    }
    if (rect.size.width < 0)
    {
        rect.size.width = 0;
    }
    
    return CGSizeMake(rect.size.width, rect.size.height);
}

// 电话号码输入判断
- (BOOL)valiMobile {
    
    if (self == nil || self.length != 11) {
        return NO;
    }
    
    NSString *regex = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    return [predicate evaluateWithObject:self];
}

- (NSString *)removeEmoji {
    //去除表情规则
    //  \u0020-\\u007E  标点符号，大小写字母，数字
    //  \u00A0-\\u00BE  特殊标点  (¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾)
    //  \u2E80-\\uA4CF  繁简中文,日文，韩文 彝族文字
    //  \uF900-\\uFAFF  部分汉字
    //  \uFE30-\\uFE4F  特殊标点(︴︵︶︷︸︹)
    //  \uFF00-\\uFFEF  日文  (ｵｶｷｸｹｺｻ)
    //  \u2000-\\u201f  特殊字符(‐‑‒–—―‖‗‘’‚‛“”„‟)
    // 注：对照表 http://blog.csdn.net/hherima/article/details/9045765
    
    NSRegularExpression* expression = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    
    NSString* result = [expression stringByReplacingMatchesInString:self
                                                            options:0
                                                              range:NSMakeRange(0, self.length)
                                                       withTemplate:@""];
    
    return result;
}

- (NSString *)validImageUrlString {
    
    if ([NSString isEmpty:self]) {
        return @"";
    }
    
    if (![self containsString:@"http"]) {
        return [@"https://chaolu.oss-cn-hangzhou.aliyuncs.com/" stringByAppendingString:self];
    }

    return self;
}

+ (NSString *)doubleToString:(double)doubleValue {
    
    if (doubleValue) {
        NSString *dStr      = [NSString stringWithFormat:@"%f", doubleValue];
        NSDecimalNumber *dn = [NSDecimalNumber decimalNumberWithString:dStr];
        return [dn stringValue];
    }
    else {
        return @"0";
    }
}

@end
