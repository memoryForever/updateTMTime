//
//  TQWMainViewController.m
//  TMTime
//
//  Created by 涂清文 on 16/4/3.
//  Copyright © 2016年 涂清文. All rights reserved.
//

#import "TQWMainViewController.h"
#import "TQWMainViewModel.h"
#import "TQWMovieCollectionViewCell.h"
#import "constant.h"
#import "TQWInbriefTableViewCell.h"
#import "TQWMovieRatingViewController.h"
#import "TQWShowPagesViewController.h"
#import "TQWRollAnimation.h"
#import "TQWRefershAnimationVC.h"
#import "UIImage+getNetworkImage.h"


#define kHideTabbar self.tabBarController.tabBar.hidden   = YES
#define kAppearTabbar self.tabBarController.tabBar.hidden = NO
#define kMovieRatingSegue @"MovieRating"
#define kMovieRatingType250 @"MovieRatingType250"
#define kMovieRatingTypeNorthernAmericaBox @"MovieRatingTypeNorthernAmericaBox"

#define itemWidth 105
#define itemSpace 10
/** 消息的类型定义 **/
typedef NS_ENUM(NSUInteger ,movieNewType) {
    tmovieNewTypeNewMove = 0 ,
    tmovieNewTypeInbrief ,
    tmovieNewTypeNone ,
    tmovieNewTypeAtlas,
};

/** tableViewCell 定义 **/
#define movieNewTypeAtlas @"movieNewTypeAtlas"
#define movieNewTypeInbrief @"movieNewTypeInbrief"

/** 需要更改请同时该storyborad **/
#define InTheaterReusableCellIndentifier @"hotMovie"

@interface TQWMainViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

/** scrollview 属性 **/
@property (weak, nonatomic) IBOutlet UIImageView *topImageView;


/** 正在热映电影集合视图属性 **/
@property (weak, nonatomic) IBOutlet UICollectionView *MovieCollectionView;

/** 城市切换按钮 **/

@property (weak, nonatomic) IBOutlet UIButton *cityChangeButton;

/** 电影消息的视图属性 **/

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** ViewModel属性 **/
@property (nonatomic,strong)TQWMainViewModel *mainViewModel;


/** 计算属性 **/
@property (nonatomic,assign)CGFloat lineSpacing;
//事件响应
/** 250排行榜 **/
- (IBAction)into250RatingButton:(id)sender;
/** 北美票房榜 **/
- (IBAction)intoNABoxOffice:(id)sender;
/** 约影 **/
- (IBAction)intoTogeter:(id)sender;
/** 进入游戏 **/
- (IBAction)intoGame:(id)sender;
@property (nonatomic,strong) NSMutableArray<UIImage*> *imageArray;
@end

@implementation TQWMainViewController

#pragma mark - 懒加载 
-(TQWMainViewModel *)mainViewMain{
    if (!_mainViewModel) {
        _mainViewModel = [[TQWMainViewModel alloc]init];
    }
    
    return  _mainViewModel   ;
}
-(CGFloat)lineSpacing{
    return (kScreenW - itemWidth * 3) / 3 ;
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.mainViewModel itemNumber];
   
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TQWMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:InTheaterReusableCellIndentifier forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    cell.movieNameLabel.text = [self.mainViewModel movieTitleWithIndex:row];
    cell.movieRatingLabel.text = [self.mainViewModel movieRatingWithIndex:row];
    [cell.moviePoster loadImageWithURL:[self.mainViewModel  moviePosterWithIndex:row]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}
#pragma mark - collectionview layout delegate
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return itemSpace;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
     return self.lineSpacing ;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(12.5, self.lineSpacing/2, 12.5, self.lineSpacing/2);
}

#pragma mark - tableview Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.mainViewMain tableRowNumber];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = indexPath.row;
    UITableViewCell*  myCell = nil  ;
    if ([self.mainViewMain movieNewType:row] == tmovieNewTypeInbrief ) {
       TQWInbriefTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:movieNewTypeInbrief forIndexPath:indexPath];
        cell.inbriefTitleLabel.text = [self.mainViewMain movieNewTitle:row];
        cell.inbriefContentLabel.text = [self.mainViewMain movieNewContent:row];
        [cell.inbriefImageView noTranformloadImageWithURL: [self.mainViewMain movieNewImage:row]];
        myCell = cell;
    }
    if ([self.mainViewMain movieNewType:row] == tmovieNewTypeAtlas) {
        TQWAtlas *cell = [tableView dequeueReusableCellWithIdentifier:movieNewTypeAtlas forIndexPath:indexPath];
        cell.altasTitleLabel.text = [self.mainViewMain movieNewTitle:row];
        [cell.altasLeftImageView noTranformloadImageWithURL:[self.mainViewMain movieNewLeftImage:row]];
        [cell.altasCenterImageView noTranformloadImageWithURL:[self.mainViewMain movieNewCenterImage:row]];
        [cell.altasRightImageView noTranformloadImageWithURL:[self.mainViewMain movieNewRightImage:row]];
        myCell = cell;
    }
    
    return myCell ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    TQWShowPagesViewController *newShowPage = [[TQWShowPagesViewController alloc]init];
    [newShowPage showDetailContent:[self.mainViewModel movieNewContent:row] imageURLStrs:[self.mainViewModel movieNewImages:row]];
    
    [self loadImage:[self.mainViewModel movieNewImages:row] controller:newShowPage];
   
  //  [self.navigationController pushViewController:newShowPage animated:YES];
}


- (void)loadImage:(NSArray<NSString*>*)urlImages controller:(TQWShowPagesViewController*)count{
    
    self.imageArray = [NSMutableArray array];
    kWeakSelf(mySelf);
    if (urlImages.count) {
        [TQWRefershAnimationVC startAnimationAtController:self];
        [UIImage getNetworkImageURLs:urlImages saveImageArray:_imageArray completeHandler:^(NSError *error) {
            if (error) {
                NSLog(@"%@",error);
                return ;
            }
            [TQWRefershAnimationVC endAnimation];
            count.imageContainer  = mySelf.imageArray;
            [mySelf.navigationController pushViewController:count animated:YES];
        }];
    }else{
       [mySelf.navigationController pushViewController:count animated:YES]; 
    }
}

#pragma mark - touch 方法
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}
#pragma mark - selector 类方法事件的实现
- (void)changeCityButtonTitle{
    [self.cityChangeButton setTitle:kCurrentCityNameValue forState:UIControlStateNormal];
    //刷新当前城市正在热映的电影
    [self.mainViewModel refreshMovieInTheaters];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   
    if ([segue.identifier isEqualToString:kMovieRatingSegue]) {
        TQWMovieRatingViewController *ratingVC = segue.destinationViewController ;
        if ([kMovieRatingType250 isEqualToString:sender]) {
            ratingVC.Type = MovieRatingType250 ;
        }
        if ([kMovieRatingTypeNorthernAmericaBox isEqualToString:sender]) {
            ratingVC.Type = MovieRatingTypeNorthernAmericaBox ;
        }
    }
}
#pragma mark - 配置顶部imageView
- (void)setupTopImageView{
    self.automaticallyAdjustsScrollViewInsets = NO ;
    [self.view layoutIfNeeded];
    [self.view setNeedsLayout];
    NSArray *imageArray = @[[UIImage imageNamed:@"1.jpg"],
                            [UIImage imageNamed:@"2.jpg"],
                            [UIImage imageNamed:@"3.jpg"],
                            [UIImage imageNamed:@"4.jpg"],
                            [UIImage imageNamed:@"5.jpg"]];
    TQWRollAnimation *rollVC = [TQWRollAnimation addScrollAnimationAtViwe:_topImageView
                                                               imageArray:imageArray];
    [self addChildViewController:rollVC];
}

#pragma mark - 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTopImageView];
    kWeakSelf(mySelf);
    [self.mainViewMain getMovieInTheatersCompleteHandler:^(NSError *error) {
        if (error) {
            [mySelf.MovieCollectionView showFailure:@"数据载入出错,请检测网络"];
            return ;
        }
        [mySelf.MovieCollectionView reloadData];
    }];
    self.tableView.estimatedRowHeight = 350 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension    ;
    
    [self.tableView addHeadRefershAnimation:^{
       [mySelf.mainViewMain getMovieNewRefershType:RefershTypeUp startUpdata:^{
           kHideTabbar;
       } CompleteHandler:^(NSError *error) {
           [mySelf.tableView endedHeadRefersh];
           [mySelf.tableView reloadData];
           kAppearTabbar;
       }];
    }];
    [mySelf.tableView beginHeadRefersh];
    [mySelf.tableView addFooterRefersh:^{
       [mySelf.mainViewMain getMovieNewRefershType:RefershTypeDown startUpdata:^{
           kHideTabbar;
       } CompleteHandler:^(NSError *error) {
           [mySelf.tableView endedFooterRefersh];
           [mySelf.tableView reloadData];
           kAppearTabbar;
       }];
    }];
    [self.cityChangeButton setTitle:kCurrentCityNameValue forState:UIControlStateNormal];
    //监听城市变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCityButtonTitle) name:kCurrentCityChangeNotification object:nil];
}
- (void)viewDidLayoutSubviews{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

-(void)dealloc{
    //移除所有监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (IBAction)into250RatingButton:(id)sender {
    [self performSegueWithIdentifier:kMovieRatingSegue sender:kMovieRatingType250];
}

- (IBAction)intoNABoxOffice:(id)sender {
    [self performSegueWithIdentifier:kMovieRatingSegue sender:kMovieRatingTypeNorthernAmericaBox];
}

- (IBAction)intoTogeter:(id)sender {
}
- (IBAction)intoGame:(id)sender {
}
@end
