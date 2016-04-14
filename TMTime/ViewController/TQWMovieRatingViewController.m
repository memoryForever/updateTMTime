//
//  TQWMovieRatingViewController.m
//  TMTime
//
//  Created by tarena33 on 16/4/13.
//  Copyright © 2016年 涂清文. All rights reserved.
//
#import "TQWMovieRatingViewModel.h"
#import "TQWMovieRatingViewController.h"
#define kMovieRatingCellReuseIdentified @"MovieRatingCell"
#define kMovieRatingCellOne @"homepage_billboard_tag1"
#define kMovieRatingCellTwo @"homepage_billboard_tag2"
#define kMovieRatingCellThree @"homepage_billboard_tag3"



@interface TQWMovieRatingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *MovieImageView;
@property (weak, nonatomic) IBOutlet UIImageView *ratingLoginImage;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UILabel *theaterReleaseDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *summarizedLabel;

@end
@implementation TQWMovieRatingCell



@end


@interface TQWMovieRatingViewController ()<UITableViewDataSource,UITableViewDelegate>
//视图属性
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) TQWMovieRatingViewModel *movieRatingViewModel;

@end


@implementation TQWMovieRatingViewController


#pragma mark - 懒加载

- (TQWMovieRatingViewModel *)movieRatingViewModel{
    if (!_movieRatingViewModel) {
        _movieRatingViewModel = [TQWMovieRatingViewModel new];
    }
    return _movieRatingViewModel ;
}

#pragma mark - UITableViewDelegate UITableViewdataSource 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.movieRatingViewModel rowNumber];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TQWMovieRatingCell *cell = [tableView dequeueReusableCellWithIdentifier:kMovieRatingCellReuseIdentified forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    cell.titleNameLabel.text = [self.movieRatingViewModel movieNameWith:row];
    cell.directorLabel.text = [self.movieRatingViewModel movieDirectorWith:row];
    if (row < 3) {
        cell.ratingLoginImage.image = [UIImage imageNamed:@[kMovieRatingCellOne,kMovieRatingCellTwo,kMovieRatingCellThree][row]];
        //cell.ratingLoginImage.hidden = NO ;
    }else {
        cell.ratingLoginImage.image = [UIImage new];
    }
    [cell.MovieImageView loadImageWithURL:[self.movieRatingViewModel movieImageURLStringWith:row]];
    cell.theaterReleaseDateLabel.text = [self.movieRatingViewModel movietheaterReleaseDateWith:row];
    cell.summarizedLabel.text = [self.movieRatingViewModel movieSummarizedWith:row];
    return cell ;
}
#pragma  mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO ;
    kWeakSelf(mySelf);
    [self.movieRatingViewModel getMovieRatingType:_Type completeHandler:^(NSError *error) {
        [mySelf.tableView reloadData];
    }];
    [self.tableView addFooterRefersh:^{
        [mySelf.tableView reloadData];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

#pragma mark - 事件方法

@end
