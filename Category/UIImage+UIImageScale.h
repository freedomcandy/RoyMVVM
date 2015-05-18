//
//  UIImage+UIImageScale.h
//  YHOUSE
//
//  Created by FENG on 14-5-8.
//  Copyright (c) 2014年 FENG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (UIImageScale)

-(UIImage*)getSubImage:(CGRect)rect;
-(UIImage*)scaleToSize:(CGSize)size;

@end
