//
//  TQWShowPagesViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/19.
//  Copyright © 2016年 涂清文. All rights reserved.
//


#import "TQWShowPagesViewController.h"
#import "TQWScaleViewController.h"
#import "TQWRefershAnimationVC.h"
#import "UIImage+getNetworkImage.h"
#import <YYTextAttribute.h>

#define kSeparator @"separatorCharater"

typedef NS_ENUM(NSInteger ,StringType) {
    StringTypeText,
    StringTypeImageUrl,
};

@interface TQWShowPagesViewController ()
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) NSMutableArray<NSString*> *contents;
@property (nonatomic,strong) NSMutableArray<NSString*> *imageURLs;
@property (nonatomic,strong) NSMutableAttributedString *text ;
@property (nonatomic,strong) UIScrollView *scrolleView;
@property (nonatomic,strong) YYLabel *yyLable;
@property (nonatomic,assign) CGFloat hight ;

@end

@implementation TQWShowPagesViewController
#pragma mark - 懒加载

- (NSMutableArray<UIImage *> *)imageContainer{
    if (!_imageContainer) {
        _imageContainer = @[].mutableCopy;
    }
    return _imageContainer;
}

//- (YYLabel *)yyLable{
//    if (!_yyLable) {
//        self.scrolleView = [[UIScrollView alloc]initWithFrame:CGRectZero];
//        kWeakSelf(mySelf);
//        [self.view addSubview:self.scrolleView];
//        [self.scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(mySelf.view);
//        }];
//        self.scrolleView.bounces = YES ;
//        self.automaticallyAdjustsScrollViewInsets = NO ;
//        _yyLable = [YYLabel new];
//        _yyLable.numberOfLines = 0 ;
//        _yyLable.textVerticalAlignment = YYTextVerticalAlignmentTop;
//        self.scrolleView.contentSize = CGSizeMake(300, 1000);
//        [self.scrolleView addSubview:_yyLable];
//        [_yyLable mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.mas_equalTo(mySelf.view.width - 20);
//            make.top.mas_equalTo(64);
//            make.centerX.equalTo(mySelf.view);
//        }];
//    }
//    return _yyLable;
//}
- (UITextView *)textView{
    if (!_textView) {
        _textView = [UITextView new];
        [self.view addSubview:_textView ];
    }
    return _textView;
}
- (NSMutableAttributedString*)text{
    if (!_text) {
        _text = [NSMutableAttributedString new];
    }
    return _text;
}
- (NSMutableArray<NSString *> *)contents
{
    if (!_contents) {
        _contents = @[].mutableCopy;
    }
    return _contents;
}

- (NSMutableArray<NSString *> *)imageURLs{
    if (!_imageURLs) {
        _imageURLs = @[].mutableCopy    ;
    }
    return _imageURLs;
}
#pragma mark - 处理方法
- (void) getAttributedString:(NSString*)string StringType:(StringType)type index:(NSUInteger)index{
    NSMutableAttributedString *attachment = nil;
    UIFont *font = [UIFont systemFontOfSize:16];
    if (type == StringTypeImageUrl) {
        UIImageView *imageView = [[UIImageView alloc]init];
        if(self.imageContainer.count != 0){
          imageView.image = self.imageContainer[index];  
        }
        
        if (!imageView.image) {
            [imageView loadImageWithURL:string];
        }
        [imageView sizeToFit];
        self.text.font = font;
        [self addGesture:imageView];
        attachment = [NSMutableAttributedString
                                                 attachmentStringWithContent:imageView
                                                 contentMode:UIViewContentModeCenter
                                                 attachmentSize:imageView.size
                                                 alignToFont:font
                                                 alignment:YYTextVerticalAlignmentTop];
       
    }
    if (type == StringTypeText) {
        attachment = [NSMutableAttributedString new];
        [attachment appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:nil]];
    }
    [attachment appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    !attachment?:[self.text appendAttributedString:attachment];
    return ;
}
- (void)addShowContent{
    kWeakSelf(mySelf);
    for (NSInteger i  = 0 ; i < self.contents.count; i ++) {
        [mySelf getAttributedString:mySelf.contents[i] StringType:StringTypeText index:0];
        if (i < mySelf.imageURLs.count) {
            [mySelf getAttributedString:mySelf.imageURLs[i] StringType:StringTypeImageUrl index:i];
        }
    }
    [mySelf refreshTextLabel];
   
}
#pragma mark - 添加手势
- (void) addGesture:(UIImageView*)view{
    view.userInteractionEnabled = YES;
    kWeakSelf(mySelf);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithActionBlock:^(id  _Nonnull sender) {
        TQWScaleViewController *vc = [[TQWScaleViewController alloc]init];
        vc.showImage = view.image;
        if (view.image) {
            [mySelf presentViewController:vc animated:YES completion:nil];
        }
    }];
    [view addGestureRecognizer:tap];
}

#pragma  mark - 添加refresh
- (void)refreshTextLabel{
    self.yyLable.attributedText =  [[NSAttributedString alloc]init];
    self.yyLable.attributedText = self.text;
    [self.yyLable sizeToFit];
    NSLog(@"yyLabel:%lf",self.yyLable.height);
    NSLog(@"scrollView:%lf",self.scrolleView.height);
}
#pragma mark - load image

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)viewWillAppear:(BOOL)animated{
   
    
}
- (void)viewWillLayoutSubviews{
    [self addShowContent];
}
- (void)viewDidLayoutSubviews{
      [self.yyLable sizeToFit];
      kWeakSelf(mySelf);
    [self.yyLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(mySelf.yyLable.height);
    }];
    NSLog(@"yyLabel:%lf",self.yyLable.height);
    NSLog(@"scrollView:%lf",self.scrolleView.height);
}
#pragma mark - 初始化方法
- (void)showDetailContent:(NSString *)content imageURLStrs:(NSArray <NSString *>*)imageURLStrs{
    NSString* newContent = [content stringByReplacingRegex:@"<img src=.*>" options:NSRegularExpressionCaseInsensitive withString:kSeparator];
    [self.contents   addObjectsFromArray:[newContent componentsSeparatedByString:kSeparator]];
    [self.imageURLs  addObjectsFromArray:imageURLStrs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
