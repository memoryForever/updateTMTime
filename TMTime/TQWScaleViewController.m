//
//  TQWScaleViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/19.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWScaleViewController.h"

@interface TQWScaleViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong) UIImageView *imageView;
@property (nonatomic,assign) double scale;
@property (nonatomic,assign) double rotation;
@end

@implementation TQWScaleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithImage:_showImage];
    [self.view addSubview:_imageView];
    [_imageView sizeToFit];
    _imageView.multipleTouchEnabled = YES ;
    kWeakSelf(mySelf);
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(mySelf.view);
    }];
    
    self.imageView.userInteractionEnabled = YES;
     UITapGestureRecognizer *tap =  [[UITapGestureRecognizer  alloc]initWithActionBlock:^(id  _Nonnull sender) {
         mySelf.modalTransitionStyle =  UIModalTransitionStyleFlipHorizontal;
         [mySelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.imageView addGestureRecognizer:tap];
    tap.delegate = self;
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithActionBlock:^(UIPinchGestureRecognizer*  _Nonnull sender) {
        mySelf.imageView.layer.transform = CATransform3DScale(mySelf.imageView.layer.transform, sender.scale , sender.scale , 1);
    }];
    pinch.delegate = self ;
    [self.imageView addGestureRecognizer:pinch];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithActionBlock:^(UIRotationGestureRecognizer*  _Nonnull sender) {
        mySelf.imageView.layer.transform = CATransform3DRotate(mySelf.imageView.layer.transform, sender.rotation, 0, 0, 1);
      // mySelf.imageView.layer.transform;
//        {
//            NSLog(@"m11:%lf",mySelf.imageView.layer.transform.m11);
//            NSLog(@"m12:%lf",mySelf.imageView.layer.transform.m12);
//            NSLog(@"m13:%lf",mySelf.imageView.layer.transform.m13);
//            NSLog(@"m14:%lf",mySelf.imageView.layer.transform.m14);
//            NSLog(@"m21:%lf",mySelf.imageView.layer.transform.m21);
//            NSLog(@"m22:%lf",mySelf.imageView.layer.transform.m22);
//            NSLog(@"m23:%lf",mySelf.imageView.layer.transform.m23);
//            NSLog(@"m24:%lf",mySelf.imageView.layer.transform.m24);
//            NSLog(@"m31:%lf",mySelf.imageView.layer.transform.m31);
//            NSLog(@"m32:%lf",mySelf.imageView.layer.transform.m32);
//            NSLog(@"m33:%lf",mySelf.imageView.layer.transform.m33);
//            NSLog(@"m34:%lf",mySelf.imageView.layer.transform.m34);
//            NSLog(@"m41:%lf",mySelf.imageView.layer.transform.m41);
//            NSLog(@"m42:%lf",mySelf.imageView.layer.transform.m42);
//            NSLog(@"m43:%lf",mySelf.imageView.layer.transform.m43);
//            NSLog(@"m44:%lf",mySelf.imageView.layer.transform.m44);
//            NSLog(@"-----------------------");
//        }
    }];
    pinch.delegate = self ;
    [self.imageView addGestureRecognizer:rotation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
