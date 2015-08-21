//
//  WCSeiresCouponModel.h
//  BlockTest
//
//  Created by huyang on 15/6/1.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCSeiresCouponModel : NSObject

@property(assign,nonatomic)BOOL is_couponLi ;
@property(assign,nonatomic)BOOL is_couponHui ;
@property(assign,nonatomic)BOOL is_cashBack ;
@property(copy  ,nonatomic)NSString *liText ;
@property(copy  ,nonatomic)NSString *huiText ;
@property(copy  ,nonatomic)NSString *cashBackText ;

@end
