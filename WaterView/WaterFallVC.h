//
//  WaterFallVC.h
//  BlockTest
//
//  Created by huyang on 15/3/30.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTCollectionViewWaterfallLayout.h"

@interface WaterFallVC : UIViewController
<UICollectionViewDataSource,UICollectionViewDelegate,CHTCollectionViewDelegateWaterfallLayout>

@end
