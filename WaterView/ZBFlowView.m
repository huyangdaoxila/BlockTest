//
//  ZBFlowView.m
//  
//
//  Created by zhangbin on 14-7-28.
//  Copyright (c) 2014年 OneStore. All rights reserved.
//

#import "ZBFlowView.h"

@interface ZBFlowView()
{
    
}
@end

@implementation ZBFlowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *contentView = [[UIView alloc] initWithFrame:frame] ;
        [self addSubview:contentView] ;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-35)];
        _imageView.backgroundColor = [UIColor blueColor];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight ;
        [contentView addSubview:_imageView] ;
        
        _title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-35, self.bounds.size.width, 35)];
        _title.text = @"hahhahah" ;
        _title.backgroundColor = [UIColor lightGrayColor];
        _title.autoresizingMask = UIViewAutoresizingFlexibleWidth ;
        [contentView addSubview:_title] ;
        
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.tag = self.tag;
//        btn.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
//        btn.autoresizingMask = UIViewAutoresizingFlexibleWidth
//        |UIViewAutoresizingFlexibleHeight;
//   
//        [btn addTarget:self action:@selector(pressed:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:btn];
        return self;
    }
    return self;
}

- (void)pressed:(id)sender
{
    if (self) {
        if ([_flowViewDelegate respondsToSelector:@selector(pressedAtFlowView:)]) {
            [_flowViewDelegate pressedAtFlowView:self];
        }
    }
}




@end
