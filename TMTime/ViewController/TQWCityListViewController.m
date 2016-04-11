//
//  TQWCityListViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/7.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWCityListViewController.h"
#import "TQWCityListViewModel.h"


#define kCityListTableViewCellReuseIdentified @"cityListCell"

@interface TQWCityListCell : UITableViewCell

@end

@implementation TQWCityListCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return  self;
}
@end

@interface TQWCityListViewController ()<UITableViewDataSource,UITableViewDelegate>

/** 顶部view属性 **/
@property (weak, nonatomic) IBOutlet UIView *topView;
/** 显示选中的城市,或当前城市 **/
@property (weak, nonatomic) IBOutlet UILabel *showCurrentCity;


//tableView属性
@property (weak, nonatomic) IBOutlet UITableView *cityListtableView;
//viewModel属性
@property(nonatomic,strong) TQWCityListViewModel *cityListViewModel;
//存储属性
/** 保存临时的城市名 **/
@property(nonatomic,strong) NSString *tempCity;

@end

@implementation TQWCityListViewController

#pragma mark - 懒加载 
- (TQWCityListViewModel *)cityListViewModel{
    if (!_cityListViewModel) {
        _cityListViewModel = [TQWCityListViewModel new];
    }
    return _cityListViewModel   ;
}

#pragma mark - 控制器响应方法
- (IBAction)locationButton:(id)sender {
   // [self confirmCurrentCity];
   //MVVM 优化
    [self.cityListViewModel backCurrentCityCompleteHandler:^(NSError *error) {
        self.showCurrentCity.text = kCurrentCityNameValue;
         [self.cityListtableView reloadData];
    }];
}
- (void)getCurrentCityNameCompleteHandler:(NSString *)cityName{
    self.showCurrentCity.text = cityName;
    [self.cityListtableView reloadData];
}

- (IBAction)back:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableViewDataSource , delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   
    return [self.cityListViewModel sectionNumber];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.cityListViewModel rowNumberWithSection:section];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TQWCityListCell *cell = [tableView dequeueReusableCellWithIdentifier:kCityListTableViewCellReuseIdentified forIndexPath:indexPath];
    cell.textLabel.text = [self.cityListViewModel cityNameWithIndexPath:indexPath];
    if ([self.showCurrentCity.text isEqualToString:[self.cityListViewModel cityNameWithIndexPath:indexPath]]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark ;
    }else{
       cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell ;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.cityListViewModel sectionHeadWithSection:section];
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
  
    return  [self.cityListViewModel sectionIndexTitles] ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.showCurrentCity.text = [self.cityListViewModel cityNameWithIndexPath:indexPath];
    [tableView reloadData];
}
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cityListtableView registerClass:[TQWCityListCell class] forCellReuseIdentifier:kCityListTableViewCellReuseIdentified];
    [self.cityListViewModel getCityListCompleteHandler:^(NSError *error) {
        [self.cityListtableView reloadData];
    }];
    self.showCurrentCity.text = kCurrentCityNameValue;
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    kSaveCurrentCityName(self.showCurrentCity.text);
    [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentCityChangeNotification object:self];
}
//设置导航栏的状态


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

@end
