//
//  TQWRefershAnimationVC.m
//  TMtime
//
//  Created by tarena33 on 16/3/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TQWRefershAnimationVC.h"

@interface TQWRefershAnimationVC ()
@property(nonatomic,strong)UIImageView *imageView ;
@property(nonatomic,strong)NSMutableArray<UIImage*>* arrayImage;
@end
static __weak TQWRefershAnimationVC * _shareObect ;
@implementation TQWRefershAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.bounds = CGRectMake(0, 0, 96, 160);
    self.imageView.center = self.view.center;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_imageView];
    self.view.hidden = NO ;
    if(!self.imageView.animationImages)
    {
        self.imageView.animationImages = self.arrayImage;
        self.imageView.animationDuration = self.arrayImage.count * 0.05;
        self.imageView.animationRepeatCount = 0 ;
    }
    [self.imageView startAnimating];
}


-(NSMutableArray<UIImage *> *)arrayImage{
    if (!_arrayImage) {
        _arrayImage = [NSMutableArray arrayWithCapacity:26];
        for (int i = 1; i < 27; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"loading%04d",i]];
            [_arrayImage addObject:image];
        }
    }
    return _arrayImage  ;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        _shareObect  = self;
    }
    return  self ;
}

+(void)startAnimationAtController:(UIViewController*)Controller{
    
    [Controller presentViewController:[[TQWRefershAnimationVC alloc]init] animated:NO completion:nil];
   
}
+(void)endAnimation{
    [_shareObect.imageView stopAnimating];
    [_shareObect dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
