//
//  TQWSearchPerimeterViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/12.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWSearchPerimeterViewController.h"

@interface TQWSearchPerimeterViewController ()
//属性
@property (weak, nonatomic) IBOutlet UITextField *SearchTextField;
@property (weak, nonatomic) IBOutlet UIButton *fooderButton;
@property (weak, nonatomic) IBOutlet UIButton *hotelButton;
@property (weak, nonatomic) IBOutlet UIButton *supermarketButton;
@property (weak, nonatomic) IBOutlet UIButton *cinema;

//事件响应
- (IBAction)searchFooderButton:(id)sender;
- (IBAction)searchHotelButton:(id)sender;
- (IBAction)searchSupermarketButton:(id)sender;
- (IBAction)searchCinemaButton:(id)sender;
- (IBAction)back:(id)sender;
//存储属性
@property (nonatomic, assign) BussinessType type;
@end

@implementation TQWSearchPerimeterViewController
#pragma mark - 懒加载


#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  
}
#pragma mark - 事件响应方法

- (IBAction)searchFooderButton:(UIButton*)sender {
    [self clearSelectButton];
    _type = BussinessTypeFooder ;
    sender.selected = YES ;
    
}

- (IBAction)searchHotelButton:(UIButton*)sender {
    [self clearSelectButton];
    _type = BussinessTypeHotel;
    sender.selected = YES;
}

- (IBAction)searchSupermarketButton:(UIButton *)sender {
      [self clearSelectButton];
    _type = BussinessTypeSupermarker;
    sender.selected = YES;
}

- (IBAction)searchCinemaButton:(UIButton*)sender {
      [self clearSelectButton];
    _type = BussinessTypeCinema;
    sender.selected = YES;
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    _type = _type ? _type : BussinessTypeNone;
    self.backBlock(_type ,self.SearchTextField.text);
    
}
- (void)clearSelectButton{
    for (UIButton *button  in @[_fooderButton,_hotelButton,_supermarketButton,_cinema]) {
        button.selected = NO ;
    }
}
@end
