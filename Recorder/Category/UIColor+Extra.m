//
//  UIColor+Extra.m
//  Recorder
//
//  Created by tarena on 16/7/25.
//  Copyright © 2016年 yingxin. All rights reserved.
//

#import "UIColor+Extra.h"

@implementation UIColor (Extra)
+ (UIColor *)randomColor{
    CGFloat r = arc4random() % 256 / 255.0;
    CGFloat g = arc4random() % 256 / 255.0;
    CGFloat b = arc4random() % 256 / 255.0;
    //参数的取值范围是0~1
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}
@end









