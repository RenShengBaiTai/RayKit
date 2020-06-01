//
//  RSATool.h
//  contract
//
//  Created by admin on 2020/5/15.
//  Copyright © 2020 hjdj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RayRSATool : NSObject

// 加签
+ (NSString *)signTheDataBySHA256WithRSA:(NSString *)plainText;


@end

NS_ASSUME_NONNULL_END
