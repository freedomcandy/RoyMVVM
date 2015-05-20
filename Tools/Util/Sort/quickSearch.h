//
//  quickSearch.h
//  Untitled
//
//  Created by AngelSeaHappiness on 13-12-29.
//
//

#import <Foundation/Foundation.h>

@interface quickSearch : NSObject

+(NSArray *)useQuickSearch:(NSArray *)dataArray keyStr:(NSString *)key;
+(NSArray *)searchData:(NSArray *)dataArray keyStr:(NSString *)key withLow:(NSInteger)low;
+(int)binarySearchLower:(NSArray *)dataArray keyStr:(NSString *)key withLow:(int)low withHigh:(int)high;
@end
