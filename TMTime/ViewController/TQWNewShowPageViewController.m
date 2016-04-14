//
//  TQWNewShowPageViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/14.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWNewShowPageViewController.h"
#import "M80AttributedLabel.h"
#import "UIImage+getNetworkImage.h"
#define kReplaceImageLog @"[ImageLogo]"

@interface TQWNewShowPageViewController ()
@property (nonatomic,strong) M80AttributedLabel *showLabel;
@property (nonatomic,strong) NSString * contentString ;
@property (nonatomic,strong) NSArray<NSString*> *imageURLs;
@property (nonatomic,strong) UIScrollView *scrolleView ; 
@property (nonatomic,strong) NSMutableArray<UIImage*>* images;
@end

@implementation TQWNewShowPageViewController
#pragma mark - 懒加载
- (M80AttributedLabel *)showLabel{
    if (!_showLabel) {
        _showLabel = [M80AttributedLabel new]   ;
    }
    return _showLabel   ;
}

- (UIScrollView *)scrolleView{
    if (!_scrolleView) {
        _scrolleView = [[UIScrollView alloc]initWithFrame:CGRectZero];
    }
    return _scrolleView;
}

#pragma mark - 配置约束
- (void)setupConstraint{
    kWeakSelf(mySelf);
    [self.view addSubview:self.scrolleView];
    [self.scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(mySelf.view);
    }];
    [self.scrolleView addSubview:self.showLabel];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(mySelf.view);
        make.edges.equalTo(mySelf.scrolleView);
    }];
    self.showLabel.numberOfLines = 0 ;
}


#pragma mark - 值传递方法
- (void)showContentString:(NSString *)contentString Images:(NSArray<NSString *> *)ImageURLs{
    _contentString = [contentString stringByReplacingRegex:@"<img src=.*>"
                                                   options: NSRegularExpressionCaseInsensitive
                                                withString:kReplaceImageLog];;
    _imageURLs = ImageURLs;
    kWeakSelf(mySelf);
    _images = [NSMutableArray arrayWithCapacity:ImageURLs.count];
    for (NSString *str in ImageURLs) {
        [UIImage getNetworkImageURL:str completeHandler:^(UIImage *image, NSError *error) {
            [_images addObject:image];
            [mySelf replaceImageInContent];
        }];
    }
}

#pragma  mark - 生命周期
- (void)viewDidLoad {
    [self setupConstraint];
    [self replaceImageInContent];
    [super viewDidLoad];
  
    
}
#pragma mark - 替换图片
- (void)replaceImageInContent{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *components = [self.contentString componentsSeparatedByString:kReplaceImageLog];
        for (NSInteger i = 0 ; i < components.count; i ++ ) {
            [self.showLabel appendText:components[i]];
            if (i != components.count - 1 && _images.count > i  ) {
                [self.showLabel appendImage:_images[i]
                                    maxSize:_images[i].size
                                     margin:UIEdgeInsetsZero
                                  alignment:M80ImageAlignmentCenter];
                
            }
        }
    });

    self.showLabel.frame = CGRectInset(self.scrolleView.bounds, 20, 20);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
