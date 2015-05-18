//
//  BaseViewModel_OC.h
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/15.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    RefreshData = 2,
    LoadMore
}LoadDataType;


@interface BaseViewModel_OC : NSObject

@end



@interface BaseViewModel_OC(optional)

- (void)getDataWithLoadDataType:(LoadDataType)loadDataType finish:(void(^)())loadSuccessBlock failture:(void(^)())loadFailureBlock;

@end