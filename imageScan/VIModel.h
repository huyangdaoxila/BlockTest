//
//  VIModel.h
//  TTT
//
//  Created by LCQ on 15/3/20.
//  Copyright (c) 2015年 lcqgrey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VIModel : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) NSString *topTitle;
@property (nonatomic, copy) NSString *bottomTitle;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) id image; //UIImage实例或图片地址

@end
