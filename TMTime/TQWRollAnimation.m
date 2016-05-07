//
//  TQWRollAnimation.m
//  TMtime
//
//  Created by tarena33 on 16/3/25.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "TQWRollAnimation.h"
#import <Masonry/Masonry.h>

@interface TQWRollAnimation () <UIScrollViewDelegate>
@property(nonatomic,strong)NSArray<UIImage *> *imageArray ;
@property(nonatomic,strong)UIScrollView *scrollView ;
@property(nonatomic,assign)NSInteger currentIndex ;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,weak)UIImageView *preImageView;
@property(nonatomic,weak)UIImageView *currentImageView;
@property(nonatomic,weak)UIImageView *nextImageView;
@property(nonatomic,weak)UIPageControl *page;
@property(nonatomic,strong)  UITapGestureRecognizer *tap;
@end

@implementation TQWRollAnimation
+(instancetype)addScrollAnimationAtViwe:(UIView *)superView imageArray:(NSArray<UIImage *> *)imageArray{
    TQWRollAnimation *vc = [[TQWRollAnimation alloc]init];
    superView.userInteractionEnabled = YES;
    vc.width = [UIScreen mainScreen].bounds.size.width ;
    vc.height =superView.bounds.size.height;
    vc.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,vc.width ,vc.height)];
    vc.scrollView.contentSize = CGSizeMake(vc.width * 3, vc.height);
    [superView addSubview:vc.scrollView];
    vc.imageArray = imageArray;
    vc.scrollView.backgroundColor = [UIColor redColor];
    vc.scrollView.contentOffset = CGPointMake(vc.width , 0);
    vc.view = vc.scrollView;
    //配置pageView
    UIPageControl *page = [[UIPageControl alloc]init];
    page.center = CGPointMake(vc.width * 0.5 , vc.height * 0.95);
    page.numberOfPages = imageArray.count ;
    page.currentPageIndicatorTintColor = [UIColor colorWithWhite:1 alpha:0.8];
    [superView addSubview:page];
    vc.page = page;
    [vc viewDidLoad];
    
    return vc ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.imageArray.count == 0) {
        return ;
    }
    
    self.scrollView.pagingEnabled = YES ;
    self.scrollView.showsHorizontalScrollIndicator = NO ;
    self.scrollView.bounces = NO ;
    [self setupImageView];
    [self setupImage];
    self.scrollView.delegate = self;
    _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickImage)];
    [_scrollView addGestureRecognizer:_tap];
    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoOffset) userInfo:nil repeats:YES];
}
-(void)autoOffset{
    __weak id myself = self;
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
       CGPoint  point  =  _scrollView.contentOffset;
        point.x += _width ;
        _scrollView.contentOffset = point ;
    } completion:^(BOOL finished) {
        [myself setCurrentIndex:[myself currentIndex]+1];
    }];

}
-(void)setupImageView{
  
    
    UIImageView *previousImageViw = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    UIImageView *currentImageViw = [[UIImageView alloc]initWithFrame:CGRectMake(_width, 0, _width, _height)];
    UIImageView *nextImageViw = [[UIImageView alloc]initWithFrame:CGRectMake(_width * 2, 0, _width, _height)];
    
    [self.scrollView addSubview:previousImageViw];
    [self.scrollView addSubview:currentImageViw];
    [self.scrollView addSubview:nextImageViw];
    _preImageView = previousImageViw;
    _nextImageView = nextImageViw ;
    _currentImageView = currentImageViw ;
   
}
-(void)clickImage{
    [self.delegate rollAnimationCurrentClickImageIndex:_currentIndex];
}
-(void)setupImage{
    NSInteger nextIndex =   _currentIndex + 1  > (_imageArray.count - 1) ? 0 : _currentIndex + 1 ;
    NSInteger previousIndex = _currentIndex -1 < 0 ? (_imageArray.count - 1): _currentIndex - 1 ;
   
    _preImageView.image = _imageArray[previousIndex];
    _currentImageView.image = _imageArray[_currentIndex];
   _nextImageView.image = _imageArray[nextIndex];
     self.page.pageIndicatorTintColor = [UIColor colorWithPatternImage:_currentImageView.image];

}
-(void)setCurrentIndex:(NSInteger)currentIndex
{
    if(currentIndex >(NSInteger)(_imageArray.count - 1))
    {
        currentIndex = 0 ;
    }
    if (currentIndex < 0 )
    {
        currentIndex = _imageArray.count -1;
    }
   
        _currentIndex = currentIndex;
        self.scrollView.contentOffset = CGPointMake(_width, 0);
        [self setupImage];
        self.page.currentPage = currentIndex  ;
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index =self.scrollView.contentOffset.x / _width;
        if (index > 1) {
           self.currentIndex ++ ;
        }
        if (index < 1 ) {
            self.currentIndex -- ;
        }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
