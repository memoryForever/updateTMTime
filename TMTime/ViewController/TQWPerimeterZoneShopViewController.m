//
//  TQWPerimeterZoneShopViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/8.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWPerimeterZoneShopViewController.h"
#import "TQWPerimeterZoneShopViewModel.h"
#import "TQWAnnotation.h"
#import "TQWAnnotationView.h"
#import "TQWSearchPerimeterViewController.h"

//如需更改,请同时该stroybard 对应位置
#define  kShopTableViewCellReuseIdentified @"shopTableViewCell"
#define  kSearchSegueIdentified @"searchSegue"

typedef NS_ENUM(NSInteger ,SegmentedSelectedViewController){
    SegmentedSelectedViewControllerMapView = 0,
    SegmentedSelectedViewControllerTableView ,
};
//自定义商品cell
@interface TQWShopTableViewCell : UITableViewCell
/** 商品图片 **/
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
/** 商品名 **/
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
/** 商品价格 **/
@property (weak, nonatomic) IBOutlet UILabel *shopPriceLabel;
/** 预约按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *reservationButton;
/** 商品折扣 **/
@property (weak, nonatomic) IBOutlet UILabel *discountLable;
/** 商品店距离 **/
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end

@implementation TQWShopTableViewCell

@end



@interface TQWPerimeterZoneShopViewController ()<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate>

/** 地图视图view **/
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
/** 商品列表 tableview **/
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** 当前城市 button **/
@property (weak, nonatomic) IBOutlet UIBarButtonItem *currentCityButton;
/** 重新定位  **/
@property (weak, nonatomic) IBOutlet UIBarButtonItem *currentLocation;
/** 切换视图 segmente controller **/
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeViewSegment;
/** 返回按钮 **/
@property (weak, nonatomic) IBOutlet UIButton *backButton;

/** viewModel **/
@property (strong ,nonatomic) TQWPerimeterZoneShopViewModel *perimeterZoneViewModel;

//相关事件方法
/** 重新定位 **/
- (IBAction)relocationButtonAction:(id)sender;
/** 改变现实视图 **/
- (IBAction)viewChangedsegmentedAction:(id)sender;
/** 返回按钮事件 **/
- (IBAction)back:(UIButton *)sender;

@end

@implementation TQWPerimeterZoneShopViewController

#pragma mark - 懒加载

- (TQWPerimeterZoneShopViewModel *)perimeterZoneViewModel{
    if (!_perimeterZoneViewModel) {
        _perimeterZoneViewModel = [[TQWPerimeterZoneShopViewModel alloc]init];
        //赋值成功,添加地图标签
    }
    
    return _perimeterZoneViewModel;
}

#pragma tableViwe delegate dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
   return  [self.perimeterZoneViewModel rowNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TQWShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kShopTableViewCellReuseIdentified forIndexPath:indexPath];
    NSUInteger index = indexPath.row;
    cell.shopNameLabel.text = [self.perimeterZoneViewModel bussinessNameWithIndex:index];
    [cell.shopImageView loadImageWithURL:[self.perimeterZoneViewModel bussinessImageURLStringWithIndex:index]];
    cell.discountLable.text = [self.perimeterZoneViewModel bussinessDisCountWithIndex:index];
    cell.distanceLabel.text = [self.perimeterZoneViewModel bussinessDistanceWithIndex:index];
    
    NSAttributedString *RMBlogo = [[NSAttributedString alloc]initWithString:@"¥ "
                                                                attributes:@{
                                                       NSFontAttributeName:[UIFont boldSystemFontOfSize:13],
                                            NSForegroundColorAttributeName:kRGBAColor(226, 198, 73, 1),
                                                                            }];
    NSAttributedString *priceString = [[NSAttributedString alloc]initWithString:[self.perimeterZoneViewModel bussinessPriceWthIndex:index]
                    attributes:@{
           NSFontAttributeName:[UIFont systemFontOfSize:20],
NSForegroundColorAttributeName:kRGBAColor(83, 145, 0, 1),
                                                    }];
    NSMutableAttributedString *mAttString = [[NSMutableAttributedString alloc]initWithAttributedString:RMBlogo];
    [mAttString appendAttributedString:priceString];
    cell.shopPriceLabel.attributedText = mAttString;
    //添加 annotation
    TQWAnnotation *ann = [self.perimeterZoneViewModel bussinessAnnotationWithIndex:index];
    [self.mapView addAnnotation:ann];
    if (index % 5 == 0 && ann) {
        [self.mapView setRegion:MKCoordinateRegionMake(ann.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
    }
    return cell;
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view bringSubviewToFront:_backButton];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange) name:kCurrentCityChangeNotification object:nil];
    [self.currentCityButton setTitle:kCurrentCityNameValue];
    [self.tableView setHidden:YES];
    kWeakSelf(mySelf);
    [self.perimeterZoneViewModel getBussinessInfoCompleteHandler:^(NSError *error) {
        if (error) {
            if (error.code == kNotMoreData) {
                [mySelf.view showSuccess:@"没有更多数据载入了"];
            }
        }else{
           [mySelf.tableView reloadData];
        }
        [mySelf.tableView endedFooterRefersh];
        [mySelf.tableView endedHeadRefersh];
    }];
    [mySelf.tableView addHeadRefershAnimation:^{
        [mySelf.perimeterZoneViewModel refershDataAndRefersh:RefershTypePullUp];
    }];
    [mySelf.tableView addFooterRefersh:^{
        [mySelf.perimeterZoneViewModel refershDataAndRefersh:RefershTypeLoadModeData];
    }];
    //配置 mapView
    self.mapView.showsUserLocation = YES ;
    //itouch 上调试失败,不能添加这句
   // self.mapView.showsScale = YES ;
}

- (void)dealloc{
    kRemoveAllObserver;
    kTestMEM;
    self.mapView.showsUserLocation = NO;
    self.mapView.userTrackingMode  = MKUserTrackingModeNone;
    [self.mapView.layer removeAllAnimations];
    [self.mapView removeAnnotations:self.mapView.annotations];
    [self.mapView removeOverlays:self.mapView.overlays];
    [self.mapView removeFromSuperview];
    self.mapView.delegate = nil;
    self.mapView = nil;
    
}
#pragma mark - mapView delegate 
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if (![annotation isKindOfClass:[TQWAnnotation class]]) {
        return nil;
    }
    TQWAnnotationView *anntationView = [TQWAnnotationView annotationViewWithMakView:mapView annotation:annotation];
    anntationView.canShowCallout = YES ;
    return anntationView;
}
- (void)mapView:(MKMapView *)mapView didChangeUserTrackingMode:(MKUserTrackingMode)mode animated:(BOOL)animated{
    [_mapView removeFromSuperview];
    [self.view addSubview:_mapView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - 事件响应方法
- (IBAction)relocationButtonAction:(id)sender {
    [self.perimeterZoneViewModel refershDataAndRefersh:RefershTypeRelocation];
}

- (IBAction)viewChangedsegmentedAction:(UISegmentedControl*)sender {
    _tableView.hidden = !_tableView.hidden;
    _mapView.hidden = !_tableView.hidden;
    
    [self.tableView reloadData];
}

- (IBAction)back:(UIButton *)sender {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)cityChange{
   [self.currentCityButton setTitle:kCurrentCityNameValue];
    [self.perimeterZoneViewModel refershDataAndRefersh:RefershTypeCityChange];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    kWeakSelf(mySelf);
    if ([segue.identifier isEqualToString:kSearchSegueIdentified]) {
        TQWSearchPerimeterViewController *SearchVC = segue.destinationViewController;
        SearchVC.backBlock = ^(BussinessType category ,NSString *keyword){
            [mySelf.perimeterZoneViewModel bussinessSearchCategory:category keyword:keyword];
        };
    }
}

#pragma mark - 实例方法

@end
