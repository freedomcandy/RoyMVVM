//
//  UIColor+HexColor.h
//  TCTravel_IPhone
//
//  Created by Tracy－jun on 14/11/12.
//
//

#import <UIKit/UIKit.h>

@interface UIColor (HexColor)

/**
 *  16进制和RGB的转换
 *
 *  @param hexColor 16进制
 *
 *  @return 转换后的颜色
 */
+ (UIColor *)getColorWithHex:(NSString *)hexColor;

@end
