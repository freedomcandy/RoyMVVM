//
//  UIColor+HexColor.m
//  TCTravel_IPhone
//
//  Created by Tracy－jun on 14/11/12.
//
//

#import "UIColor+HexColor.h"

@implementation UIColor (HexColor)

+ (UIColor *)getColorWithHex:(NSString *)hexColor
{
    NSMutableString *mHexColor = [NSMutableString stringWithString:hexColor];
    if ([hexColor hasPrefix:@"#"])
    {
        [mHexColor replaceCharactersInRange:[hexColor rangeOfString:@"#" ] withString:@"0x"];
    }
    long colorLong = strtoul([mHexColor cStringUsingEncoding:NSUTF8StringEncoding], 0, 16);
    // 通过位与方法获取三色值
    int R = ( colorLong & 0xFF0000 )>>16;
    int G = ( colorLong & 0x00FF00 )>>8;
    int B = colorLong & 0x0000FF;
    
    return [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0];
}

@end
