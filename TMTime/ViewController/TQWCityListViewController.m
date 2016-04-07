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
    return cell ;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return [self.cityListViewModel sectionHeadWithSection:section];
}
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
  
    return  [self.cityListViewModel sectionIndexTitles] ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TQWCityListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark ;
}
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.cityListtableView registerClass:[TQWCityListCell class] forCellReuseIdentifier:kCityListTableViewCellReuseIdentified];
    [self.cityListViewModel getCityListCompleteHandler:^(NSError *error) {
        [self.cityListtableView reloadData];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

@end
