//
//  CollectionCell.m
//  BlockTest
//
//  Created by huyang on 15/3/9.
//  Copyright (c) 2015年 huyang. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell

- (void)awakeFromNib {
    // Initialization code
    
    _myImage = [[UIImageView alloc] init];
    _myImage.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-20) ;
    _myImage.image = nil ;
    [self addSubview:_myImage];
    
    _myTitle = [[UILabel alloc] init];
    _myTitle.frame = CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20) ;
    [self addSubview:_myTitle];
}
/*
 
 //
 //  PhotographyListController.m
 //  DaoxilaApp
 //
 //  Created by LCQ on 15/1/12.
 //  Copyright (c) 2015年 lcqgrey. All rights reserved.
 //
 
 #import "PhotographyListController.h"
 #import "PHListCell.h"
 #import "PHButton.h"
 #import "PhotographyDetailViewController.h"
 
 #import "PHListModel.h"
 #import "PHFilterModel.h"
 #import "PHFilterItemModel.h"
 #import "PHDetailModel.h"
 #import "PHBranchModel.h"
 #import "PHEventModel.h"
 #import "PHSeriesModel.h"
 #import "PHSeriesBorderModel.h"
 #import "PHSeriesPropertyModel.h"
 #import "PhotographySearchController.h"
 #import "ADBannerView.h"
 #import "CHTCollectionViewWaterfallLayout.h" // young add
 #import "PHSampleWithBizCell.h" // young add
 #import "PHSampleModel.h"
 //#import "MJRefresh.h"
 #import "PHSampleDetailController.h"   //huyang
 
 #define IDENTIFIER @"collectionViewCell"
 #define CellWidth (kScreenWidth-2*15-10)/2
 
 @interface PhotographyListController ()<UITableViewDataSource, UITableViewDelegate, PHFilterViewDelegate ,DXLTableViewDelegate,ADBannerViewDelegate,CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UICollectionViewDelegate>
 {
 PHButton *_selectedBtn;
 BOOL getFilterFromCahce; //是否从缓存取出数据
 PHFilterType currentType;
 }
 
 @property (weak, nonatomic) IBOutlet NSLayoutConstraint *separaterLineHeightLayout;
 @property (weak, nonatomic) IBOutlet DXLTableView *cutomTableView;
 @property (nonatomic, strong) NSMutableArray *dataSource;
 @property (nonatomic, strong) PHFilterView *filterView;
 @property (weak, nonatomic) IBOutlet UIView *topContainorView;
 @property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopLayout;
 
 @property (strong, nonatomic) NSMutableDictionary *paramDic;
 @property (nonatomic, strong) PHFilterModel *filterModel;
 @property (strong,nonatomic) ADBannerView * adBanner;
 
 //所有筛选条件
 @property (nonatomic, strong) NSMutableDictionary *regionDic;
 @property (nonatomic, strong) NSMutableDictionary *featureDic;
 @property (nonatomic, strong) NSMutableDictionary *sortDic;
 
 //当前筛选url
 @property (nonatomic, copy) NSString *regionUrl;
 @property (nonatomic, copy) NSString *featureUrl;
 @property (nonatomic, copy) NSString *sortUrl;
 
 @property (nonatomic, strong) UISegmentedControl *segment ;
 @property (nonatomic, strong) UICollectionView   *collectionView ;
 @property (nonatomic, strong) NSMutableArray     *collectionDataArray ;
 
 @end
 
 @implementation PhotographyListController
 
 - (NSString *)getAnalysisLabel
 {
 return NSStringFromClass([self class]);
 }
 
 - (NSString *)getTitleText
 {
 return [self stringFromString:(self.params[@"title"])?self.params[@"title"]:@"商家" withWidth:kScreenWidth - 88 - 4 withFont:[UIFont boldSystemFontOfSize:18.f]];
 }
 
 - (NSString *)stringFromString:(NSString *)string withWidth:(CGFloat)width withFont:(UIFont *)font
 {
 NSInteger currentLength = string.length;
 NSString *targetStr = @"";
 BOOL shouldCut = NO;
 for (int i = 0; ; i++) {
 NSString *str = nil;
 if (shouldCut) {
 str = [[string substringFromIndex:0 length:currentLength] stringByAppendingString:@"..."];
 }
 else {
 str = [string substringFromIndex:0 length:currentLength];
 }
 CGSize size = [str sizeWithFont:font];
 if (size.width > width) {
 shouldCut = YES;
 currentLength -= 1;
 }
 else {
 targetStr = str;
 break;
 }
 }
 return targetStr;
 }
 
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view from its nib.
 
 self.paramDic = [NSMutableDictionary dictionaryWithCapacity:0];
 self.separaterLineHeightLayout.constant = 0.5f;
 [self.view setNeedsUpdateConstraints];
 
 self.dataSource = [NSMutableArray array];
 self.regionDic = [NSMutableDictionary dictionaryWithCapacity:0];
 self.featureDic = [NSMutableDictionary dictionaryWithCapacity:0];
 self.sortDic = [NSMutableDictionary dictionaryWithCapacity:0];
 self.filterView = [[PHFilterView alloc] initWithVCType:FilterVCTypePH];
 self.collectionDataArray = [NSMutableArray array] ;
 
 _filterView.delegate = self;
 
 [self.cutomTableView createHeader];
 [self.cutomTableView createFooter];
 [_cutomTableView registerNib:[PHListCell nib] forCellReuseIdentifier:@"PHList"];
 _cutomTableView.apiPath = ApiPHList;
 _cutomTableView.jsonModel = NSStringFromClass([MsgResultArray class]);
 _cutomTableView.openCache = YES;
 _cutomTableView.refreshDelegate = self;
 
 _cutomTableView.hidden = YES;
 _topContainorView.hidden = YES;
 CityVo *city = [CMUtils acquireCityMsg];
 [_paramDic setObject:city.shortName forKey:@"city_name"];
 [_paramDic setObject:_cutomTableView.pageStr forKey:@"page"];
 if (_filterUrl) {
 [_paramDic setObject:_filterUrl forKey:@"tag"];
 }
 if (self.params[@"keyword"]) {
 [_paramDic setObject:self.params[@"keyword"] forKey:@"keyword"];
 }
 [self requestFilter];
 
 }
 
 - (void)viewWillAppear:(BOOL)animated
 {
 [super viewWillAppear:animated];
 if (![self.params[@"fromType"] isEqualToString:@"search"]) {
 [self setNavigationBarItem];
 }
 if (_collectionView && _cutomTableView && _topContainorView) {
 _collectionView.hidden = YES ;
 _cutomTableView.hidden = NO;
 _topContainorView.hidden = NO;
 }
 }
 
 - (void)viewWillDisappear:(BOOL)animated
 {
 [super viewWillDisappear:animated];
 if (![self.params[@"fromType"] isEqualToString:@"search"]) {
 [self removeNavigationBarItem];
 }
 }
 
 - (void)setNavigationBarItem
 {
 WButton *searchBtn = [WButton buttonWithType:UIButtonTypeCustom];
 searchBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
 searchBtn.tag = 1000;
 [searchBtn setImage:[DXLUtils getImageFromBundle:@"hotel_list_search"] forState:UIControlStateNormal];
 [searchBtn setImage:[DXLUtils getImageFromBundle:@"hotel_list_search"] forState:UIControlStateHighlighted];
 searchBtn.contentMode = UIViewContentModeCenter;
 CGRect rect = [UIScreen mainScreen].bounds;
 searchBtn.frame = CGRectMake(CGRectGetWidth(rect) - 40, 0, 40, 40);
 __weak typeof(self) weakSelf = self;
 [searchBtn dxl_ButtonWithOptions:@{kButtonType: @(ButtonTypeNone)} withClickBlock:^(WButton *reuseBtn) {
 DXLStatisticsEvent(@"SheYingList_Search_But", @"婚纱摄影_列表_搜索按钮");
 [weakSelf searchAction];
 }];
 
 [self.navigationController.navigationBar addSubview:searchBtn];
 
 _segment = [[UISegmentedControl alloc] init];
 _segment.tag = 100 ;
 _segment.frame = CGRectMake((kScreenWidth-117)/2, 20+(44-25)/2, 117, 50/2.0) ;
 _segment.backgroundColor = [UIColor whiteColor] ;
 _segment.tintColor = [UIColor colorFromHexString:@"#FF608E"] ;
 _segment.layer.borderWidth = 1.f ;
 _segment.layer.borderColor = [UIColor colorFromHexString:@"#FF608E"].CGColor ;
 _segment.layer.cornerRadius = 10/2.0 ;
 [_segment insertSegmentWithTitle:@"商家" atIndex:0 animated:NO];
 [_segment insertSegmentWithTitle:@"作品" atIndex:1 animated:NO];
 _segment.selectedSegmentIndex = 0 ;
 [_segment addTarget:self action:@selector(segmentChange:) forControlEvents:UIControlEventValueChanged] ;
 [self.navigationController.view addSubview:_segment] ;
 }
 
 
 - (void)removeNavigationBarItem
 {
 UIView *view = [self.navigationController.navigationBar viewWithTag:1000];
 if (view) {
 [view removeFromSuperview];
 }
 
 UISegmentedControl *seg = (UISegmentedControl*)[self.navigationController.view viewWithTag:100] ;
 [seg removeFromSuperview ] ;
 }
 
 
 - (void)searchAction
 {
 [self openViewController:NSStringFromClass([PhotographySearchController class]) withParam:nil isNib:YES];
 }
 
 
 
 #pragma mark - private methods
 -(void)segmentChange:(UISegmentedControl*)seg
 {
 if(seg.selectedSegmentIndex == 0) //商家
 {
 _cutomTableView.hidden = NO;
 _topContainorView.hidden = NO;
 UIView *view = [self.navigationController.navigationBar viewWithTag:1000];
 if (view) {
 view.hidden = NO;
 }
 if (_collectionView) {
 _collectionView.hidden = YES ;
 }
 }
 else //作品
 {
 _cutomTableView.hidden = YES;
 _topContainorView.hidden = YES;
 UIView *view = [self.navigationController.navigationBar viewWithTag:1000];
 if (view) {
 view.hidden = YES;
 }
 
 if (_collectionView == nil) {
 [self requestCollectionViewData];
 
 CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init] ;
 layout.sectionInset = UIEdgeInsetsMake(15, 15, 10, 15);
 layout.minimumColumnSpacing = 10;
 layout.minimumInteritemSpacing = 10;
 
 _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout] ;
 _collectionView.delegate = self ;
 _collectionView.dataSource = self ;
 _collectionView.backgroundColor = [UIColor colorFromHexString:@"#F0F0F0"] ;
 _collectionView.hidden = NO ;
 [_collectionView registerClass:[PHSampleWithBizCell class] forCellWithReuseIdentifier:IDENTIFIER] ;
 [_collectionView addHeaderWithTarget:self action:@selector(refreshCollectionData)];
 [_collectionView addFooterWithTarget:self action:@selector(requestMoreForCollection)];
 [self.view addSubview:_collectionView] ;
 [_collectionView reloadData];
 NSLog(@"hehhhhh");
 }else
 _collectionView.hidden = NO ;
 }
 }
 -(void)requestCollectionViewData
 {
 [self showLoading];
 __weak typeof(self) weakSelf = self ;
 
 [[DXLApiClient shareTestApiClientInstance]sendRequestWithPath:@"biz/wedding/albumlist" withRequestMethod:HttpRequestMethodGET withParams:@{@"biz_id":@(11),@"offset":@(0),@"limit":@(10),@"pageType":@"ZhaoPianJi"} withJSONModelStr:NSStringFromClass([MsgResultArray class]) withResponseBlock:^(ResponseType type, id responseData) {
 if (type == ResponseSuccessAndDataExist) {
 if ([responseData isKindOfClass:[MsgResultArray class]]) {
 MsgResultArray * array = (MsgResultArray *)responseData;
 //NSLog(@"%@",array.msg);
 weakSelf.collectionDataArray =  [[JSONModelArray alloc] initWithArray:array.data modelClass:[PHSampleModel class]];
 NSLog(@"拿到%d个数据,",weakSelf.collectionDataArray.count) ;
 [weakSelf.collectionView reloadData];
 [weakSelf hideLoadingViewImmediately];
 }
 }
 else if (type == ResponseFailure){
 NSLog(@"获取数据失败,");
 }
 
 }];
 
 }
 -(void)refreshCollectionData
 {
 [self requestCollectionViewData];
 [_collectionView.header endRefreshing];
 }
 -(void)requestMoreForCollection
 {
 static  int pageIndex = 0 ;
 pageIndex++ ;
 __weak typeof(self) weakSelf = self ;
 [[DXLApiClient shareTestApiClientInstance]sendRequestWithPath:@"biz/wedding/albumlist" withRequestMethod:HttpRequestMethodGET withParams:@{@"biz_id":@(11),@"offset":@(pageIndex),@"limit":@(10),@"pageType":@"ZhaoPianJi"} withJSONModelStr:NSStringFromClass([MsgResultArray class]) withResponseBlock:^(ResponseType type, id responseData) {
 if (type == ResponseSuccessAndDataExist) {
 if ([responseData isKindOfClass:[MsgResultArray class]]) {
 MsgResultArray * array = (MsgResultArray *)responseData;
 //NSLog(@"%@",array.msg);
 weakSelf.collectionDataArray =  [[JSONModelArray alloc] initWithArray:array.data modelClass:[PHSampleModel class]];
 NSLog(@"拿到%d个数据,",weakSelf.collectionDataArray.count) ;
 [weakSelf.collectionView reloadData];
 }
 }
 }];
 [_collectionView.footer endRefreshing];
 }
 - (void)requestFilter
 {
 __weak typeof(self) weakself = self;
 [self showLoading];
 [self requestFilterConditionWithComplete:^(BOOL success) {
 
 if (success) {
 [weakself checkFilter];
 weakself.cutomTableView.params = _paramDic;
 }
 else {
 [self hideLoadingViewImmediately];
 [weakself addErrorViewWithType:ErrorViewTypeDefault inView:weakself.view withOperationBlock:^(id sender) {
 [weakself requestFilter];
 }];
 }
 }];
 }
 
 - (void)checkFilter
 {
 NSArray *names = [_filterModel.feature valueForKeyPath:@"name"];
 BOOL hasName = NO;
 for (NSString *str in names) {
 if ([str isEqualToString:_filterText]) {
 hasName = YES;
 }
 }
 if (!hasName) {
 switch (_filterType) {
 case PHFilterTypeRegion:
 _filterText = @"全部商区";
 break;
 case PHFilterTypeStyle:
 _filterText = @"全部风格";
 break;
 case PHFilterTypeSort:
 _filterText = @"智能排序";
 break;
 
 default:
 break;
 }
 
 _filterUrl = @"";
 }
 
 if (_filterText && _filterUrl) {
 NSInteger tag = 101;
 switch (_filterType) {
 case PHFilterTypeRegion:
 [_filterView.dic setObject:_filterUrl forKey:region];
 self.regionUrl = _filterUrl;
 tag = 101;
 break;
 case PHFilterTypeStyle:
 [_filterView.dic setObject:_filterUrl forKey:style];
 self.featureUrl = _filterUrl;
 tag = 102;
 break;
 case PHFilterTypeSort:
 [_filterView.dic setObject:_filterUrl forKey:sort];
 self.sortUrl = _filterUrl;
 tag = 103;
 break;
 
 default:
 break;
 }
 PHButton *button = (PHButton *)[_topContainorView viewWithTag:tag];
 [button setTitle:_filterText forState:UIControlStateNormal];
 
 }
 
 }
 
 
 - (IBAction)clickAction:(PHButton *)sender {
 
 switch (sender.tag) {
 case 101:
 DXLStatisticsEvent(@"SheYingList_Filter_item1", @"婚纱摄影_列表_筛选条件1");
 break;
 case 102:
 DXLStatisticsEvent(@"SheYingList_Filter_item2", @"婚纱摄影_列表_筛选条件2");
 break;
 case 103:
 DXLStatisticsEvent(@"SheYingList_Filter_item3", @"婚纱摄影_列表_筛选条件3");
 break;
 
 default:
 break;
 }
 
 
 sender.selected = !sender.selected;
 if (sender.selected) {
 if (_selectedBtn && _selectedBtn != sender) {
 _selectedBtn.selected = NO;
 }
 _selectedBtn = sender;
 switch (sender.tag) {
 case 101:
 {
 currentType = PHFilterTypeRegion;
 [_filterView showInView:_cutomTableView withData:self.regionDic belowView:_topContainorView withType:PHFilterTypeRegion];
 }
 break;
 case 102:
 {
 currentType = PHFilterTypeStyle;
 [_filterView showInView:_cutomTableView withData:self.featureDic belowView:_topContainorView withType:PHFilterTypeStyle];
 }
 break;
 case 103:
 {
 currentType = PHFilterTypeSort;
 [_filterView showInView:_cutomTableView withData:self.sortDic belowView:_topContainorView withType:PHFilterTypeSort];
 }
 break;
 
 default:
 break;
 }
 
 }
 else {
 [_filterView hidden];
 }
 
 }
 #pragma mark - UIcollectinView  Delegate
 -(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
 {
 return 1 ;
 }
 -(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
 {
 return _collectionDataArray.count ;
 }
 -(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 PHSampleWithBizCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:IDENTIFIER forIndexPath:indexPath] ;
 if (_collectionDataArray.count > 0) {
 cell.sampleModel = _collectionDataArray[indexPath.row] ;
 }
 return cell ;
 }
 -(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
 {
 if (_collectionDataArray.count > 0)
 {
 PHSampleModel *model = [_collectionDataArray objectAtIndex:indexPath.row] ;
 UIImage *img = [UIImage imageWithContentsOfURL:[NSURL URLWithString:model.cover]];
 float height = img.size.height*CellWidth/img.size.width + 35+23 ;
 return CGSizeMake(CellWidth, height) ;
 }
 return CGSizeMake(CellWidth, 200) ;
 }
 -(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
 {
 return YES ;
 }
 -(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
 {
 PHSampleModel *model = _collectionDataArray[indexPath.row] ;
 //    [self openViewController:NSStringFromClass([PHSampleDetailController class]) withParam:@{@"album_id":@(1),@"biz_id":@(11)}];
 PHSampleDetailController *sampleDetail = [[PHSampleDetailController alloc] init] ;
 sampleDetail.title = model.name ;
 sampleDetail.album_id = model.id ;
 sampleDetail.biz_id = @"11" ;
 [self.navigationController pushViewController:sampleDetail animated:YES] ;
 }
 #pragma mark - UITableView Delegate And DataSource
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
 {
 return _dataSource.count;
 }
 
 
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 PHListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PHList" forIndexPath:indexPath];
 cell.model = _dataSource[indexPath.row];
 return cell;
 }
 
 
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
 return 87.f;
 }
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
 DXLStatisticsEvent(@"SheYingList_Item_All", @"婚纱摄影_列表_item");
 PHListModel *model = _dataSource[indexPath.row];
 [self openViewController:NSStringFromClass([PhotographyDetailViewController class]) withParam:@{@"biz_id":model.biz_id} isNib:YES];
 }
 
 #pragma mark - PHFilterView Delegate
 
 
 - (void)didSelectedItem:(PHFilterCell *)item withIndexPath:(NSIndexPath *)indexPath
 {
 [_selectedBtn setTitle:item.cellTitle forState:UIControlStateNormal];
 
 switch (_selectedBtn.tag) {
 case 101:
 {
 PHFilterItemModel *model = self.filterModel.region[indexPath.row];
 self.regionUrl = model.url;
 
 NSString *str = [_paramDic objectForKey:@"tag"];
 if (str && ![str isEqualToString:@""]) {
 str = [str stringByAppendingString:[NSString stringWithFormat:@"-%@",model.url]];
 }
 else {
 str = item.cellTitle;
 }
 [_paramDic setObject:str forKey:@"tag"];
 }
 break;
 case 102:
 {
 PHFilterItemModel *model = self.filterModel.feature[indexPath.row];
 self.featureUrl = model.url;
 NSString *str = [_paramDic objectForKey:@"tag"];
 if (str && ![str isEqualToString:@""]) {
 str = [str stringByAppendingString:[NSString stringWithFormat:@"-%@",model.url]];
 }
 else {
 str = item.cellTitle;
 }
 [_paramDic setObject:str forKey:@"tag"];
 }
 break;
 case 103:
 {
 PHFilterItemModel *model = self.filterModel.sort[indexPath.row];
 self.sortUrl = model.url;
 [_paramDic setObject:model.url forKey:@"sort"];
 }
 break;
 
 default:
 break;
 }
 NSString *tagStr = nil;
 NSString *sortStr = nil;
 if (self.regionUrl && ![self.regionUrl isEqualToString:@""]) {
 tagStr = self.regionUrl;
 }
 if (self.featureUrl && ![self.featureUrl isEqualToString:@""]) {
 if (tagStr) {
 tagStr = [tagStr stringByAppendingString:[NSString stringWithFormat:@"-%@",self.featureUrl]];
 }
 else {
 tagStr = self.featureUrl;
 }
 }
 if (self.sortUrl && ![self.sortUrl isEqualToString:@""]) {
 sortStr = self.sortUrl;
 }
 if (tagStr) {
 [_paramDic setObject:tagStr forKey:@"tag"];
 }
 else {
 [_paramDic removeObjectForKey:@"tag"];
 }
 if (sortStr) {
 [_paramDic setObject:sortStr forKey:@"sort"];
 }
 else {
 [_paramDic removeObjectForKey:@"sort"];
 }
 
 _selectedBtn.selected = NO;
 _selectedBtn = nil;
 [_filterView hidden];
 
 [_cutomTableView beginRefreshHeader];
 }
 
 - (void)unShowFilterView
 {
 if (_selectedBtn) {
 _selectedBtn.selected = NO;
 _selectedBtn = nil;
 }
 }
 
 
 #pragma mark - DXLTableView delegate
 - (void)requestMore:(DXLTableView *)table
 {
 [self.paramDic setObject:_cutomTableView.pageStr forKey:@"page"];
 _cutomTableView.params = self.paramDic;
 }
 
 - (void)update:(DXLTableView *)table
 {
 [_cutomTableView resetPageToOrigin];
 [self.paramDic setObject:_cutomTableView.pageStr forKey:@"page"];
 _cutomTableView.params = self.paramDic;
 }
 
 - (void)requestSuccess:(BOOL)yesOrNo withResponse:(id)response wtihRefreshType:(RefreshType)refreshType withError:(NSError *)error withTable:(DXLTableView *)table
 {
 if (yesOrNo && !error) {
 self.adBanner = [[ADBannerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 60) WithAdType:AdRequestTypeHotelList WithDelegate:self WithController:self];
 switch (refreshType) {
 case RefreshTypeNone:
 case RefreshTypeHeader:
 {
 if ([response isKindOfClass:[MsgResultArray class]]) {
 MsgResultArray *resultModel = response;
 NSArray *modelArr = [[JSONModelArray alloc] initWithArray:resultModel.data modelClass:[PHListModel class]];
 if (modelArr.count == 0) {
 [self addErrorViewWithType:ErrorViewTypePH withOperationBlock:nil];
 UIView *view = [self addErrorViewWithType:ErrorViewTypePH withRect:CGRectMake(0, CGRectGetHeight(_topContainorView.bounds), kScreenWidth, CGRectGetHeight(_cutomTableView.bounds)) withOperationBlock:nil];
 
 [self.view insertSubview:view belowSubview:_topContainorView];
 [self.view insertSubview:_filterView belowSubview:_topContainorView];
 }
 else {
 _cutomTableView.hidden = NO;
 _topContainorView.hidden = NO;
 [_dataSource removeAllObjects];
 [_dataSource addObjectsFromArray:modelArr];
 [_cutomTableView reloadData];
 _cutomTableView.isLast = [resultModel.total integerValue] <= _dataSource.count;
 }
 }
 }
 break;
 case RefreshTypeFooter:
 {
 if ([response isKindOfClass:[MsgResultArray class]]) {
 MsgResultArray *resultModel = response;
 NSArray *modelArr = [[JSONModelArray alloc] initWithArray:resultModel.data modelClass:[PHListModel class]];
 
 _cutomTableView.hidden = NO;
 _topContainorView.hidden = NO;
 
 
 [_dataSource addObjectsFromArray:modelArr];
 
 [_cutomTableView reloadData];
 
 _cutomTableView.isLast = [resultModel.total integerValue] <= _dataSource.count;
 }
 }
 break;
 default:
 break;
 }
 }
 
 }
 
 #pragma mark - AdDelegate
 -(void)ADshowOrNot:(BOOL)showOrNot
 {
 if (showOrNot) {
 self.tableViewTopLayout.constant = 60.0f;
 }
 else
 {
 self.tableViewTopLayout.constant = 0.0f;
 [self.adBanner removeFromSuperview];
 }
 }
 
 #pragma mark - request filter condition
 
 - (void)requestFilterConditionWithComplete:(void(^)(BOOL success))block
 {
 
 CityVo *vo = [CMUtils acquireCityMsg];
 __weak typeof(self) weakself = self;
 
 
 [[DXLApiClient shareApiClientInstance] sendDXLRequestWithPath:ApiPHSearchCondition withCacheType:CacheDataTypeDefault withRequestMethod:HttpRequestMethodGET withParams:@{@"city_name":vo.shortName} withJSONModelStr:NSStringFromClass([MsgResult class]) withResponseBlock:^(ResponseType type, id responseData) {
 switch (type) {
 case ResponseCacheSuccess:
 {
 
 [weakself dealResponse:responseData];
 getFilterFromCahce = YES;
 
 if (block) {
 block(YES);
 }
 }
 break;
 case ResponseSuccessAndDataExist:
 {
 
 [weakself dealResponse:responseData];
 
 if (!getFilterFromCahce) {
 if (block) {
 block(YES);
 }
 }
 }
 break;
 
 case ResponseFailureWithCache:
 case ResponseSuccessAndServerErrorWithCache:
 case ResponseSuccessAndDataFormatErrorWithCache:
 {
 if (!getFilterFromCahce) {
 if (block) {
 block(YES);
 }
 }
 }
 break;
 
 default:
 {
 if (block) {
 block(NO);
 }
 }
 break;
 }
 }];
 
 }
 
 
 - (void)dealResponse:(id)responseData
 {
 if (![responseData isKindOfClass:[MsgResult class]]) {
 return;
 }
 PHFilterModel *model = [[PHFilterModel alloc] initWithDictionary:((MsgResult *)responseData).data error:nil];
 
 PHFilterItemModel *regionModel = [[PHFilterItemModel alloc] init];
 regionModel.name = @"全部商区";
 regionModel.url = @"";
 
 PHFilterItemModel *featureModel = [[PHFilterItemModel alloc] init];
 featureModel.name = @"全部风格";
 featureModel.url = @"";
 
 NSMutableArray *arr = [NSMutableArray arrayWithArray:model.region];
 [arr insertObject:regionModel atIndex:0];
 model.region = [arr copy];
 
 
 NSMutableArray *arr1 = [NSMutableArray arrayWithArray:model.feature];
 [arr1 insertObject:featureModel atIndex:0];
 model.feature = [arr1 copy];
 
 PHFilterItemModel *sortModel1 = [[PHFilterItemModel alloc] init];
 sortModel1.name = @"智能排序";
 sortModel1.url = @"";
 
 PHFilterItemModel *sortModel2 = [[PHFilterItemModel alloc] init];
 sortModel2.name = @"价格降序";
 sortModel2.url = @"Price_DESC";
 
 PHFilterItemModel *sortModel3 = [[PHFilterItemModel alloc] init];
 sortModel3.name = @"价格升序";
 sortModel3.url = @"Price_ASC";
 
 NSArray *arr2 = @[sortModel1, sortModel2 , sortModel3];
 model.sort = [arr2 copy];
 
 self.filterModel = model;
 [self.regionDic setObject:[model.region valueForKeyPath:@"name"] forKey:@"name"];
 [self.regionDic setObject:[model.region valueForKeyPath:@"url"] forKey:@"url"];
 
 [self.featureDic setObject:[model.feature valueForKeyPath:@"name"] forKey:@"name"];
 [self.featureDic setObject:[model.feature valueForKeyPath:@"url"] forKey:@"url"];
 
 [self.sortDic setObject:[model.sort valueForKeyPath:@"name"] forKey:@"name"];
 [self.sortDic setObject:[model.sort valueForKeyPath:@"url"] forKey:@"url"];
 }
 
 
 @end

 */

@end
