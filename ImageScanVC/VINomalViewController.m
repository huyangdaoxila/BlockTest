//
//  VINomalViewController.m
//  testApp
//
//  Created by 鲁长庆 on 15/3/21.
//  Copyright (c) 2015年 simple. All rights reserved.
//

#import "VINomalViewController.h"
#import "WButton.h"
#import "DXLBaseUtils.h"
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>


@interface VINomalViewController ()<VIScanViewControllerDelegate>

@property (nonatomic ,strong) WButton *backButton;
@property (nonatomic ,strong) UITextView *customTextView;
@property (nonatomic ,strong) UILabel *topTitleLabel;
@property (nonatomic, strong) UILabel *bottomLabel;
@property (nonatomic ,strong) UILabel *indexLabel;

@end

@implementation VINomalViewController

- (instancetype)initWithTransitionStyle:(UIPageViewControllerTransitionStyle)style navigationOrientation:(UIPageViewControllerNavigationOrientation)navigationOrientation options:(NSDictionary *)options
{
    self = [super initWithTransitionStyle:style navigationOrientation:navigationOrientation options:options];
    if (self) {
        self.vIScrollDelegate = self;
        self.portraitToLandscapeTopHeight = 20;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (self.showTopView) {
        [self topViewSetting:^(VITopView *topView) {
            self.backButton = [WButton buttonWithType:UIButtonTypeCustom];
            [_backButton setAttributes:@{kWButtonImageNomal:@"viphoto_cancel"} withClickBlock:^(WButton *reuseBtn) { // library.bundle/viphoto_cancel
                UIViewController *vc = [DXLBaseUtils viewControllerForView:reuseBtn];
                [vc dismissViewControllerAnimated:YES completion:nil];
            }];
            [topView addSubview:_backButton];
            
            [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(44);
                make.height.equalTo(44);
                make.right.offset(0);
                make.bottom.equalTo(topView.mas_bottom);
            }];
            
            self.indexLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _indexLabel.textAlignment = NSTextAlignmentLeft;
            _indexLabel.backgroundColor = [UIColor clearColor];
            [topView addSubview:_indexLabel];
            
            [_indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(15);
                make.height.equalTo(44);
                make.bottom.equalTo(topView.mas_bottom);
            }];
            
            
            self.topTitleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _topTitleLabel.textAlignment = NSTextAlignmentCenter;
            _topTitleLabel.font = [UIFont boldSystemFontOfSize:14.f];
            _topTitleLabel.textColor = [UIColor whiteColor];
            _topTitleLabel.backgroundColor = [UIColor clearColor];
            [topView addSubview:_topTitleLabel];
            [_topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(topView);
                make.width.equalTo(200);
                make.height.equalTo(44);
                make.bottom.equalTo(topView.mas_bottom);
            }];
            
        }];
    }
    if (self.showBottomView) {
        [self bottomViewSetting:^(VIBottomView *bottomView) {
            self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
            _bottomLabel.font = [UIFont systemFontOfSize:16.f];
            _bottomLabel.textColor = [DXLBaseUtils getColor:@"ffffff"];
            _bottomLabel.backgroundColor = [UIColor clearColor];
            [bottomView addSubview:_bottomLabel];
            [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(bottomView.mas_top);
                make.left.equalTo(15);
                make.right.equalTo(15);
                make.height.equalTo(20);
            }];
            
            self.customTextView = [[UITextView alloc] initWithFrame:CGRectZero];
            _customTextView.textColor = [DXLBaseUtils getColor:@"999999"];
            _customTextView.font = [UIFont systemFontOfSize:11];
            _customTextView.editable = NO;
            _customTextView.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
            _customTextView.backgroundColor = [UIColor clearColor];
            [bottomView addSubview:_customTextView];
            
            [_customTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(12);
                make.right.equalTo(- 12);
                make.height.equalTo(48);
                make.bottom.equalTo(bottomView.mas_bottom).offset(-45);
            }];
        }];
    }
    
    [self resetTextAtPage:self.firstIndex];
}

- (void)showBackItem:(BOOL)yesOrNo
{
    if (_backButton) {
        _backButton.hidden = yesOrNo;
    }
    
}

#pragma mark - private

- (void)resetTextAtPage:(NSInteger)page
{
    VIModel *model = [self.imageDataSource objectAtIndex:page];
    NSMutableAttributedString *textViewstr = [[NSMutableAttributedString alloc] initWithString:model.text?model.text:@""];
    
    [textViewstr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, textViewstr.length)];
    [textViewstr addAttribute:NSForegroundColorAttributeName value:[DXLBaseUtils getColor:@"999999"] range:NSMakeRange(0, textViewstr.length)];
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineSpacing:4];
    
    [textViewstr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, textViewstr.length)];
    
    _customTextView.attributedText = textViewstr;
    
    
    NSString *str = [NSString stringWithFormat:@"%d/%d",(int)page + 1,(int)self.imageDataSource.count];
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange range = [str rangeOfString:[NSString stringWithFormat:@"/%d",(int)self.imageDataSource.count]];
    [astr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:range];
    [astr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, range.location)];
    [astr addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, astr.length)];
    
    
    _indexLabel.attributedText = astr;
    _bottomLabel.text = model.bottomTitle?model.bottomTitle:@"";
    _topTitleLabel.text = model.topTitle?model.topTitle:@"";
}


#pragma mark - Delegate

- (void)vIScanViewControllerScrollToPage:(NSInteger)page
{
    [self resetTextAtPage:page];
}


@end
