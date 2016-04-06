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

#define kHideTabbar self.tabBarController.tabBar.hidden = YES
#define kAppearTabbar self.tabBarController.tabBar.hidden = NO

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


/** 正在热映电影集合视图属性 **/
@property (weak, nonatomic) IBOutlet UICollectionView *MovieCollectionView;

/** 电影消息的视图属性 **/

@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** ViewModel属性 **/
@property (nonatomic,strong)TQWMainViewModel *mainViewMain;


/** 计算属性 **/
@property (nonatomic,assign)CGFloat lineSpacing;
@end

@implementation TQWMainViewController

#pragma mark - 懒加载 
-(TQWMainViewModel *)mainViewMain{
    if (!_mainViewMain) {
        _mainViewMain = [[TQWMainViewModel alloc]init];
    }
    
    return  _mainViewMain   ;
}
-(CGFloat)lineSpacing{
    return (kScreenW - itemWidth * 3) / 3 ;
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.mainViewMain itemNumber];
   
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TQWMovieCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:InTheaterReusableCellIndentifier forIndexPath:indexPath];
    NSUInteger row = indexPath.row;
    cell.movieNameLabel.text = [self.mainViewMain movieTitleWithIndex:row];
    cell.movieRatingLabel.text = [self.mainViewMain movieRatingWithIndex:row];
    [cell.moviePoster loadImageWithURL:[self.mainViewMain  moviePosterWithIndex:row]];
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
#pragma mark - touch 方法
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

#pragma mark - 生命周期方法

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.mainViewMain getMovieInTheatersCompleteHandler:^(NSError *error) {
        if (error) {
            [self.MovieCollectionView showFailure:@"数据载入出错,请检测网络"];
            return ;
        }
        [self.MovieCollectionView reloadData];
    }];
    self.tableView.estimatedRowHeight = 350 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension    ;
    
    [self.tableView addHeadRefershAnimation:^{
       [self.mainViewMain getMovieNewRefershType:RefershTypeUp startUpdata:^{
           kHideTabbar;
       } CompleteHandler:^(NSError *error) {
           [self.tableView endedHeadRefersh];
           [self.tableView reloadData];
           kAppearTabbar;
       }];
    }];
    [self.tableView beginHeadRefersh];
    [self.tableView addFooterRefersh:^{
       [self.mainViewMain getMovieNewRefershType:RefershTypeDown startUpdata:^{
           kHideTabbar;
       } CompleteHandler:^(NSError *error) {
           [self.tableView endedFooterRefersh];
           [self.tableView reloadData];
           kAppearTabbar;
       }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
