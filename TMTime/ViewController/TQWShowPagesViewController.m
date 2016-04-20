//
//  TQWShowPagesViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/19.
//  Copyright © 2016年 涂清文. All rights reserved.
//


#import "TQWShowPagesViewController.h"
#import "TQWScaleViewController.h"

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

- (YYLabel *)yyLable{
    if (!_yyLable) {
        self.scrolleView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        kWeakSelf(mySelf);
        [self.view addSubview:self.scrolleView];
        //self.scrolleView.delegate = self;
        [self.scrolleView addFooterRefershAnimation:^{
            [mySelf refreshTextLabel];
        
        }];
        [self.scrolleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(mySelf.view);
        }];
        self.scrolleView.bounces = YES ;
        self.automaticallyAdjustsScrollViewInsets = NO ;
        _yyLable = [YYLabel new];
        _yyLable.numberOfLines = 0 ;
        _yyLable.textVerticalAlignment = YYTextVerticalAlignmentTop;
        [self.scrolleView addSubview:_yyLable];
        [_yyLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(mySelf.view.width - 20);
            make.edges.mas_equalTo(UIEdgeInsetsMake(64, 10, 10, 10));
            make.height.mas_equalTo(800);
        }];
    }
    return _yyLable;
}
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
- (void) getAttributedString:(NSString*)string StringType:(StringType)type{
    NSMutableAttributedString *attachment = nil;
    UIFont *font = [UIFont systemFontOfSize:16];
    if (type == StringTypeImageUrl) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView loadImageWithURL:string];
        [imageView sizeToFit];
        [self addGesture:imageView];
        attachment = [NSMutableAttributedString
                                                 attachmentStringWithContent:imageView
                                                 contentMode:UIViewContentModeCenter
                                                 attachmentSize:imageView.size
                                                 alignToFont:font
                                                 alignment:YYTextVerticalAlignmentCenter];
       
    }
    if (type == StringTypeText) {
        attachment = [NSMutableAttributedString new];
        [attachment appendAttributedString:[[NSAttributedString alloc] initWithString:string attributes:nil]];
    }
    [attachment appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n" attributes:nil]];
    !attachment?:[self.text appendAttributedString:attachment];
    self.text.font = font;
    
    return ;
}
- (void)addShowContent{
    kWeakSelf(mySelf);
    for (NSInteger i  = 0 ; i < self.contents.count; i ++) {
        [mySelf getAttributedString:mySelf.contents[i] StringType:StringTypeText];
        if (i < mySelf.imageURLs.count) {
            [mySelf getAttributedString:mySelf.imageURLs[i] StringType:StringTypeImageUrl];
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
    CGRect frame = [self.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    self.hight = frame.size.height;
      kWeakSelf(mySelf);
    [self.yyLable mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(mySelf.hight);
    }];
    [self.yyLable needsUpdateConstraints];
    [self.yyLable updateConstraintsIfNeeded];
    [self.yyLable setNeedsLayout];
    [self.yyLable layoutIfNeeded];
    [self.scrolleView endedFooterRefersh];
}
- (void)viewWillLayoutSubviews{
    [super viewDidLayoutSubviews];
}

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

}
#pragma mark - 初始化方法
- (void)showDetailContent:(NSString *)content imageURLStrs:(NSArray <NSString *>*)imageURLStrs{
    NSString* newContent = [content stringByReplacingRegex:@"<img src=.*>" options:NSRegularExpressionCaseInsensitive withString:kSeparator];
    [self.contents   addObjectsFromArray:[newContent componentsSeparatedByString:kSeparator]];
    [self.imageURLs  addObjectsFromArray:imageURLStrs];
    [self addShowContent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
